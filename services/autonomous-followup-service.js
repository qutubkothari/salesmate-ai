/**
 * Autonomous Follow-up Service
 * 
 * Automated email/WhatsApp sequences with:
 * - Multi-step drip campaigns
 * - Trigger-based enrollment
 * - A/B testing
 * - Engagement tracking
 * - Smart scheduling
 */

const Database = require('better-sqlite3');
const { dbClient } = require('./config');

function usingSupabase() {
  return String(process.env.USE_SUPABASE || '') === 'true';
}

function ensureSequencesEnabled() {
  // Keep this opt-in to avoid accidental blasts.
  const enabled = String(process.env.ENABLE_AUTONOMOUS_SEQUENCES || '') === '1' ||
    String(process.env.ENABLE_SUPABASE_AUTONOMOUS_SEQUENCES || '') === '1';

  if (!enabled) {
    return { enabled: false, reason: 'disabled_by_default' };
  }

  return { enabled: true };
}

function mustHaveSupabase() {
  if (!dbClient || typeof dbClient.from !== 'function') {
    throw new Error('Supabase dbClient not configured. Set USE_SUPABASE=true and SUPABASE_URL/SUPABASE_SERVICE_KEY.');
  }
}

function asText(value) {
  if (value === undefined || value === null) return null;
  const s = String(value).trim();
  return s ? s : null;
}

class AutonomousFollowupService {
  /**
   * Create a new follow-up sequence
   */
  static async createSequence(tenantId, sequenceData, createdBy) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const payload = {
        tenant_id: asText(tenantId),
        sequence_name: asText(sequenceData?.name),
        sequence_type: asText(sequenceData?.type) || 'nurture',
        description: asText(sequenceData?.description),
        target_customer_type: asText(sequenceData?.targetCustomerType),
        target_deal_stage: asText(sequenceData?.targetDealStage),
        created_by: asText(createdBy),
      };

      if (!payload.tenant_id) throw new Error('tenantId required');
      if (!payload.sequence_name) throw new Error('Sequence name required');

      const { data, error } = await dbClient
        .from('followup_sequences')
        .insert(payload)
        .select('id')
        .single();

      if (error) throw new Error(error.message);
      return { sequenceId: data.id };
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const result = db.prepare(`
        INSERT INTO followup_sequences (
          tenant_id, sequence_name, sequence_type, description,
          target_customer_type, target_deal_stage, created_by
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
      `).run(
        tenantId,
        sequenceData.name,
        sequenceData.type || 'nurture',
        sequenceData.description || null,
        sequenceData.targetCustomerType || null,
        sequenceData.targetDealStage || null,
        createdBy
      );

