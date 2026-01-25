/**
 * Email Lead Capture Integration
 * Webhook endpoint for email providers (SendGrid, Mailgun, Postmark, etc.)
 */

const express = require('express');
const router = express.Router();
const { processEmailWebhook } = require('../../../services/emailLeadCaptureService');

/**
 * POST /api/integrations/email/webhook
 * Generic email webhook endpoint
 * 
 * Supports:
 * - SendGrid Inbound Parse
 * - Mailgun Routes
 * - Postmark Inbound
 * - Custom forwarding services
 */
router.post('/webhook', async (req, res) => {
  try {
    console.log('[EMAIL_INTEGRATION] Received webhook');
    
    // Verify webhook secret if configured
    const expectedSecret = process.env.EMAIL_WEBHOOK_SECRET || process.env.WEBHOOK_SECRET;
    if (expectedSecret) {
      const providedSecret = req.headers['x-webhook-secret'] || 
                            req.headers['x-email-secret'] ||
                            req.body.secret;
      
      if (providedSecret !== expectedSecret) {
        console.warn('[EMAIL_INTEGRATION] Invalid webhook secret');
        return res.status(401).json({ 
          success: false, 
          error: 'unauthorized' 
        });
      }
    }

    // Normalize email data from different providers
    const emailData = normalizeEmailData(req.body, req.headers);

    if (!emailData.from || !emailData.to) {
      return res.status(400).json({
        success: false,
        error: 'Missing required fields: from, to'
      });
    }

    // Process email and create lead
    const result = await processEmailWebhook(emailData);

    return res.json({
      success: result.success,
      leadId: result.leadId,
      isNew: result.isNew,
      error: result.error
    });

  } catch (error) {
    console.error('[EMAIL_INTEGRATION] Webhook error:', error);
    return res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

/**
 * Normalize email data from different providers
 */
function normalizeEmailData(body, headers) {
  // SendGrid Inbound Parse format
  if (body.from && body.to && body.subject !== undefined) {
    return {
      from: extractEmail(body.from),
      fromName: extractName(body.from),
      to: extractEmail(body.to),
      subject: body.subject || '(No Subject)',
      text: body.text || '',
      html: body.html || '',
      headers: body.headers || {}
    };
  }

  // Mailgun format
  if (body.sender && body.recipient) {
    return {
      from: body.sender,
      fromName: body['from'] ? extractName(body['from']) : null,
      to: body.recipient,
      subject: body.subject || '(No Subject)',
      text: body['body-plain'] || body['stripped-text'] || '',
      html: body['body-html'] || body['stripped-html'] || '',
      headers: {}
    };
  }

  // Postmark format
  if (body.From && body.To) {
    return {
      from: extractEmail(body.From),
      fromName: extractName(body.From),
      to: extractEmail(body.To),
      subject: body.Subject || '(No Subject)',
      text: body.TextBody || '',
      html: body.HtmlBody || '',
      headers: body.Headers || {}
    };
  }

  // Generic format (custom)
  return {
    from: extractEmail(body.from || body.sender || body.From),
    fromName: body.fromName || body.from_name || extractName(body.from),
    to: extractEmail(body.to || body.recipient || body.To),
    subject: body.subject || body.Subject || '(No Subject)',
    text: body.text || body.body || body.TextBody || '',
    html: body.html || body.HtmlBody || '',
    headers: body.headers || {}
  };
}

/**
 * Extract email from "Name <email@domain.com>" format
 */
function extractEmail(str) {
  if (!str) return null;
  const match = str.match(/<([^>]+)>/);
  return match ? match[1] : str;
}

/**
 * Extract name from "Name <email@domain.com>" format
 */
function extractName(str) {
  if (!str) return null;
  const match = str.match(/^([^<]+)</);
  return match ? match[1].trim() : null;
}

/**
 * GET /api/integrations/email/test
 * Test endpoint to verify email integration is working
 */
router.get('/test', (req, res) => {
  res.json({
    success: true,
    message: 'Email integration endpoint is active',
    webhookUrl: '/api/integrations/email/webhook',
    supportedProviders: [
      'SendGrid Inbound Parse',
      'Mailgun Routes',
      'Postmark Inbound',
      'Custom Email Forwarding'
    ],
    setupInstructions: {
      sendgrid: 'Configure Inbound Parse to POST to this endpoint',
      mailgun: 'Create Route with action: forward("https://your-domain.com/api/integrations/email/webhook")',
      postmark: 'Add Inbound Webhook URL in Postmark settings',
      custom: 'Forward emails to this webhook with from, to, subject, text/html fields'
    }
  });
});

module.exports = router;