      return { sequenceId: result.lastInsertRowid };

    } finally {
      db.close();
    }
  }

  /**
   * Add step to sequence
   */
  static async addStep(tenantId, sequenceId, stepData) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const skipWeekends = (stepData?.skipWeekends === undefined || stepData?.skipWeekends === null)
        ? true
        : Boolean(stepData.skipWeekends);

      const payload = {
        sequence_id: Number(sequenceId),
        tenant_id: asText(tenantId),
        step_number: Number(stepData?.stepNumber || 1),
        step_name: asText(stepData?.name) || `Step ${Number(stepData?.stepNumber || 1)}`,
        delay_days: Number(stepData?.delayDays || 0),
        delay_hours: Number(stepData?.delayHours || 0),
        send_time: asText(stepData?.sendTime),
        skip_weekends: skipWeekends,
        channel: asText(stepData?.channel),
        subject_line: asText(stepData?.subjectLine),
        message_body: asText(stepData?.messageBody),
        cta_text: asText(stepData?.ctaText),
        cta_url: asText(stepData?.ctaUrl),
      };

      if (!payload.tenant_id) throw new Error('tenantId required');
      if (!payload.sequence_id || Number.isNaN(payload.sequence_id)) throw new Error('sequenceId required');
      if (!payload.channel || !payload.message_body) throw new Error('Channel and message body required');

      const { data, error } = await dbClient
        .from('sequence_steps')
        .insert(payload)
        .select('id')
        .single();

      if (error) throw new Error(error.message);
      return { stepId: data.id };
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const result = db.prepare(`
        INSERT INTO sequence_steps (
          sequence_id, tenant_id, step_number, step_name,
          delay_days, delay_hours, send_time, skip_weekends,
          channel, subject_line, message_body,
          cta_text, cta_url
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).run(
        sequenceId,
        tenantId,
        stepData.stepNumber,
        stepData.name,
        stepData.delayDays || 0,
        stepData.delayHours || 0,
        stepData.sendTime || null,
        (stepData.skipWeekends === undefined || stepData.skipWeekends === null) ? 1 : (stepData.skipWeekends ? 1 : 0),
        stepData.channel,
        stepData.subjectLine || null,
        stepData.messageBody,
        stepData.ctaText || null,
        stepData.ctaUrl || null
      );

      return { stepId: result.lastInsertRowid };

    } finally {
      db.close();
    }
  }

  /**
   * List all sequences for tenant
   */
  static async listSequences(tenantId) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const { data, error } = await dbClient
        .from('followup_sequences')
        .select('*')
        .eq('tenant_id', asText(tenantId))
        .order('created_at', { ascending: false });

      if (error) throw new Error(error.message);

      return (data || []).map(seq => ({
        id: seq.id,
        name: seq.sequence_name,
        type: seq.sequence_type,
        description: seq.description,
        isActive: Boolean(seq.is_active),
        enrollments: seq.current_enrollments,
        totalSent: seq.total_sent,
        conversionRate: seq.conversion_rate,
        createdAt: seq.created_at,
      }));
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const sequences = db.prepare(`
        SELECT * FROM followup_sequences
        WHERE tenant_id = ?
        ORDER BY created_at DESC
      `).all(tenantId);

      return sequences.map(seq => ({
        id: seq.id,
        name: seq.sequence_name,
        type: seq.sequence_type,
        description: seq.description,
        isActive: seq.is_active === 1,
        enrollments: seq.current_enrollments,
        totalSent: seq.total_sent,
        conversionRate: seq.conversion_rate,
        createdAt: seq.created_at
      }));

    } finally {
      db.close();
    }
  }

  /**
   * Enroll contact in sequence
   */
  static async enrollContact(tenantId, sequenceId, enrollmentData, enrolledBy) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const customerId = asText(enrollmentData?.customerId);
      if (!customerId) throw new Error('Customer ID required');

      // Check if already enrolled
      const { data: existing, error: existingErr } = await dbClient
        .from('sequence_enrollments')
        .select('id')
        .eq('sequence_id', Number(sequenceId))
        .eq('customer_id', customerId)
        .in('enrollment_status', ['active', 'paused'])
        .limit(1);

      if (existingErr) throw new Error(existingErr.message);
      if (existing && existing.length) throw new Error('Contact already enrolled in this sequence');

      // Check unsubscribe status
      const unsubscribed = await this._checkUnsubscribeSupabase(asText(tenantId), customerId, Number(sequenceId));
      if (unsubscribed) throw new Error('Contact has unsubscribed from this sequence');

      // First step for scheduling
      const { data: firstStep, error: stepErr } = await dbClient
        .from('sequence_steps')
        .select('*')
        .eq('sequence_id', Number(sequenceId))
        .order('step_number', { ascending: true })
        .limit(1)
        .maybeSingle();

      if (stepErr) throw new Error(stepErr.message);
      if (!firstStep) throw new Error('Sequence has no steps');

      const nextSendAt = this._calculateNextSendTime(firstStep);

      const { data: created, error: createErr } = await dbClient
        .from('sequence_enrollments')
        .insert({
          sequence_id: Number(sequenceId),
          tenant_id: asText(tenantId),
          customer_id: customerId,
          contact_id: asText(enrollmentData?.contactId),
          deal_id: asText(enrollmentData?.dealId),
          enrolled_by: asText(enrolledBy),
          enrollment_source: asText(enrollmentData?.source) || 'manual',
          current_step: 0,
          next_send_at: nextSendAt,
        })
        .select('id')
        .single();

      if (createErr) throw new Error(createErr.message);

      // Update sequence enrollment count (best-effort)
      try {
        const { data: seqRow } = await dbClient
          .from('followup_sequences')
          .select('id,current_enrollments')
          .eq('id', Number(sequenceId))
          .maybeSingle();

        if (seqRow) {
          await dbClient
            .from('followup_sequences')
            .update({ current_enrollments: Number(seqRow.current_enrollments || 0) + 1 })
            .eq('id', Number(sequenceId));
        }
      } catch (_) {
        // ignore
      }

      return { enrollmentId: created.id };
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      // Check if already enrolled
      const existing = db.prepare(`
        SELECT id FROM sequence_enrollments
        WHERE sequence_id = ?
          AND customer_id = ?
          AND enrollment_status IN ('active', 'paused')
      `).get(sequenceId, enrollmentData.customerId);

      if (existing) {
        throw new Error('Contact already enrolled in this sequence');
      }

      // Check unsubscribe status
      const unsubscribed = this._checkUnsubscribe(db, tenantId, enrollmentData.customerId, sequenceId);
      if (unsubscribed) {
        throw new Error('Contact has unsubscribed from this sequence');
      }

      // Calculate first send time
      const firstStep = db.prepare(`
        SELECT * FROM sequence_steps
        WHERE sequence_id = ?
        ORDER BY step_number ASC
        LIMIT 1
      `).get(sequenceId);

      if (!firstStep) {
        throw new Error('Sequence has no steps');
      }

      const nextSendAt = this._calculateNextSendTime(firstStep);

      const result = db.prepare(`
        INSERT INTO sequence_enrollments (
          sequence_id, tenant_id, customer_id, contact_id, deal_id,
          enrolled_by, enrollment_source, current_step, next_send_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).run(
        sequenceId,
        tenantId,
        enrollmentData.customerId,
        enrollmentData.contactId || null,
        enrollmentData.dealId || null,
        enrolledBy,
        enrollmentData.source || 'manual',
        0,
        nextSendAt
      );

      // Update sequence enrollment count
      db.prepare(`
        UPDATE followup_sequences
        SET current_enrollments = current_enrollments + 1
        WHERE id = ?
      `).run(sequenceId);

      return { enrollmentId: result.lastInsertRowid };

    } finally {
      db.close();
    }
  }

  /**
   * Process sequences - send pending messages (cron job)
   */
  static async processSequences() {
    const enabledCheck = ensureSequencesEnabled();
    if (!enabledCheck.enabled) {
      return {
        disabled: true,
        reason: enabledCheck.reason,
        processed: 0,
        sent: 0,
        failed: 0,
        completed: 0,
      };
    }

    if (usingSupabase()) {
      mustHaveSupabase();

      const now = new Date().toISOString();
      const results = { processed: 0, sent: 0, failed: 0, completed: 0 };

      const { data: readyEnrollments, error: enrollErr } = await dbClient
        .from('sequence_enrollments')
        .select('*')
        .eq('enrollment_status', 'active')
        .not('next_send_at', 'is', null)
        .lte('next_send_at', now)
        .limit(100);

      if (enrollErr) throw new Error(enrollErr.message);

      for (const enrollment of readyEnrollments || []) {
        results.processed++;

        try {
          const nextStepNumber = Number(enrollment.current_step || 0) + 1;
          const { data: step, error: stepErr } = await dbClient
            .from('sequence_steps')
            .select('*')
            .eq('sequence_id', Number(enrollment.sequence_id))
            .eq('step_number', nextStepNumber)
            .maybeSingle();

          if (stepErr) throw new Error(stepErr.message);

          if (!step) {
            await dbClient
              .from('sequence_enrollments')
              .update({
                enrollment_status: 'completed',
                completed_at: new Date().toISOString(),
                next_send_at: null,
              })
              .eq('id', enrollment.id);
            results.completed++;
            continue;
          }

          const customer = await this._getCustomerForEnrollment(enrollment);
          if (!customer) {
            results.failed++;
            continue;
          }

          const personalizedMessage = this._personalizeMessage(step.message_body, customer, enrollment);
          const personalizedSubject = step.subject_line
            ? this._personalizeMessage(step.subject_line, customer, enrollment)
            : null;

          const recipient = step.channel === 'email' ? customer.email : (customer.phone || customer.customer_phone);
          const recipientText = asText(recipient);
          if (!recipientText) {
            results.failed++;
            continue;
          }

          // Create message record as pending
          const { data: createdMsg, error: msgErr } = await dbClient
            .from('sequence_messages')
            .insert({
              enrollment_id: Number(enrollment.id),
              step_id: Number(step.id),
              tenant_id: asText(enrollment.tenant_id),
              channel: asText(step.channel),
              recipient_contact: recipientText,
              subject_line: personalizedSubject,
              message_body: personalizedMessage,
              scheduled_send_at: now,
              delivery_status: 'pending',
            })
            .select('id')
            .single();

          if (msgErr) throw new Error(msgErr.message);

          try {
            await this._sendMessage(step.channel, recipientText, personalizedSubject, personalizedMessage, enrollment.tenant_id);

            await dbClient
              .from('sequence_messages')
              .update({ delivery_status: 'sent', actual_sent_at: new Date().toISOString() })
              .eq('id', createdMsg.id);
          } catch (sendErr) {
            await dbClient
              .from('sequence_messages')
              .update({ delivery_status: 'failed', failure_reason: String(sendErr?.message || sendErr) })
              .eq('id', createdMsg.id);
            results.failed++;
            continue;
          }

          // Next send time
          const { data: nextStep, error: nextStepErr } = await dbClient
            .from('sequence_steps')
            .select('*')
            .eq('sequence_id', Number(enrollment.sequence_id))
            .eq('step_number', nextStepNumber + 1)
            .maybeSingle();

          if (nextStepErr) throw new Error(nextStepErr.message);
          const nextSendAt = nextStep ? this._calculateNextSendTime(nextStep, now) : null;

          await dbClient
            .from('sequence_enrollments')
            .update({
              current_step: nextStepNumber,
              next_send_at: nextSendAt,
              total_messages_sent: Number(enrollment.total_messages_sent || 0) + 1,
            })
            .eq('id', enrollment.id);

          // Stats (best-effort)
          try {
            await dbClient
              .from('sequence_steps')
              .update({ sent_count: Number(step.sent_count || 0) + 1 })
              .eq('id', step.id);

            const { data: seqRow } = await dbClient
              .from('followup_sequences')
              .select('id,total_sent,total_opened,total_clicked,total_replied,total_converted,current_enrollments')
              .eq('id', Number(enrollment.sequence_id))
              .maybeSingle();

            if (seqRow) {
              await dbClient
                .from('followup_sequences')
                .update({ total_sent: Number(seqRow.total_sent || 0) + 1 })
                .eq('id', seqRow.id);
            }
          } catch (_) {
            // ignore
          }

          results.sent++;
        } catch (err) {
          console.error(`Error processing enrollment ${enrollment?.id}:`, err);
          results.failed++;
        }
      }

      return results;
    }

    // SQLite implementation (legacy/local)
    // Keep it disabled unless explicitly enabled.
    if (String(process.env.ENABLE_SQLITE_AUTONOMOUS_SEQUENCES || '') !== '1') {
      return {
        disabled: true,
        reason: 'sqlite_disabled',
        processed: 0,
        sent: 0,
        failed: 0,
        completed: 0,
      };
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const now = new Date().toISOString();

      // Get enrollments ready to send
      const readyEnrollments = db.prepare(`
        SELECT * FROM sequence_enrollments
        WHERE enrollment_status = 'active'
          AND next_send_at IS NOT NULL
          AND next_send_at <= ?
        LIMIT 100
      `).all(now);

      const results = {
        processed: 0,
        sent: 0,
        failed: 0,
        completed: 0
      };

      for (const enrollment of readyEnrollments) {
        results.processed++;

        try {
          // Get next step
          const nextStepNumber = enrollment.current_step + 1;
          const step = db.prepare(`
            SELECT * FROM sequence_steps
            WHERE sequence_id = ?
              AND step_number = ?
          `).get(enrollment.sequence_id, nextStepNumber);

          if (!step) {
            // Sequence completed
            db.prepare(`
              UPDATE sequence_enrollments
              SET enrollment_status = 'completed',
                  completed_at = CURRENT_TIMESTAMP
              WHERE id = ?
            `).run(enrollment.id);
            results.completed++;
            continue;
          }

          // Get customer details
          const customer = db.prepare(`
            SELECT * FROM customers
            WHERE id = ?
          `).get(enrollment.customer_id);

          if (!customer) {
            results.failed++;
            continue;
          }

          // Personalize message
          const personalizedMessage = this._personalizeMessage(
            step.message_body,
            customer,
            enrollment
          );

          const personalizedSubject = step.subject_line 
            ? this._personalizeMessage(step.subject_line, customer, enrollment)
            : null;

          // Determine recipient
          const recipient = step.channel === 'email' ? customer.email : customer.phone;

          if (!recipient) {
            results.failed++;
            continue;
          }

          // Create message record
          const messageId = db.prepare(`
            INSERT INTO sequence_messages (
              enrollment_id, step_id, tenant_id,
              channel, recipient_contact, subject_line, message_body,
              scheduled_send_at, actual_sent_at, delivery_status
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 'sent')
          `).run(
            enrollment.id,
            step.id,
            enrollment.tenant_id,
            step.channel,
            recipient,
            personalizedSubject,
            personalizedMessage,
            now
          ).lastInsertRowid;

          // Send message via WhatsApp service
          const sendResult = await this._sendMessage(
            step.channel, 
            recipient, 
            personalizedSubject, 
            personalizedMessage,
            enrollment.tenant_id
          );

          // Update enrollment
          const nextStep = db.prepare(`
            SELECT * FROM sequence_steps
            WHERE sequence_id = ?
              AND step_number = ?
          `).get(enrollment.sequence_id, nextStepNumber + 1);

          const nextSendAt = nextStep ? this._calculateNextSendTime(nextStep, now) : null;

          db.prepare(`
            UPDATE sequence_enrollments
            SET current_step = ?,
                next_send_at = ?,
                total_messages_sent = total_messages_sent + 1
            WHERE id = ?
          `).run(nextStepNumber, nextSendAt, enrollment.id);

          // Update step stats
          db.prepare(`
            UPDATE sequence_steps
            SET sent_count = sent_count + 1
            WHERE id = ?
          `).run(step.id);

          // Update sequence stats
          db.prepare(`
            UPDATE followup_sequences
            SET total_sent = total_sent + 1
            WHERE id = ?
          `).run(enrollment.sequence_id);

          results.sent++;

        } catch (err) {
          console.error(`Error processing enrollment ${enrollment.id}:`, err);
          results.failed++;
        }
      }

      return results;

    } finally {
      db.close();
    }
  }

  /**
   * Pause sequence
   */
  static async pauseSequence(tenantId, sequenceId) {
    if (usingSupabase()) {
      mustHaveSupabase();
      await dbClient
        .from('followup_sequences')
        .update({ is_active: false })
        .eq('id', Number(sequenceId))
        .eq('tenant_id', asText(tenantId));

      await dbClient
        .from('sequence_enrollments')
        .update({ enrollment_status: 'paused' })
        .eq('sequence_id', Number(sequenceId))
        .eq('enrollment_status', 'active');

      return;
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      db.prepare(`
        UPDATE followup_sequences
        SET is_active = 0
        WHERE id = ? AND tenant_id = ?
      `).run(sequenceId, tenantId);

      // Pause all active enrollments
      db.prepare(`
        UPDATE sequence_enrollments
        SET enrollment_status = 'paused'
        WHERE sequence_id = ?
          AND enrollment_status = 'active'
      `).run(sequenceId);

    } finally {
      db.close();
    }
  }

  /**
   * Activate sequence
   */
  static async activateSequence(tenantId, sequenceId) {
    if (usingSupabase()) {
      mustHaveSupabase();
      await dbClient
        .from('followup_sequences')
        .update({ is_active: true })
        .eq('id', Number(sequenceId))
        .eq('tenant_id', asText(tenantId));

      await dbClient
        .from('sequence_enrollments')
        .update({ enrollment_status: 'active' })
        .eq('sequence_id', Number(sequenceId))
        .eq('enrollment_status', 'paused');

      return;
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      db.prepare(`
        UPDATE followup_sequences
        SET is_active = 1
        WHERE id = ? AND tenant_id = ?
      `).run(sequenceId, tenantId);

      // Resume paused enrollments
      db.prepare(`
        UPDATE sequence_enrollments
        SET enrollment_status = 'active'
        WHERE sequence_id = ?
          AND enrollment_status = 'paused'
      `).run(sequenceId);

    } finally {
      db.close();
    }
  }

  /**
   * Track message opened
   */
  static async trackOpen(messageId) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const { data: message, error } = await dbClient
        .from('sequence_messages')
        .select('*')
        .eq('id', Number(messageId))
        .maybeSingle();

      if (error) throw new Error(error.message);
      if (!message) return;

      const isFirstOpen = !message.opened_at;
      const now = new Date().toISOString();

      await dbClient
        .from('sequence_messages')
        .update({
          opened_at: message.opened_at || now,
          open_count: Number(message.open_count || 0) + 1,
        })
        .eq('id', Number(messageId));

      if (isFirstOpen) {
        const { data: enrollment } = await dbClient
          .from('sequence_enrollments')
          .select('*')
          .eq('id', Number(message.enrollment_id))
          .maybeSingle();

        if (enrollment) {
          await dbClient
            .from('sequence_enrollments')
            .update({ total_opened: Number(enrollment.total_opened || 0) + 1 })
            .eq('id', enrollment.id);
        }

        const { data: step } = await dbClient
          .from('sequence_steps')
          .select('*')
          .eq('id', Number(message.step_id))
          .maybeSingle();

        if (step) {
          await dbClient
            .from('sequence_steps')
            .update({ opened_count: Number(step.opened_count || 0) + 1 })
            .eq('id', step.id);
        }

        if (enrollment) {
          const { data: seq } = await dbClient
            .from('followup_sequences')
            .select('*')
            .eq('id', Number(enrollment.sequence_id))
            .maybeSingle();

          if (seq) {
            const totalOpened = Number(seq.total_opened || 0) + 1;
            const totalSent = Number(seq.total_sent || 0);
            const openRate = totalSent > 0 ? totalOpened / totalSent : 0;
            await dbClient
              .from('followup_sequences')
              .update({ total_opened: totalOpened, open_rate: openRate })
              .eq('id', seq.id);
          }
        }
      }

      return;
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const message = db.prepare('SELECT * FROM sequence_messages WHERE id = ?').get(messageId);
      if (!message) return;

      const isFirstOpen = !message.opened_at;

      db.prepare(`
        UPDATE sequence_messages
        SET opened_at = COALESCE(opened_at, CURRENT_TIMESTAMP),
            open_count = open_count + 1
        WHERE id = ?
      `).run(messageId);

      if (isFirstOpen) {
        // Update enrollment
        db.prepare(`
          UPDATE sequence_enrollments
          SET total_opened = total_opened + 1
          WHERE id = ?
        `).run(message.enrollment_id);

        // Update step stats
        db.prepare(`
          UPDATE sequence_steps
          SET opened_count = opened_count + 1
          WHERE id = ?
        `).run(message.step_id);

        // Update sequence stats
        const enrollment = db.prepare('SELECT * FROM sequence_enrollments WHERE id = ?').get(message.enrollment_id);
        db.prepare(`
          UPDATE followup_sequences
          SET total_opened = total_opened + 1,
              open_rate = CAST(total_opened AS REAL) / CAST(total_sent AS REAL)
          WHERE id = ?
        `).run(enrollment.sequence_id);
      }

    } finally {
      db.close();
    }
  }

  /**
   * Track link clicked
   */
  static async trackClick(messageId) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const { data: message, error } = await dbClient
        .from('sequence_messages')
        .select('*')
        .eq('id', Number(messageId))
        .maybeSingle();

      if (error) throw new Error(error.message);
      if (!message) return;

      const isFirstClick = !message.first_clicked_at;
      const now = new Date().toISOString();

      await dbClient
        .from('sequence_messages')
        .update({
          first_clicked_at: message.first_clicked_at || now,
          click_count: Number(message.click_count || 0) + 1,
        })
        .eq('id', Number(messageId));

      if (isFirstClick) {
        const { data: enrollment } = await dbClient
          .from('sequence_enrollments')
          .select('*')
          .eq('id', Number(message.enrollment_id))
          .maybeSingle();

        if (enrollment) {
          await dbClient
            .from('sequence_enrollments')
            .update({ total_clicked: Number(enrollment.total_clicked || 0) + 1 })
            .eq('id', enrollment.id);
        }

        const { data: step } = await dbClient
          .from('sequence_steps')
          .select('*')
          .eq('id', Number(message.step_id))
          .maybeSingle();

        if (step) {
          await dbClient
            .from('sequence_steps')
            .update({ clicked_count: Number(step.clicked_count || 0) + 1 })
            .eq('id', step.id);
        }

        if (enrollment) {
          const { data: seq } = await dbClient
            .from('followup_sequences')
            .select('*')
            .eq('id', Number(enrollment.sequence_id))
            .maybeSingle();

          if (seq) {
            const totalClicked = Number(seq.total_clicked || 0) + 1;
            const totalSent = Number(seq.total_sent || 0);
            const clickRate = totalSent > 0 ? totalClicked / totalSent : 0;
            await dbClient
              .from('followup_sequences')
              .update({ total_clicked: totalClicked, click_rate: clickRate })
              .eq('id', seq.id);
          }
        }
      }

      return;
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const message = db.prepare('SELECT * FROM sequence_messages WHERE id = ?').get(messageId);
      if (!message) return;

      const isFirstClick = !message.first_clicked_at;

      db.prepare(`
        UPDATE sequence_messages
        SET first_clicked_at = COALESCE(first_clicked_at, CURRENT_TIMESTAMP),
            click_count = click_count + 1
        WHERE id = ?
      `).run(messageId);

      if (isFirstClick) {
        db.prepare(`
          UPDATE sequence_enrollments
          SET total_clicked = total_clicked + 1
          WHERE id = ?
        `).run(message.enrollment_id);

        db.prepare(`
          UPDATE sequence_steps
          SET clicked_count = clicked_count + 1
          WHERE id = ?
        `).run(message.step_id);

        const enrollment = db.prepare('SELECT * FROM sequence_enrollments WHERE id = ?').get(message.enrollment_id);
        db.prepare(`
          UPDATE followup_sequences
          SET total_clicked = total_clicked + 1,
              click_rate = CAST(total_clicked AS REAL) / CAST(total_sent AS REAL)
          WHERE id = ?
        `).run(enrollment.sequence_id);
      }

    } finally {
      db.close();
    }
  }

  /**
   * Track reply
   */
  static async trackReply(messageId, replyText) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const now = new Date().toISOString();
      await dbClient
        .from('sequence_messages')
        .update({ replied_at: now, reply_text: asText(replyText) })
        .eq('id', Number(messageId));

      const { data: message, error } = await dbClient
        .from('sequence_messages')
        .select('*')
        .eq('id', Number(messageId))
        .maybeSingle();

      if (error) throw new Error(error.message);
      if (!message) return;

      const { data: enrollment } = await dbClient
        .from('sequence_enrollments')
        .select('*')
        .eq('id', Number(message.enrollment_id))
        .maybeSingle();

      if (enrollment) {
        await dbClient
          .from('sequence_enrollments')
          .update({ total_replied: Number(enrollment.total_replied || 0) + 1 })
          .eq('id', enrollment.id);
      }

      const { data: step } = await dbClient
        .from('sequence_steps')
        .select('*')
        .eq('id', Number(message.step_id))
        .maybeSingle();

      if (step) {
        await dbClient
          .from('sequence_steps')
          .update({ replied_count: Number(step.replied_count || 0) + 1 })
          .eq('id', step.id);
      }

      if (enrollment) {
        const { data: seq } = await dbClient
          .from('followup_sequences')
          .select('*')
          .eq('id', Number(enrollment.sequence_id))
          .maybeSingle();

        if (seq) {
          const totalReplied = Number(seq.total_replied || 0) + 1;
          const totalSent = Number(seq.total_sent || 0);
          const replyRate = totalSent > 0 ? totalReplied / totalSent : 0;
          await dbClient
            .from('followup_sequences')
            .update({ total_replied: totalReplied, reply_rate: replyRate })
            .eq('id', seq.id);
        }
      }

      return;
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      db.prepare(`
        UPDATE sequence_messages
        SET replied_at = CURRENT_TIMESTAMP,
            reply_text = ?
        WHERE id = ?
      `).run(replyText, messageId);

      const message = db.prepare('SELECT * FROM sequence_messages WHERE id = ?').get(messageId);

      db.prepare(`
        UPDATE sequence_enrollments
        SET total_replied = total_replied + 1
        WHERE id = ?
      `).run(message.enrollment_id);

      db.prepare(`
        UPDATE sequence_steps
        SET replied_count = replied_count + 1
        WHERE id = ?
      `).run(message.step_id);

      const enrollment = db.prepare('SELECT * FROM sequence_enrollments WHERE id = ?').get(message.enrollment_id);
      db.prepare(`
        UPDATE followup_sequences
        SET total_replied = total_replied + 1,
            reply_rate = CAST(total_replied AS REAL) / CAST(total_sent AS REAL)
        WHERE id = ?
      `).run(enrollment.sequence_id);

    } finally {
      db.close();
    }
  }

  /**
   * Mark enrollment as converted
   */
  static async markConverted(enrollmentId, conversionValue = 0) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const { data: enrollment, error: enrollErr } = await dbClient
        .from('sequence_enrollments')
        .select('*')
        .eq('id', Number(enrollmentId))
        .maybeSingle();

      if (enrollErr) throw new Error(enrollErr.message);
      if (!enrollment) return;

      await dbClient
        .from('sequence_enrollments')
        .update({
          converted: true,
          converted_at: new Date().toISOString(),
          conversion_value: Number(conversionValue || 0),
          enrollment_status: 'completed',
          completed_at: new Date().toISOString(),
        })
        .eq('id', enrollment.id);

      const { data: seq } = await dbClient
        .from('followup_sequences')
        .select('*')
        .eq('id', Number(enrollment.sequence_id))
        .maybeSingle();

      if (seq) {
        const totalConverted = Number(seq.total_converted || 0) + 1;
        const denom = Number(seq.current_enrollments || 0) || 0;
        const conversionRate = denom > 0 ? totalConverted / denom : 0;
        await dbClient
          .from('followup_sequences')
          .update({ total_converted: totalConverted, conversion_rate: conversionRate })
          .eq('id', seq.id);
      }

      return;
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      db.prepare(`
        UPDATE sequence_enrollments
        SET converted = 1,
            converted_at = CURRENT_TIMESTAMP,
            conversion_value = ?,
            enrollment_status = 'completed'
        WHERE id = ?
      `).run(conversionValue, enrollmentId);

      const enrollment = db.prepare('SELECT * FROM sequence_enrollments WHERE id = ?').get(enrollmentId);
      
      db.prepare(`
        UPDATE followup_sequences
        SET total_converted = total_converted + 1,
            conversion_rate = CAST(total_converted AS REAL) / CAST(current_enrollments AS REAL)
        WHERE id = ?
      `).run(enrollment.sequence_id);

    } finally {
      db.close();
    }
  }

  /**
   * Get sequence performance
   */
  static async getSequencePerformance(sequenceId) {
    if (usingSupabase()) {
      mustHaveSupabase();

      const { data: sequence, error: seqErr } = await dbClient
        .from('followup_sequences')
        .select('*')
        .eq('id', Number(sequenceId))
        .maybeSingle();

      if (seqErr) throw new Error(seqErr.message);
      if (!sequence) throw new Error('Sequence not found');

      const { data: steps, error: stepsErr } = await dbClient
        .from('sequence_steps')
        .select('*')
        .eq('sequence_id', Number(sequenceId))
        .order('step_number', { ascending: true });

      if (stepsErr) throw new Error(stepsErr.message);

      const { data: enrollments, error: enrollErr } = await dbClient
        .from('sequence_enrollments')
        .select('enrollment_status')
        .eq('sequence_id', Number(sequenceId));

      if (enrollErr) throw new Error(enrollErr.message);

      const breakdown = {};
      for (const row of enrollments || []) {
        breakdown[row.enrollment_status] = (breakdown[row.enrollment_status] || 0) + 1;
      }

      return {
        sequence: {
          id: sequence.id,
          name: sequence.sequence_name,
          type: sequence.sequence_type,
          isActive: Boolean(sequence.is_active),
        },
        performance: {
          totalEnrollments: sequence.current_enrollments,
          totalSent: sequence.total_sent,
          totalOpened: sequence.total_opened,
          totalClicked: sequence.total_clicked,
          totalReplied: sequence.total_replied,
          totalConverted: sequence.total_converted,
          openRate: sequence.open_rate,
          clickRate: sequence.click_rate,
          replyRate: sequence.reply_rate,
          conversionRate: sequence.conversion_rate,
        },
        steps: (steps || []).map(step => ({
          stepNumber: step.step_number,
          name: step.step_name,
          channel: step.channel,
          sent: step.sent_count,
          opened: step.opened_count,
          clicked: step.clicked_count,
          replied: step.replied_count,
          openRate: step.sent_count > 0 ? (step.opened_count / step.sent_count) * 100 : 0,
        })),
        enrollmentBreakdown: breakdown,
      };
    }

    const db = new Database(process.env.DB_PATH || 'local-database.db');

    try {
      const sequence = db.prepare('SELECT * FROM followup_sequences WHERE id = ?').get(sequenceId);
      if (!sequence) throw new Error('Sequence not found');

      const steps = db.prepare(`
        SELECT * FROM sequence_steps
        WHERE sequence_id = ?
        ORDER BY step_number ASC
      `).all(sequenceId);

      const enrollmentStats = db.prepare(`
        SELECT 
          enrollment_status,
          COUNT(*) as count
        FROM sequence_enrollments
        WHERE sequence_id = ?
        GROUP BY enrollment_status
      `).all(sequenceId);

      return {
        sequence: {
          id: sequence.id,
          name: sequence.sequence_name,
          type: sequence.sequence_type,
          isActive: sequence.is_active === 1
        },
        performance: {
          totalEnrollments: sequence.current_enrollments,
          totalSent: sequence.total_sent,
          totalOpened: sequence.total_opened,
          totalClicked: sequence.total_clicked,
          totalReplied: sequence.total_replied,
          totalConverted: sequence.total_converted,
          openRate: sequence.open_rate,
          clickRate: sequence.click_rate,
          replyRate: sequence.reply_rate,
          conversionRate: sequence.conversion_rate
        },
        steps: steps.map(step => ({
          stepNumber: step.step_number,
          name: step.step_name,
          channel: step.channel,
          sent: step.sent_count,
          opened: step.opened_count,
          clicked: step.clicked_count,
          replied: step.replied_count,
          openRate: step.sent_count > 0 ? (step.opened_count / step.sent_count) * 100 : 0
        })),
        enrollmentBreakdown: enrollmentStats.reduce((acc, row) => {
          acc[row.enrollment_status] = row.count;
          return acc;
        }, {})
      };

    } finally {
      db.close();
    }
  }

  // Helper methods
  static _calculateNextSendTime(step, fromTime = null) {
    const baseTime = fromTime ? new Date(fromTime) : new Date();
    
    // Add delay
    baseTime.setDate(baseTime.getDate() + step.delay_days);
    baseTime.setHours(baseTime.getHours() + step.delay_hours);

    // Apply preferred send time if set
    if (step.send_time) {
      const [hours, minutes] = step.send_time.split(':').map(Number);
      baseTime.setHours(hours, minutes, 0, 0);
    }

    // Skip weekends if configured
    if (step.skip_weekends) {
      const dayOfWeek = baseTime.getDay();
      if (dayOfWeek === 0) { // Sunday
        baseTime.setDate(baseTime.getDate() + 1);
      } else if (dayOfWeek === 6) { // Saturday
        baseTime.setDate(baseTime.getDate() + 2);
      }
    }

    return baseTime.toISOString();
  }

  static _personalizeMessage(template, customer, enrollment) {
    let personalized = template;

    // Replace placeholders
    const customerName = customer.customer_name || customer.business_name || customer.customer_name || customer.contact_person || 'there';
    const companyName = customer.company_name || customer.business_name || customer.customer_name || '';
    const contactPerson = customer.contact_person || customer.contact_name || '';

    personalized = personalized.replace(/\{\{customer_name\}\}/g, customerName);
    personalized = personalized.replace(/\{\{company_name\}\}/g, companyName);
    personalized = personalized.replace(/\{\{contact_person\}\}/g, contactPerson);

    return personalized;
  }

  static _checkUnsubscribe(db, tenantId, customerId, sequenceId) {
    const unsubscribe = db.prepare(`
      SELECT * FROM sequence_unsubscribes
      WHERE tenant_id = ?
        AND customer_id = ?
        AND (unsubscribe_type = 'all_sequences' OR sequence_id = ?)
    `).get(tenantId, customerId, sequenceId);

    return !!unsubscribe;
  }

  static async _checkUnsubscribeSupabase(tenantId, customerId, sequenceId) {
    mustHaveSupabase();
    if (!tenantId || !customerId) return false;

    const orClause = `unsubscribe_type.eq.all_sequences,sequence_id.eq.${Number(sequenceId)}`;
    const { data, error } = await dbClient
      .from('sequence_unsubscribes')
      .select('id')
      .eq('tenant_id', asText(tenantId))
      .eq('customer_id', asText(customerId))
      .or(orClause)
      .limit(1);

    if (error) throw new Error(error.message);
    return !!(data && data.length);
  }

  static async _getCustomerForEnrollment(enrollment) {
    mustHaveSupabase();

    const customerId = asText(enrollment?.customer_id);
    const tenantId = asText(enrollment?.tenant_id);
    if (!customerId) return null;

    // Prefer the new schema
    const { data: profile, error } = await dbClient
      .from('customer_profiles_new')
      .select('*')
      .eq('id', customerId)
      .eq('tenant_id', tenantId)
      .maybeSingle();

    if (!error && profile) return profile;

    // Fallback to legacy table name
    const { data: legacy, error: legacyErr } = await dbClient
      .from('customer_profiles')
      .select('*')
      .eq('id', customerId)
      .eq('tenant_id', tenantId)
      .maybeSingle();

    if (legacyErr) return null;
    return legacy || null;
  }

  // Backward-compat alias for route typo
  static async markConversion(enrollmentId, conversionValue = 0) {
    return this.markConverted(enrollmentId, conversionValue);
  }

  /**
   * Send message via WhatsApp or Email
   * @private
   */
  static async _sendMessage(channel, recipient, subject, messageBody, tenantId) {
    try {
      if (channel === 'whatsapp') {
        // Send via WhatsApp
        const { sendMessage } = require('./whatsappService');
        const messageId = await sendMessage(recipient, messageBody, tenantId);

        if (!messageId) {
          throw new Error('WhatsApp send failed (provider returned null)');
        }

        console.log(`[FOLLOWUP] WhatsApp sent to ${recipient}`);
        return { success: true, channel: 'whatsapp', messageId };
        
      } else if (channel === 'email') {
        // Send via Email (if email service is configured)
        const emailService = require('./emailService');
        const emailResult = await emailService.sendEmail({
          to: recipient,
          subject: subject,
          body: messageBody,
          tenantId: tenantId
        });

        if (emailResult === false) {
          throw new Error('Email send failed');
        }
        
        console.log(`[FOLLOWUP] Email sent to ${recipient}`);
        return { success: true, channel: 'email' };
        
      } else {
        throw new Error(`Unsupported channel: ${channel}`);
      }
      
    } catch (error) {
      console.error(`[FOLLOWUP] Failed to send ${channel} to ${recipient}:`, error.message);
      throw error;
    }
  }
}

module.exports = AutonomousFollowupService;
