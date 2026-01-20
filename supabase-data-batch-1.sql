-- ============================================
-- Data Migration SQL
-- Generated: 2026-01-20T02:40:52.006Z
-- ============================================


-- Data for: ai_conversation_messages (1 rows)
INSERT INTO ai_conversation_messages (id, session_id, tenant_id, message_direction, message_type, message_content, detected_intent, detected_entities, sentiment_score, urgency_level, is_ai_response, ai_model_used, ai_confidence, response_time, human_reviewed, human_edited, review_note, timestamp) VALUES
  ('71d8e36f8de69aa6cd29fbeb5e237cbd', '4d29b7de08ac45951bac082ee070b879', 'default-tenant', 'incoming', 'text', 'Hi, what is the price of product ABC-123?', 'pricing_inquiry', '{"product_code":"abc-123","quantity":50,"price":123}', 0, 'high', 0, NULL, NULL, NULL, 0, 0, NULL, '2026-01-18 07:48:16')
ON CONFLICT DO NOTHING;



-- Data for: ai_conversation_sessions (1 rows)
INSERT INTO ai_conversation_sessions (id, tenant_id, customer_id, phone_number, session_start, session_end, session_status, current_intent, current_topic, conversation_stage, customer_sentiment, ai_confidence_score, human_handoff_requested, human_agent_id, handoff_reason, message_count, ai_response_count, human_response_count, avg_response_time, session_duration, language, channel, device_info, created_at, updated_at) VALUES
  ('4d29b7de08ac45951bac082ee070b879', 'default-tenant', 'customer-123', '+919876543210', '2026-01-18 07:48:16', NULL, 'active', 'pricing_inquiry', 'product', 'discovery', 'positive', 0.85, 0, NULL, NULL, 1, 0, 1, NULL, NULL, 'en', 'whatsapp', NULL, '2026-01-18 07:48:16', '2026-01-18 07:48:17')
ON CONFLICT DO NOTHING;



-- Data for: api_keys (1 rows)
INSERT INTO api_keys (id, tenant_id, name, key_hash, key_prefix, last_used_at, revoked_at, created_at) VALUES
  ('130499fe807453f0d4b1314c7e6ca0d0', '101f04af63cbefc2bf8f0a98b9ae1205', 'Gmail OAuth Access', 'ac912ddd01b514d935a507d8447c34ea315ac0955bd460ff15790bb2eb88f83b', 'smk_5edf9740', '2026-01-11T05:14:23.543Z', NULL, '2026-01-11T04:40:15.239Z')
ON CONFLICT DO NOTHING;



-- Data for: assignment_config (1 rows)
INSERT INTO assignment_config (id, tenant_id, strategy, auto_assign, consider_capacity, consider_score, consider_skills, custom_rules, active, created_at, updated_at) VALUES
  (1, '101f04af63cbefc2bf8f0a98b9ae1205', 'ROUND_ROBIN', TRUE, TRUE, FALSE, FALSE, NULL, TRUE, '2026-01-11 07:37:27', '2026-01-11 07:37:27')
ON CONFLICT DO NOTHING;



-- Data for: broadcast_campaigns (1 rows)
INSERT INTO broadcast_campaigns (id, tenant_id, campaign_name, campaign_type, campaign_status, target_segment, target_criteria, target_count, message_template, message_variables, media_url, media_type, scheduled_start, scheduled_end, send_interval, sent_count, delivered_count, read_count, replied_count, failed_count, ai_optimization_enabled, ai_send_time_optimization, ai_content_variants, click_through_rate, conversion_rate, revenue_generated, created_by, created_at, updated_at) VALUES
  ('abb1de8384589f7acdae98d636c30287', 'default-tenant', 'New Year Special Offer', 'promotional', 'draft', 'active_customers', '{}', NULL, 'Hi {{customer_name}}, enjoy 20% off on all products! Valid till Jan 31. Order now!', '{"discount":"20%","validity":"Jan 31"}', NULL, NULL, NULL, NULL, 1000, 0, 0, 0, 0, 0, 1, 0, 0, NULL, NULL, NULL, 'admin', '2026-01-18 07:48:17', '2026-01-18 07:48:17')
ON CONFLICT DO NOTHING;



-- Data for: broadcast_processing_lock (1 rows)
INSERT INTO broadcast_processing_lock (id, is_processing, process_id, started_at, last_heartbeat) VALUES
  (1, 0, NULL, NULL, NULL)
ON CONFLICT DO NOTHING;



-- Data for: conversation_context (1 rows)
INSERT INTO conversation_context (id, session_id, tenant_id, context_key, context_value, context_type, expires_at, is_active, created_at, updated_at) VALUES
  ('79c1c7826cc2b7cc48cc7817abcc4286', '4d29b7de08ac45951bac082ee070b879', 'default-tenant', 'inquired_product', 'ABC-123', 'string', '2026-01-18T08:18:16.988Z', 1, '2026-01-18 07:48:16', '2026-01-18 07:48:16')
ON CONFLICT DO NOTHING;



-- Data for: crawl_jobs (2 rows)
INSERT INTO crawl_jobs (id, tenant_id, url, status, error_message, pages_crawled, chunks_created, created_at, completed_at) VALUES
  ('3943ae1f3a59d20f59ddfca82929312a', '101f04af63cbefc2bf8f0a98b9ae1205', 'https://salesmate.saksolution.com/', 'completed', NULL, 5, 5, '2026-01-10 10:55:08', '2026-01-10T10:55:17.665Z'),
  ('3b8d493d6e3fcfe56b279a49ec20628d', '101f04af63cbefc2bf8f0a98b9ae1205', 'https://saksolution.ae/', 'completed', NULL, 11, 11, '2026-01-12 12:09:58', '2026-01-12T12:10:18.122Z')
ON CONFLICT DO NOTHING;



-- Data for: deal_activities (5 rows)
INSERT INTO deal_activities (id, deal_id, activity_type, subject, description, performed_by, performed_at, duration_minutes, outcome, next_action, attachments) VALUES
  ('955cdc064cc525558dbbbe516a6c811d', 'b85da4e3708558520fbaa8786f4aa228', 'note', 'Initial Contact', 'Initial contact established. Customer interested in ERP Integration.', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '2026-01-18T06:49:48.393Z', NULL, NULL, NULL, NULL),
  ('91b0c0ef3f803212dea7279c502fcef2', 'acecdb7f4ccd0a367812cc488656ac8b', 'note', 'Initial Contact', 'Initial contact established. Customer interested in CRM Implementation.', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '2026-01-18T06:49:48.408Z', NULL, NULL, NULL, NULL),
  ('9c62db292810784a46c78c3e66702140', '5143fdb6f1e1a3736de42bfa9bae207c', 'note', 'Initial Contact', 'Initial contact established. Customer interested in Software License.', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '2026-01-18T06:49:48.408Z', NULL, NULL, NULL, NULL),
  ('25b7e1c95e2e1ea266a761412887da37', '7b914c29018c3f23cce7fbcde50a38bb', 'note', 'Initial Contact', 'Initial contact established. Customer interested in Cloud Migration.', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '2026-01-18T06:49:48.409Z', NULL, NULL, NULL, NULL),
  ('9a8e4906ac335fcd07ce5bc0538875c9', '01d61cb0f939179deb57749c80d6ad3c', 'note', 'Initial Contact', 'Initial contact established. Customer interested in POS System.', 'b8a48b98-8bba-4382-b024-6c1a35038f39', '2026-01-18T06:49:48.410Z', NULL, NULL, NULL, NULL)
ON CONFLICT DO NOTHING;



-- Data for: deals (6 rows)
INSERT INTO deals (id, tenant_id, deal_name, customer_id, contact_person, pipeline_id, stage_id, owner_id, deal_value, currency, expected_revenue, discount_amount, discount_percentage, created_date, expected_close_date, actual_close_date, last_activity_date, description, source, priority, score, temperature, status, lost_reason, won_details, competitors, tags, custom_fields, created_at, updated_at) VALUES
  ('85fb818b8af71c63dff82bf45ca091cd', '101f04af63cbefc2bf8f0a98b9ae1205', 'ABC Corp - ERP Integration', NULL, NULL, '26e9c496435a8626997fba5b16e301c6', '8fa66cc20e959c62d9f78f0b6f2b72c0', 'b8a48b98-8bba-4382-b024-6c1a35038f39', 250000, 'INR', 150000, 0, 0, '2026-01-18 06:49:36', '2026-02-02', NULL, NULL, NULL, NULL, 'high', 0, 'hot', 'open', NULL, NULL, NULL, NULL, NULL, '2026-01-18T06:49:36.860Z', '2026-01-18T06:49:36.860Z'),
  ('b85da4e3708558520fbaa8786f4aa228', '101f04af63cbefc2bf8f0a98b9ae1205', 'ABC Corp - ERP Integration', NULL, NULL, '095424f316cd663ba49897f00faff05d', '0f582b5945bd1d73ff9f949bfefffee7', 'b8a48b98-8bba-4382-b024-6c1a35038f39', 250000, 'INR', 150000, 0, 0, '2026-01-18 06:49:48', '2026-02-02', NULL, NULL, NULL, NULL, 'high', 0, 'hot', 'open', NULL, NULL, NULL, NULL, NULL, '2026-01-18T06:49:48.393Z', '2026-01-18T06:49:48.393Z'),
  ('acecdb7f4ccd0a367812cc488656ac8b', '101f04af63cbefc2bf8f0a98b9ae1205', 'XYZ Ltd - CRM Implementation', NULL, NULL, '095424f316cd663ba49897f00faff05d', '18ceb648f7280c7a1b7a06fdc185a688', 'b8a48b98-8bba-4382-b024-6c1a35038f39', 180000, 'INR', 144000, 0, 0, '2026-01-18 06:49:48', '2026-01-25', NULL, NULL, NULL, NULL, 'critical', 0, 'hot', 'open', NULL, NULL, NULL, NULL, NULL, '2026-01-18T06:49:48.407Z', '2026-01-18T06:49:48.407Z'),
  ('5143fdb6f1e1a3736de42bfa9bae207c', '101f04af63cbefc2bf8f0a98b9ae1205', 'TechStart Inc - Software License', NULL, NULL, '095424f316cd663ba49897f00faff05d', 'e775dcf504dcb3ee3ee4e484943b006a', 'b8a48b98-8bba-4382-b024-6c1a35038f39', 95000, 'INR', 38000, 0, 0, '2026-01-18 06:49:48', '2026-02-17', NULL, NULL, NULL, NULL, 'medium', 0, 'warm', 'open', NULL, NULL, NULL, NULL, NULL, '2026-01-18T06:49:48.408Z', '2026-01-18T06:49:48.408Z'),
  ('7b914c29018c3f23cce7fbcde50a38bb', '101f04af63cbefc2bf8f0a98b9ae1205', 'GlobalTrade - Cloud Migration', NULL, NULL, '095424f316cd663ba49897f00faff05d', 'a0e55f6cc7ea1b13b0c5b3548fc5e35d', 'b8a48b98-8bba-4382-b024-6c1a35038f39', 420000, 'INR', 105000, 0, 0, '2026-01-18 06:49:48', '2026-03-04', NULL, NULL, NULL, NULL, 'high', 0, 'warm', 'open', NULL, NULL, NULL, NULL, NULL, '2026-01-18T06:49:48.409Z', '2026-01-18T06:49:48.409Z'),
  ('01d61cb0f939179deb57749c80d6ad3c', '101f04af63cbefc2bf8f0a98b9ae1205', 'RetailChain - POS System', NULL, NULL, '095424f316cd663ba49897f00faff05d', '2c61f16972278f34320691c719c25cc5', 'b8a48b98-8bba-4382-b024-6c1a35038f39', 75000, 'INR', 7500, 0, 0, '2026-01-18 06:49:48', '2026-03-19', NULL, NULL, NULL, NULL, 'low', 0, 'cold', 'open', NULL, NULL, NULL, NULL, NULL, '2026-01-18T06:49:48.409Z', '2026-01-18T06:49:48.409Z')
ON CONFLICT DO NOTHING;



-- Data for: document_branding (1 rows)
INSERT INTO document_branding (id, tenant_id, company_name, company_logo_url, company_address, company_city, company_state, company_country, company_pincode, company_phone, company_email, company_website, tax_registration_number, business_registration, primary_color, secondary_color, accent_color, font_family, show_watermark, watermark_text, updated_at) VALUES
  ('64ed87521c478e98670b27b152e99f61', 'default-tenant', 'SakSolution Technologies', NULL, '123 Business Street', 'Mumbai', 'Maharashtra', 'India', '400001', '+91 22 1234 5678', 'info@saksolution.com', 'https://saksolution.com', 'GSTIN1234567890', NULL, '#007bff', '#6c757d', '#28a745', 'Arial, sans-serif', 0, NULL, '2026-01-18 07:39:16')
ON CONFLICT DO NOTHING;



-- Data for: document_templates (2 rows)
INSERT INTO document_templates (id, tenant_id, template_name, template_type, description, template_format, template_body, header_content, footer_content, css_styles, page_size, page_orientation, margins, is_default, is_active, version, language, auto_number, number_prefix, number_format, current_sequence, tags, category, created_by, created_at, updated_at) VALUES
  ('61f50f32d13e9088c7fa12ccd17c79de', 'default-tenant', 'Standard Invoice', 'invoice', 'Standard invoice template with company branding', 'html', '
          <div class="invoice">
            <h1>INVOICE</h1>
            <p><strong>Invoice Number:</strong> {{document.number}}</p>
            <p><strong>Date:</strong> {{document.date}}</p>
            
            <h3>Bill To:</h3>
            <p>{{customer.name}}</p>
            <p>{{customer.address}}</p>
            
            <h3>Items:</h3>
            <table>
              <thead>
                <tr>
                  <th>Description</th>
                  <th>Quantity</th>
                  <th>Unit Price</th>
                  <th>Total</th>
                </tr>
              </thead>
              <tbody>
                {{#each line_items}}
                <tr>
                  <td>{{product_name}}</td>
                  <td>{{quantity}}</td>
                  <td>₹{{unit_price}}</td>
                  <td>₹{{total}}</td>
                </tr>
                {{/each}}
              </tbody>
            </table>
            
            <div class="total">
              <p><strong>Total Amount:</strong> ₹{{total_amount}}</p>
            </div>
          </div>
        ', NULL, NULL, 'body { font-family: Arial; } .invoice { padding: 20px; } table { width: 100%; border-collapse: collapse; } th, td { padding: 8px; border-bottom: 1px solid #ddd; } .total { margin-top: 20px; font-size: 1.2em; }', 'A4', 'portrait', '{"top":20,"right":20,"bottom":20,"left":20}', 1, 1, 1, 'en', 1, 'INV-', '{PREFIX}{YEAR}{MONTH}{SEQUENCE}', 1, '["invoice","standard"]', NULL, 'admin', '2026-01-18 07:39:16', '2026-01-18 07:39:16'),
  ('49abe806f85427605f8b15e93f5f897e', 'default-tenant', 'Standard Quotation', 'quotation', 'Customer quotation template', 'html', '<div><h1>QUOTATION</h1><p>Quote #{{document.number}}</p><p>Valid until: {{quote.valid_until}}</p></div>', NULL, NULL, NULL, 'A4', 'portrait', '{"top":20,"right":20,"bottom":20,"left":20}', 1, 1, 1, 'en', 1, 'QT-', '{PREFIX}{YEAR}{MONTH}{SEQUENCE}', 0, '[]', NULL, 'admin', '2026-01-18 07:39:16', '2026-01-18 07:39:16')
ON CONFLICT DO NOTHING;



-- Data for: email_enquiries (10 rows)
INSERT INTO email_enquiries (id, tenant_id, from_email, subject, body, received_at, raw, created_at, message_id, thread_id, snippet, is_read, read_at, lead_conversation_id, lead_customer_profile_id, lead_created_at, assigned_to, category, intent, confidence_score, extracted_products, is_relevant, salesman_id, auto_assigned, assignment_reason, replied_at, reply_count) VALUES
  ('f38e270708e9bcf4b4104c02e73d6d11', '101f04af63cbefc2bf8f0a98b9ae1205', 'Google <no-reply@accounts.google.com>', 'Security alert', '[image: Google]
You allowed saksolution.com access to some of your Google Account data


kothariqutub@gmail.com

If you didn’t allow saksolution.com access to some of your Google Account
data, someone else may be trying to access your Google Account data.

Take a moment now to check your account activity and secure your account.
Check activity
<https://accounts.google.com/AccountChooser?Email=kothariqutub@gmail.com&continue=https://myaccount.google.com/alert/nt/1768106998000?rfn%3D127%26rfnc%3D1%26eid%3D-7666039405514079124%26et%3D0>
To make changes at any time to the access that saksolution.com has to your
data, go to your Google Account
<https://accounts.google.com/AccountChooser?Email=kothariqutub@gmail.com&continue=https://myaccount.google.com/connections/overview/ASjxo9E27gD-HDvToaOSA3jxkufBT5UFOQZiPdlwlB5s87QkWE-gaIXOVSwcuJuWue-cV9Z7uxTPFlCV5LetGeSFrdA?utm_source%3Dsec_alert%26utm_medium%3Demail_notification%26force_all%3Dtrue>
You can also see security activity at
https://myaccount.google.com/notifications
You received this email to let you know about important changes to your
Google Account and services.
© 2026 Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA
', '2026-01-11T04:49:58.000Z', '{"id":"19bab63beaddb9cc","threadId":"19bab63beaddb9cc","labelIds":["UNREAD","IMPORTANT","CATEGORY_UPDATES","INBOX"],"snippet":"You allowed saksolution.com access to some of your Google Account data kothariqutub@gmail.com If you didn&#39;t allow saksolution.com access to some of your Google Account data, someone else may be","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2566520pxc;        Sat, 10 Jan 2026 20:49:59 -0800 (PST)"},{"name":"X-Received","value":"by 2002:a05:620a:bc8:b0:8c3:6f44:46cc with SMTP id af79cd13be357-8c389356331mr1987988585a.12.1768106999528;        Sat, 10 Jan 2026 20:49:59 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768106999; cv=none;        d=google.com; s=arc-20240605;        b=CHPBpB/ZnyOO3FqUqOaL1rBhHUzok8Z6orzkAluLX8r0m9M1uKC7IgfFZRP5ucvWX0         U5AhKY7U+ElvD5tP0Gld2Rnt0TeD3KYJqtPkjQnrZ/SduvXk8FE6e/eByCxwjTKlAHP/         o396ZX9O+xaAs0gMZ/6XmDhaPgcG0p+2OUy5tvY4Qulm1kjD2Ztt99k5+Hae0EuXEb6M         H8DUkcQ/WLfzqf9hwVSwZbYa33lLD2fxF/17XoBN1yTemr1lE5uo+82l0K3L2KKESrws         bWHFf1ovfzefABMGowKc1+bLB87tvEno9HfmiRusL/0l2huyWt3eZYPPXXzp8g6pvj4Y         lerw=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=to:from:subject:message-id:gmsai:feedback-id:date:mime-version         :dkim-signature;        bh=RG91asSwl8ZxkSH6DNTsYMX/WrsbMJ+B59A5GvnO0p4=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=iVk6O7Uy3/0zGk6bs2GzotOJ2PwzZcNk+icpCckTrIXp+V0TQJXMgnJg5BZymdgBqU         8zBOzVXhHoenRS6IhL9rv7EjiYs6z3+16Nv4Hq9tkDqYyhVqdMgCcVloRiKJMlrBmp+m         brlnN4DVWx9TbxcuQAq/dTy7u/9pNdY8n7S1Zc5AVJ713UdGDf6rrs/VQz7m+A8fYl5X         UZyIYHq8O09DCaglucVqNvW7X8IN4TtDFbMtcqwMlnPv4MoC1y3Mq/HljEEgEaEzn99t         ZBOy06fzsEqiX5sR/0HlIcs1LDxD5VDCGYwJmJBh8+/m3BiuYXzyAwfLJdoZFzMo5Z8V         yS+g==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@accounts.google.com header.s=20230601 header.b=BqgLu7hM;       spf=pass (google.com: domain of 39ytjaqgtdc4xy-bozvikmmyexdc.qyyqvo.mywuydrkbsaedelqwksv.myw@gaia.bounces.google.com designates 209.85.220.73 as permitted sender) smtp.mailfrom=39ytjaQgTDC4XY-bOZViKMMYeXdc.QYYQVO.MYWUYdRKbSaedeLQWKSV.MYW@gaia.bounces.google.com;       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=accounts.google.com;       dara=pass header.i=@gmail.com"},{"name":"Return-Path","value":"<39ytjaQgTDC4XY-bOZViKMMYeXdc.QYYQVO.MYWUYdRKbSaedeLQWKSV.MYW@gaia.bounces.google.com>"},{"name":"Received","value":"from mail-sor-f73.google.com (mail-sor-f73.google.com. [209.85.220.73])        by mx.google.com with SMTPS id af79cd13be357-8c37f50653fsor956371085a.18.2026.01.10.20.49.59        for <kothariqutub@gmail.com>        (Google Transport Security);        Sat, 10 Jan 2026 20:49:59 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of 39ytjaqgtdc4xy-bozvikmmyexdc.qyyqvo.mywuydrkbsaedelqwksv.myw@gaia.bounces.google.com designates 209.85.220.73 as permitted sender) client-ip=209.85.220.73;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@accounts.google.com header.s=20230601 header.b=BqgLu7hM;       spf=pass (google.com: domain of 39ytjaqgtdc4xy-bozvikmmyexdc.qyyqvo.mywuydrkbsaedelqwksv.myw@gaia.bounces.google.com designates 209.85.220.73 as permitted sender) smtp.mailfrom=39ytjaQgTDC4XY-bOZViKMMYeXdc.QYYQVO.MYWUYdRKbSaedeLQWKSV.MYW@gaia.bounces.google.com;       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=accounts.google.com;       dara=pass header.i=@gmail.com"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; c=relaxed/relaxed;        d=accounts.google.com; s=20230601; t=1768106999; x=1768711799; dara=google.com;        h=to:from:subject:message-id:gmsai:feedback-id:date:mime-version:from         :to:cc:subject:date:message-id:reply-to;        bh=RG91asSwl8ZxkSH6DNTsYMX/WrsbMJ+B59A5GvnO0p4=;        b=BqgLu7hMcw9DsN/8Of2ioJjJ0EX23RXQMK2XDjjA7ET8D3WN+b8yNybaZfr29g5czK         pWNNzonle4U7HDxKigT9g5+ANFaGflzBTNPCtA/gNxZd5eNLTXvwtU7oVePZHztrI+HH         iWSuqUTicOXwG9rk33d8y8IytlFBaw2BrOLNpQQVAb3s8Qg4tAa8eGypso7hFLkhErB7         yic89qd2nhx+HAuTW0Dk/veC1Mz/hPOgVmFziIA33fOawgB048Owwk5YOSrIXqL7MOUf         UbKRGJI/cNO0MYjsrSfnGg5rzTjuQHbe6Vb3bt2LB0Mh/jbZ7OYkiB0wUEPCRj3mU1gl         7OFA=="},{"name":"X-Google-DKIM-Signature","value":"v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20230601; t=1768106999; x=1768711799;        h=to:from:subject:message-id:gmsai:feedback-id:date:mime-version         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;        bh=RG91asSwl8ZxkSH6DNTsYMX/WrsbMJ+B59A5GvnO0p4=;        b=PfA+aRDK6Fa2DYanivSb8XBuHlTvuJYbFQhrsB2FU0WRqFYlL/9SxidZSmPRB3Hltq         8OkOuH2rzckM9yo6ySbXakdKins8qFqJURJXAYr53YFsBm6zTMfNqSs9bwASvUwMP8Qq         wBpQCAlBvYkUUYsRdSn3edBu/1SqkC0GIkNog84VyEr5fcflNV7xt5EimGh7XJ7LwJd6         YnMQJRSQ9quT2mtlILDpwykAgng8eXnK9Z5Qu3jgCQ1cdbZXEKL9WKIaGUTKEIACcy/h         Y9ZluHKrK9Lukqpwk3tU3XX2/1Nqn5oAJyH/e38Dgb6caWMR8mP/22w/efpXj9kZ8MvT         YFSA=="},{"name":"X-Gm-Message-State","value":"AOJu0Ywpfh4oiz+8mVjwN5Rj+XQ/2v9vy478WFyXsN7rZ6JxyLI1+rHy xYDhEOIx1ml3jyLrb66fB49r+PF/w/oOQxoBZEwKGY8otrXtXzzQOAhMo2Zxhe+4MLxF4H96Nyf sQK/7Cc7JLcAX87Vyk/bGkqnYxUEYDK6QyaCYV+4ARg=="},{"name":"X-Google-Smtp-Source","value":"AGHT+IH4d/tA9UP+tvnNfCiwetKwLb6yVBmr2tSg18PdG2Z8PKZtQvod2LmI3L+YcIF45+Z7EQ7b3Bjo9tHmHB63U2SYvw=="},{"name":"MIME-Version","value":"1.0"},{"name":"X-Received","value":"by 2002:ac8:588f:0:b0:501:144a:f447 with SMTP id d75a77b69052e-501144af555mr81765371cf.9.1768106999101; Sat, 10 Jan 2026 20:49:59 -0800 (PST)"},{"name":"Date","value":"Sun, 11 Jan 2026 04:49:58 GMT"},{"name":"X-Account-Notification-Type","value":"127"},{"name":"Feedback-ID","value":"127:account-notifier"},{"name":"gmsai","value":"true"},{"name":"X-Notifications","value":"43d6da3c63660000"},{"name":"X-Notifications-Bounce-Info","value":"Ae2mSnw8JPCTyA66gj-ZAdLzaMHsnzAniWc_-6u1IhXSR9krLZGIMDtjS80Ryjd2ZDpJR1jm2mWbBW0BOCoKRFq3Y3NfJCgza01Aec3LmMSoeQVm7J_BNWdp7EFvY55WAIUKm_n2J9NjZxaY22fVMTGA4VluaeC-I-D2PrdG2NwwyfoX076pvq80tTfD9KelLVRV0BUDJkyEvZlzzYrmipld7Xt0jy0ymw44-BmuEjkNjAwNjA0MDQxNTM1NTk2OTMzMg"},{"name":"Message-ID","value":"<QACkq6xn0SEX0WdO3F5cWg@notifications.google.com>"},{"name":"Subject","value":"Security alert"},{"name":"From","value":"Google <no-reply@accounts.google.com>"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Content-Type","value":"multipart/alternative; boundary=\"0000000000009b39fe0648157d6d\""}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/plain","filename":"","headers":[{"name":"Content-Type","value":"text/plain; charset=\"UTF-8\"; format=flowed; delsp=yes"},{"name":"Content-Transfer-Encoding","value":"base64"}],"body":{"size":1228,"data":"W2ltYWdlOiBHb29nbGVdDQpZb3UgYWxsb3dlZCBzYWtzb2x1dGlvbi5jb20gYWNjZXNzIHRvIHNvbWUgb2YgeW91ciBHb29nbGUgQWNjb3VudCBkYXRhDQoNCg0Ka290aGFyaXF1dHViQGdtYWlsLmNvbQ0KDQpJZiB5b3UgZGlkbuKAmXQgYWxsb3cgc2Frc29sdXRpb24uY29tIGFjY2VzcyB0byBzb21lIG9mIHlvdXIgR29vZ2xlIEFjY291bnQNCmRhdGEsIHNvbWVvbmUgZWxzZSBtYXkgYmUgdHJ5aW5nIHRvIGFjY2VzcyB5b3VyIEdvb2dsZSBBY2NvdW50IGRhdGEuDQoNClRha2UgYSBtb21lbnQgbm93IHRvIGNoZWNrIHlvdXIgYWNjb3VudCBhY3Rpdml0eSBhbmQgc2VjdXJlIHlvdXIgYWNjb3VudC4NCkNoZWNrIGFjdGl2aXR5DQo8aHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL0FjY291bnRDaG9vc2VyP0VtYWlsPWtvdGhhcmlxdXR1YkBnbWFpbC5jb20mY29udGludWU9aHR0cHM6Ly9teWFjY291bnQuZ29vZ2xlLmNvbS9hbGVydC9udC8xNzY4MTA2OTk4MDAwP3JmbiUzRDEyNyUyNnJmbmMlM0QxJTI2ZWlkJTNELTc2NjYwMzk0MDU1MTQwNzkxMjQlMjZldCUzRDA-DQpUbyBtYWtlIGNoYW5nZXMgYXQgYW55IHRpbWUgdG8gdGhlIGFjY2VzcyB0aGF0IHNha3NvbHV0aW9uLmNvbSBoYXMgdG8geW91cg0KZGF0YSwgZ28gdG8geW91ciBHb29nbGUgQWNjb3VudA0KPGh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbS9BY2NvdW50Q2hvb3Nlcj9FbWFpbD1rb3RoYXJpcXV0dWJAZ21haWwuY29tJmNvbnRpbnVlPWh0dHBzOi8vbXlhY2NvdW50Lmdvb2dsZS5jb20vY29ubmVjdGlvbnMvb3ZlcnZpZXcvQVNqeG85RTI3Z0QtSER2VG9hT1NBM2p4a3VmQlQ1VUZPUVppUGRsd2xCNXM4N1FrV0UtZ2FJWE9WU3djdUp1V3VlLWNWOVo3dXhUUEZsQ1Y1TGV0R2VTRnJkQT91dG1fc291cmNlJTNEc2VjX2FsZXJ0JTI2dXRtX21lZGl1bSUzRGVtYWlsX25vdGlmaWNhdGlvbiUyNmZvcmNlX2FsbCUzRHRydWU-DQpZb3UgY2FuIGFsc28gc2VlIHNlY3VyaXR5IGFjdGl2aXR5IGF0DQpodHRwczovL215YWNjb3VudC5nb29nbGUuY29tL25vdGlmaWNhdGlvbnMNCllvdSByZWNlaXZlZCB0aGlzIGVtYWlsIHRvIGxldCB5b3Uga25vdyBhYm91dCBpbXBvcnRhbnQgY2hhbmdlcyB0byB5b3VyDQpHb29nbGUgQWNjb3VudCBhbmQgc2VydmljZXMuDQrCqSAyMDI2IEdvb2dsZSBMTEMsIDE2MDAgQW1waGl0aGVhdHJlIFBhcmt3YXksIE1vdW50YWluIFZpZXcsIENBIDk0MDQzLCBVU0ENCg=="}},{"partId":"1","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=\"UTF-8\""},{"name":"Content-Transfer-Encoding","value":"quoted-printable"}],"body":{"size":5571,"data":"PCFET0NUWVBFIGh0bWw-PGh0bWwgbGFuZz0iZW4iPjxoZWFkPjxtZXRhIG5hbWU9ImZvcm1hdC1kZXRlY3Rpb24iIGNvbnRlbnQ9ImVtYWlsPW5vIi8-PG1ldGEgbmFtZT0iZm9ybWF0LWRldGVjdGlvbiIgY29udGVudD0iZGF0ZT1ubyIvPjxzdHlsZSBub25jZT0icU9wSWtBbGNKaWhZVHNiNE81OHNLUSI-LmF3bCBhIHtjb2xvcjogI0ZGRkZGRjsgdGV4dC1kZWNvcmF0aW9uOiBub25lO30gLmFibWwgYSB7Y29sb3I6ICMwMDAwMDA7IGZvbnQtZmFtaWx5OiBSb2JvdG8tTWVkaXVtLEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmOyBmb250LXdlaWdodDogYm9sZDsgdGV4dC1kZWNvcmF0aW9uOiBub25lO30gLmFkZ2wgYSB7Y29sb3I6IHJnYmEoMCwgMCwgMCwgMC44Nyk7IHRleHQtZGVjb3JhdGlvbjogbm9uZTt9IC5hZmFsIGEge2NvbG9yOiAjYjBiMGIwOyB0ZXh0LWRlY29yYXRpb246IG5vbmU7fSBAbWVkaWEgc2NyZWVuIGFuZCAobWluLXdpZHRoOiA2MDBweCkgey52MnNwIHtwYWRkaW5nOiA2cHggMzBweCAwcHg7fSAudjJyc3Age3BhZGRpbmc6IDBweCAxMHB4O319IEBtZWRpYSBzY3JlZW4gYW5kIChtaW4td2lkdGg6IDYwMHB4KSB7Lm1kdjJydyB7cGFkZGluZzogNDBweCA0MHB4O319IDwvc3R5bGU-PGxpbmsgaHJlZj0iLy9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M_ZmFtaWx5PUdvb2dsZStTYW5zIiByZWw9InN0eWxlc2hlZXQiIHR5cGU9InRleHQvY3NzIiBub25jZT0icU9wSWtBbGNKaWhZVHNiNE81OHNLUSIvPjwvaGVhZD48Ym9keSBzdHlsZT0ibWFyZ2luOiAwOyBwYWRkaW5nOiAwOyIgYmdjb2xvcj0iI0ZGRkZGRiI-PHRhYmxlIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHN0eWxlPSJtaW4td2lkdGg6IDM0OHB4OyIgYm9yZGVyPSIwIiBjZWxsc3BhY2luZz0iMCIgY2VsbHBhZGRpbmc9IjAiIGxhbmc9ImVuIj48dHIgaGVpZ2h0PSIzMiIgc3R5bGU9ImhlaWdodDogMzJweDsiPjx0ZD48L3RkPjwvdHI-PHRyIGFsaWduPSJjZW50ZXIiPjx0ZD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iLy9zY2hlbWEub3JnL0VtYWlsTWVzc2FnZSI-PGRpdiBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtc2NvcGUgaXRlbXR5cGU9Ii8vc2NoZW1hLm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20vQWNjb3VudENob29zZXI_RW1haWw9a290aGFyaXF1dHViQGdtYWlsLmNvbSZhbXA7Y29udGludWU9aHR0cHM6Ly9teWFjY291bnQuZ29vZ2xlLmNvbS9hbGVydC9udC8xNzY4MTA2OTk4MDAwP3JmbiUzRDEyNyUyNnJmbmMlM0QxJTI2ZWlkJTNELTc2NjYwMzk0MDU1MTQwNzkxMjQlMjZldCUzRDAiLz48bWV0YSBpdGVtcHJvcD0ibmFtZSIgY29udGVudD0iUmV2aWV3IEFjdGl2aXR5Ii8-PC9kaXY-PC9kaXY-PHRhYmxlIGJvcmRlcj0iMCIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiBzdHlsZT0icGFkZGluZy1ib3R0b206IDIwcHg7IG1heC13aWR0aDogNTE2cHg7IG1pbi13aWR0aDogMjIwcHg7Ij48dHI-PHRkIHdpZHRoPSI4IiBzdHlsZT0id2lkdGg6IDhweDsiPjwvdGQ-PHRkPjxkaXYgc3R5bGU9ImJvcmRlci1zdHlsZTogc29saWQ7IGJvcmRlci13aWR0aDogdGhpbjsgYm9yZGVyLWNvbG9yOiNkYWRjZTA7IGJvcmRlci1yYWRpdXM6IDhweDsgcGFkZGluZzogNDBweCAyMHB4OyIgYWxpZ249ImNlbnRlciIgY2xhc3M9Im1kdjJydyI-PGltZyBzcmM9Imh0dHBzOi8vd3d3LmdzdGF0aWMuY29tL2ltYWdlcy9icmFuZGluZy9nb29nbGVsb2dvLzJ4L2dvb2dsZWxvZ29fY29sb3JfNzR4MjRkcC5wbmciIHdpZHRoPSI3NCIgaGVpZ2h0PSIyNCIgYXJpYS1oaWRkZW49InRydWUiIHN0eWxlPSJtYXJnaW4tYm90dG9tOiAxNnB4OyIgYWx0PSJHb29nbGUiPjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiAmIzM5O0dvb2dsZSBTYW5zJiMzOTssUm9ib3RvLFJvYm90b0RyYWZ0LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2JvcmRlci1ib3R0b206IHRoaW4gc29saWQgI2RhZGNlMDsgY29sb3I6IHJnYmEoMCwwLDAsMC44Nyk7IGxpbmUtaGVpZ2h0OiAzMnB4OyBwYWRkaW5nLWJvdHRvbTogMjRweDt0ZXh0LWFsaWduOiBjZW50ZXI7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7Ij48ZGl2IHN0eWxlPSJmb250LXNpemU6IDI0cHg7Ij5Zb3UgYWxsb3dlZCBzYWtzb2x1dGlvbi5jb20gYWNjZXNzIHRvIHNvbWUgb2YgeW91ciBHb29nbGUgQWNjb3VudCBkYXRhIDwvZGl2Pjx0YWJsZSBhbGlnbj0iY2VudGVyIiBzdHlsZT0ibWFyZ2luLXRvcDo4cHg7Ij48dHIgc3R5bGU9ImxpbmUtaGVpZ2h0OiBub3JtYWw7Ij48dGQgYWxpZ249InJpZ2h0IiBzdHlsZT0icGFkZGluZy1yaWdodDo4cHg7Ij48aW1nIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgc3R5bGU9IndpZHRoOiAyMHB4OyBoZWlnaHQ6IDIwcHg7IHZlcnRpY2FsLWFsaWduOiBzdWI7IGJvcmRlci1yYWRpdXM6IDUwJTs7IiBzcmM9Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0pBakpOQzJVQThrMzN2TmlBQ3RhOVVNVWJmaUhCeDkxNXVfaFBBVkd2bHdWS2pTdz1zOTYtYyIgYWx0PSIiPjwvdGQ-PHRkPjxhIHN0eWxlPSJmb250LWZhbWlseTogJiMzOTtHb29nbGUgU2FucyYjMzk7LFJvYm90byxSb2JvdG9EcmFmdCxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtjb2xvcjogcmdiYSgwLDAsMCwwLjg3KTsgZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMjBweDsiPmtvdGhhcmlxdXR1YkBnbWFpbC5jb208L2E-PC90ZD48L3RyPjwvdGFibGU-IDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBSb2JvdG8tUmVndWxhcixIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogcmdiYSgwLDAsMCwwLjg3KTsgbGluZS1oZWlnaHQ6IDIwcHg7cGFkZGluZy10b3A6IDIwcHg7IHRleHQtYWxpZ246IGxlZnQ7Ij48YnI-PHA-SWYgeW91IGRpZG7igJl0IGFsbG93IHNha3NvbHV0aW9uLmNvbSBhY2Nlc3MgdG8gc29tZSBvZiB5b3VyIEdvb2dsZSBBY2NvdW50IGRhdGEsIHNvbWVvbmUgZWxzZSBtYXkgYmUgdHJ5aW5nIHRvIGFjY2VzcyB5b3VyIEdvb2dsZSBBY2NvdW50IGRhdGEuPC9wPjxwPlRha2UgYSBtb21lbnQgbm93IHRvIGNoZWNrIHlvdXIgYWNjb3VudCBhY3Rpdml0eSBhbmQgc2VjdXJlIHlvdXIgYWNjb3VudC48L3A-PGRpdiBzdHlsZT0icGFkZGluZy10b3A6IDMycHg7IHRleHQtYWxpZ246IGNlbnRlcjsiPjxhIGhyZWY9Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbS9BY2NvdW50Q2hvb3Nlcj9FbWFpbD1rb3RoYXJpcXV0dWJAZ21haWwuY29tJmFtcDtjb250aW51ZT1odHRwczovL215YWNjb3VudC5nb29nbGUuY29tL2FsZXJ0L250LzE3NjgxMDY5OTgwMDA_cmZuJTNEMTI3JTI2cmZuYyUzRDElMjZlaWQlM0QtNzY2NjAzOTQwNTUxNDA3OTEyNCUyNmV0JTNEMCIgdGFyZ2V0PSJfYmxhbmsiIGxpbmstaWQ9Im1haW4tYnV0dG9uLWxpbmsiIHN0eWxlPSJmb250LWZhbWlseTogJiMzOTtHb29nbGUgU2FucyBGbGV4JiMzOTssJiMzOTtHb29nbGUgU2FucyBUZXh0JiMzOTssJiMzOTtHb29nbGUgU2FucyYjMzk7LCYjMzk7Tm90byBTYW5zJiMzOTssQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7IGxpbmUtaGVpZ2h0OiAxNnB4OyBjb2xvcjogI2ZmZmZmZjsgZm9udC13ZWlnaHQ6IDUwMDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBmb250LXNpemU6IDE0cHg7ZGlzcGxheTppbmxpbmUtYmxvY2s7cGFkZGluZzogMTJweCAyNHB4O2JhY2tncm91bmQtY29sb3I6ICMwYjU3ZDA7IGJvcmRlci1yYWRpdXM6IDk5OTlweDsgbWluLXdpZHRoOiA2NHB4OyI-Q2hlY2sgYWN0aXZpdHk8L2E-PC9kaXY-PGRpdiBzdHlsZT0icGFkZGluZy10b3A6IDQwcHg7Ij48ZGl2IHN0eWxlPSJib3JkZXItYm90dG9tOiB0aGluIHNvbGlkICNkYWRjZTA7IHBhZGRpbmctYm90dG9tOiAyNHB4OyI-VG8gbWFrZSBjaGFuZ2VzIGF0IGFueSB0aW1lIHRvIHRoZSBhY2Nlc3MgdGhhdCBzYWtzb2x1dGlvbi5jb20gaGFzIHRvIHlvdXIgZGF0YSwgZ28gdG8geW91ciA8YSBocmVmPSJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20vQWNjb3VudENob29zZXI_RW1haWw9a290aGFyaXF1dHViQGdtYWlsLmNvbSZhbXA7Y29udGludWU9aHR0cHM6Ly9teWFjY291bnQuZ29vZ2xlLmNvbS9jb25uZWN0aW9ucy9vdmVydmlldy9BU2p4bzlFMjdnRC1IRHZUb2FPU0EzanhrdWZCVDVVRk9RWmlQZGx3bEI1czg3UWtXRS1nYUlYT1ZTd2N1SnVXdWUtY1Y5Wjd1eFRQRmxDVjVMZXRHZVNGcmRBP3V0bV9zb3VyY2UlM0RzZWNfYWxlcnQlMjZ1dG1fbWVkaXVtJTNEZW1haWxfbm90aWZpY2F0aW9uJTI2Zm9yY2VfYWxsJTNEdHJ1ZSIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgY29sb3I6ICM0Mjg1RjQ7IiB0YXJnZXQ9Il9ibGFuayI-R29vZ2xlIEFjY291bnQ8L2E-PC9kaXY-PC9kaXY-PC9kaXY-PGRpdiBzdHlsZT0icGFkZGluZy10b3A6IDIwcHg7IGZvbnQtc2l6ZTogMTJweDsgbGluZS1oZWlnaHQ6IDE2cHg7IGNvbG9yOiAjNWY2MzY4OyBsZXR0ZXItc3BhY2luZzogMC4zcHg7IHRleHQtYWxpZ246IGNlbnRlciI-WW91IGNhbiBhbHNvIHNlZSBzZWN1cml0eSBhY3Rpdml0eSBhdDxicj48YSBocmVmPSJodHRwczovL215YWNjb3VudC5nb29nbGUuY29tL25vdGlmaWNhdGlvbnMiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjNDI4NUY0OyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbXlhY2NvdW50Lmdvb2dsZS5jb20vbm90aWZpY2F0aW9uczwvYT48L2Rpdj48L2Rpdj48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOiBsZWZ0OyI-PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IFJvYm90by1SZWd1bGFyLEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2NvbG9yOiByZ2JhKDAsMCwwLDAuNTQpOyBmb250LXNpemU6IDExcHg7IGxpbmUtaGVpZ2h0OiAxOHB4OyBwYWRkaW5nLXRvcDogMTJweDsgdGV4dC1hbGlnbjogY2VudGVyOyI-PGRpdj5Zb3UgcmVjZWl2ZWQgdGhpcyBlbWFpbCB0byBsZXQgeW91IGtub3cgYWJvdXQgaW1wb3J0YW50IGNoYW5nZXMgdG8geW91ciBHb29nbGUgQWNjb3VudCBhbmQgc2VydmljZXMuPC9kaXY-PGRpdiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7Ij4mY29weTsgMjAyNiBHb29nbGUgTExDLCA8YSBjbGFzcz0iYWZhbCIgc3R5bGU9ImZvbnQtZmFtaWx5OiBSb2JvdG8tUmVndWxhcixIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtjb2xvcjogcmdiYSgwLDAsMCwwLjU0KTsgZm9udC1zaXplOiAxMXB4OyBsaW5lLWhlaWdodDogMThweDsgcGFkZGluZy10b3A6IDEycHg7IHRleHQtYWxpZ246IGNlbnRlcjsiPjE2MDAgQW1waGl0aGVhdHJlIFBhcmt3YXksIE1vdW50YWluIFZpZXcsIENBIDk0MDQzLCBVU0E8L2E-PC9kaXY-PC9kaXY-PC9kaXY-PC90ZD48dGQgd2lkdGg9IjgiIHN0eWxlPSJ3aWR0aDogOHB4OyI-PC90ZD48L3RyPjwvdGFibGU-PC90ZD48L3RyPjx0ciBoZWlnaHQ9IjMyIiBzdHlsZT0iaGVpZ2h0OiAzMnB4OyI-PHRkPjwvdGQ-PC90cj48L3RhYmxlPjwvYm9keT48L2h0bWw-"}}]},"sizeEstimate":13874,"historyId":"2854219","internalDate":"1768106998000"}', '2026-01-11T04:56:21.976Z', '19bab63beaddb9cc', '19bab63beaddb9cc', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('fed3aeb7923416f2ab4e35c8a94f6215', '101f04af63cbefc2bf8f0a98b9ae1205', 'qutubkothari <notifications@github.com>', '[qutubkothari/whatsapp-ai-assistant-v1] Run failed at startup:  - main (00ac664)', '[qutubkothari/whatsapp-ai-assistant-v1]  workflow run

Repository: qutubkothari/whatsapp-ai-assistant-v1
Workflow: 
Duration: 0.0 seconds
Finished: 2026-01-11 04:31:12 UTC

View results: https://github.com/qutubkothari/whatsapp-ai-assistant-v1/actions/runs/20889504200

Jobs:


-- 
You are receiving this because you are subscribed to this thread.
Manage your GitHub Actions notifications: https://github.com/settings/notifications
', '2026-01-11T04:31:32.000Z', '{"id":"19bab52e11df6fe0","threadId":"19bab52e11df6fe0","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"[qutubkothari/whatsapp-ai-assistant-v1] workflow run : No jobs were run View workflow run — You are receiving this because you are subscribed to this thread. Manage your GitHub Actions notifications","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2562667pxc;        Sat, 10 Jan 2026 20:31:34 -0800 (PST)"},{"name":"X-Forwarded-Encrypted","value":"i=2; AJvYcCXEFH+aHFbIA9D5kuStmZZiyWLmY7miRTYPTgrjzYqORVBODRUGw9oDr/OlAcE5peLgJJRXT6YyCsSmHHM=@gmail.com"},{"name":"X-Google-Smtp-Source","value":"AGHT+IGDGZ0QgtbpZhdKNBRc9M5Wc64Q2ZMH7vqbi7CqkRmAV+hDQC5YUh95/V5JCchqY0OdJHXc"},{"name":"X-Received","value":"by 2002:a05:622a:5916:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4ffb48c4709mr207403281cf.20.1768105894051;        Sat, 10 Jan 2026 20:31:34 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768105894; cv=none;        d=google.com; s=arc-20240605;        b=P74Z818p3PcA4PyZj1C/krjk/pCaEBiXNJ+IyyHFF4pyufmG+5PdTUj+49Mpydr1PS         /Y04Pg4E5cAWH0quXKktR0wrcb4Z+LCNxcrhQcmYuEHHjly7v1MFFhWFoqdwDTyQoHn5         ZWGem+aue6FqPwxYD60EezUPazYvYWfB00phTszbezwR1jGv6kWJGKMGS+NGq4ltjGqg         BUDho+Ij2Gv8KVTlCEKACoy1aVrGET+s/HKgjD9ndtqWnCo5ZxRJeya9iHI/JPWj5d9L         nnCetiUgwezvCvB57UlLy/xPelCKhYMV5NU8kwiZcOW/f/aBRDfNurn4O3oEsHonEnKR         eKFw=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=mime-version:from:to:cc:subject:list-id:date:message-id         :list-archive:precedence:reply-to:list-post:dkim-signature;        bh=+H9/1qOE0hR/HnNCRSolqSSoyYcLUAQl/Ih2hFX/e8U=;        fh=Mn+kvJaZRAtqYMy8bkwGzFU0LDie+SYW9XgzCmKJ2gs=;        b=PHdgx60FPiag1BBUjbAtEcO7/UspCZJhjW1J1YP7m6poUpOWvQ2nBuIWcEpENPQdOO         zvcVroEOe3zrEGl9u0qSm2M57CRocvTdmbSh/ZZnl/rKKShGPEFcAsWp7VcivLL5U8en         W5fQiF1Hdk1ZGzQw+GS7KJF51dT3s2lXMvzAMk9pcDPWtOei7jAnmdMfWQ3d8I7zbxtd         wnrxuCREl1VIqC7CuJwuVfBBTOVe4kqS0VfytxxKjkcwITTOzlc5P2Wqp//JOcaI01cU         xwUP4I+5bk4U6uBTvNKzgFu6nIVF3AtWR2XeRRSoa9YuyAacZXzoogp+xVcHgTOlPHKQ         uFKA==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@github.com header.s=pf2023 header.b=\"F+uAfa/t\";       spf=pass (google.com: domain of notifications@github.com designates 192.30.252.200 as permitted sender) smtp.mailfrom=notifications@github.com;       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=github.com"},{"name":"Return-Path","value":"<notifications@github.com>"},{"name":"Received","value":"from out-17.smtp.github.com (out-17.smtp.github.com. [192.30.252.200])        by mx.google.com with UTF8SMTPS id d75a77b69052e-4ffa8e95dfdsi184437961cf.263.2026.01.10.20.31.33        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Sat, 10 Jan 2026 20:31:34 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of notifications@github.com designates 192.30.252.200 as permitted sender) client-ip=192.30.252.200;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@github.com header.s=pf2023 header.b=\"F+uAfa/t\";       spf=pass (google.com: domain of notifications@github.com designates 192.30.252.200 as permitted sender) smtp.mailfrom=notifications@github.com;       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=github.com"},{"name":"Received","value":"from localhost (hubbernetes-node-dcf06c9.va3-iad.github.net [10.48.109.82]) by smtp.github.com (Postfix) with UTF8SMTPSA id BA83B4E045E for <kothariqutub@gmail.com>; Sat, 10 Jan 2026 20:31:33 -0800 (PST)"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com; s=pf2023; t=1768105893; bh=+H9/1qOE0hR/HnNCRSolqSSoyYcLUAQl/Ih2hFX/e8U=; h=List-Post:Reply-To:List-Archive:Date:List-Id:Subject:Cc:To:From:\t From; b=F+uAfa/tAd9zp+yTOPdk+Ga/zWe9XffGPQRiRcA8QK3MLf//VIDvtyzT9OAiSRWhT\t gYE9sqXyk1i7Jmj44jPyZAt02XWN7BGTz/t1P+kVqSBsfmEXLUuhduaGEX9ySf15mC\t lufn2r4U7vppSHnYJCTHYEziBYCGKvCOeQq+z7yc="},{"name":"Content-Type","value":"multipart/alternative; boundary=\"part_6c8d74599141d139b65f4f82561df3c572fb7283a2c56c17eb8cb0d5e9868583\"; charset=UTF-8"},{"name":"List-Post","value":"noreply@github.com"},{"name":"Reply-To","value":"\"qutubkothari/whatsapp-ai-assistant-v1\" <whatsapp-ai-assistant-v1@noreply.github.com>"},{"name":"Precedence","value":"list"},{"name":"X-Github-Sender","value":"qutubkothari"},{"name":"List-Archive","value":"https://github.com/qutubkothari/whatsapp-ai-assistant-v1"},{"name":"Message-Id","value":"<qutubkothari/whatsapp-ai-assistant-v1/check-suites/CS_kwDOOn3nHs8AAAAMljNjXg/1768105872@github.com>"},{"name":"Date","value":"Sat, 10 Jan 2026 20:31:32 -0800"},{"name":"List-Id","value":"qutubkothari/whatsapp-ai-assistant-v1 <whatsapp-ai-assistant-v1.qutubkothari.github.com>"},{"name":"X-Github-Recipient","value":"qutubkothari"},{"name":"X-Github-Reason","value":"ci_activity"},{"name":"X-Github-Notify-Platform","value":"notifyd"},{"name":"Subject","value":"[qutubkothari/whatsapp-ai-assistant-v1] Run failed at startup:  - main (00ac664)"},{"name":"Cc","value":"Ci activity <ci_activity@noreply.github.com>"},{"name":"To","value":"\"qutubkothari/whatsapp-ai-assistant-v1\" <whatsapp-ai-assistant-v1@noreply.github.com>"},{"name":"From","value":"qutubkothari <notifications@github.com>"},{"name":"Mime-Version","value":"1.0"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/plain","filename":"","headers":[{"name":"Content-Transfer-Encoding","value":"7bit"},{"name":"Content-Type","value":"text/plain; charset=UTF-8"}],"body":{"size":447,"data":"W3F1dHVia290aGFyaS93aGF0c2FwcC1haS1hc3Npc3RhbnQtdjFdICB3b3JrZmxvdyBydW4NCg0KUmVwb3NpdG9yeTogcXV0dWJrb3RoYXJpL3doYXRzYXBwLWFpLWFzc2lzdGFudC12MQ0KV29ya2Zsb3c6IA0KRHVyYXRpb246IDAuMCBzZWNvbmRzDQpGaW5pc2hlZDogMjAyNi0wMS0xMSAwNDozMToxMiBVVEMNCg0KVmlldyByZXN1bHRzOiBodHRwczovL2dpdGh1Yi5jb20vcXV0dWJrb3RoYXJpL3doYXRzYXBwLWFpLWFzc2lzdGFudC12MS9hY3Rpb25zL3J1bnMvMjA4ODk1MDQyMDANCg0KSm9iczoNCg0KDQotLSANCllvdSBhcmUgcmVjZWl2aW5nIHRoaXMgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQgdG8gdGhpcyB0aHJlYWQuDQpNYW5hZ2UgeW91ciBHaXRIdWIgQWN0aW9ucyBub3RpZmljYXRpb25zOiBodHRwczovL2dpdGh1Yi5jb20vc2V0dGluZ3Mvbm90aWZpY2F0aW9ucw0K"}},{"partId":"1","mimeType":"text/html","filename":"","headers":[{"name":"Content-Transfer-Encoding","value":"quoted-printable"},{"name":"Content-Type","value":"text/html; charset=UTF-8"}],"body":{"size":25458,"data":"PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg0KPGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBsYW5nPSJlbiIgeG1sOmxhbmc9ImVuIiBzdHlsZT0iZm9udC1mYW1pbHk6IHNhbnMtc2VyaWY7IC1tcy10ZXh0LXNpemUtYWRqdXN0OiAxMDAlOyAtd2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6IDEwMCU7IGJveC1zaXppbmc6IGJvcmRlci1ib3g7IiB4bWw6bGFuZz0iZW4iPg0KICA8aGVhZD4NCiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCIgLz4NCiAgICA8bWV0YSBuYW1lPSJ2aWV3cG9ydCIgY29udGVudD0id2lkdGg9ZGV2aWNlLXdpZHRoIiAvPg0KICAgIDx0aXRsZT5bcXV0dWJrb3RoYXJpL3doYXRzYXBwLWFpLWFzc2lzdGFudC12MV0gUnVuIGZhaWxlZCBhdCBzdGFydHVwOiAgLSBtYWluICgwMGFjNjY0KTwvdGl0bGU-DQogICAgDQogIDwvaGVhZD4NCiAgPGJvZHkgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OzsgZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMS41OyBjb2xvcjogIzI0MjkyZTsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZjsgbWFyZ2luOiAwOyIgYmdjb2xvcj0iI2ZmZiI-DQogICAgPHRhYmxlIGFsaWduPSJjZW50ZXIiIGNsYXNzPSJjb250YWluZXItc20gd2lkdGgtZnVsbCIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgbWF4LXdpZHRoOiA1NDRweDsgbWFyZ2luLXJpZ2h0OiBhdXRvOyBtYXJnaW4tbGVmdDogYXV0bzsgd2lkdGg6IDEwMCUgIWltcG9ydGFudDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgICAgPHRkIGNsYXNzPSJjZW50ZXIgcC0zIiBhbGlnbj0iY2VudGVyIiB2YWxpZ249InRvcCIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBwYWRkaW5nOiAxNnB4OyI-DQogICAgICAgICAgPGNlbnRlciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgICAgICAgIDx0YWJsZSBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYWxpZ249ImNlbnRlciIgY2xhc3M9IndpZHRoLWZ1bGwgY29udGFpbmVyLW1kIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBtYXgtd2lkdGg6IDc2OHB4OyBtYXJnaW4tcmlnaHQ6IGF1dG87IG1hcmdpbi1sZWZ0OiBhdXRvOyB3aWR0aDogMTAwJSAhaW1wb3J0YW50OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPg0KICAgICAgICAgICAgICA8dGFibGUgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dGJvZHkgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgPHRkIGhlaWdodD0iMTYiIHN0eWxlPSJmb250LXNpemU6IDE2cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPiYjMTYwOzwvdGQ-DQogICAgPC90cj4NCiAgPC90Ym9keT4NCjwvdGFibGU-DQoNCiAgICAgICAgICAgICAgPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiBhbGlnbj0ibGVmdCIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgICAgICAgICAgICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgICAgICAgICAgICAgICA8dGQgY2xhc3M9InRleHQtbGVmdCIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IHRleHQtYWxpZ246IGxlZnQgIWltcG9ydGFudDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IDA7IiBhbGlnbj0ibGVmdCI-DQogICAgICAgICAgICAgICAgICAgIDxpbWcgc3JjPSJodHRwczovL2dpdGh1Yi5naXRodWJhc3NldHMuY29tL2Fzc2V0cy9vY3RvY2F0LWxvZ28tODA1YjVjM2UyNDlmLnBuZyIgYWx0PSJHaXRIdWIiIHdpZHRoPSIzMiIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBib3JkZXItc3R5bGU6IG5vbmU7IiAvPg0KICAgICAgICAgICAgICAgICAgICA8aDIgY2xhc3M9ImxoLWNvbmRlbnNlZCBtdC0yIHRleHQtbm9ybWFsIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgbWFyZ2luLXRvcDogOHB4ICFpbXBvcnRhbnQ7IG1hcmdpbi1ib3R0b206IDA7IGZvbnQtc2l6ZTogMjRweDsgZm9udC13ZWlnaHQ6IDQwMCAhaW1wb3J0YW50OyBsaW5lLWhlaWdodDogMS4yNSAhaW1wb3J0YW50OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgW3F1dHVia290aGFyaS93aGF0c2FwcC1haS1hc3Npc3RhbnQtdjFdICB3b3JrZmxvdyBydW4NCg0KICAgICAgICAgICAgICAgICAgICA8L2gyPg0KICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICA8dGFibGUgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dGJvZHkgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgPHRkIGhlaWdodD0iMTYiIHN0eWxlPSJmb250LXNpemU6IDE2cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPiYjMTYwOzwvdGQ-DQogICAgPC90cj4NCiAgPC90Ym9keT4NCjwvdGFibGU-DQoNCjwvdGQ-DQogIDwvdHI-DQo8L3RhYmxlPg0KICAgICAgICAgICAgPHRhYmxlIHdpZHRoPSIxMDAlIiBjbGFzcz0id2lkdGgtZnVsbCIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyB3aWR0aDogMTAwJSAhaW1wb3J0YW50OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgICAgICAgICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgICAgICAgICAgICAgPHRkIGNsYXNzPSJib3JkZXIgcm91bmRlZC0yIGQtYmxvY2siIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItcmFkaXVzOiA2cHggIWltcG9ydGFudDsgZGlzcGxheTogYmxvY2sgIWltcG9ydGFudDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IDA7IGJvcmRlcjogMXB4IHNvbGlkICNlMWU0ZTg7Ij4NCiAgICAgICAgICAgICAgICAgIDx0YWJsZSBhbGlnbj0iY2VudGVyIiBjbGFzcz0id2lkdGgtZnVsbCB0ZXh0LWNlbnRlciIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyB3aWR0aDogMTAwJSAhaW1wb3J0YW50OyB0ZXh0LWFsaWduOiBjZW50ZXIgIWltcG9ydGFudDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgICAgICAgICAgICAgICAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgICAgICAgICAgICAgICAgIDx0ZCBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IDA7Ij4NCiAgICAgICAgICAgICAgICAgICAgICAgIDx0YWJsZSBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYWxpZ249ImNlbnRlciIgY2xhc3M9IndpZHRoLWZ1bGwiIHdpZHRoPSIxMDAlIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgYm9yZGVyLXNwYWNpbmc6IDA7IGJvcmRlci1jb2xsYXBzZTogY29sbGFwc2U7IHdpZHRoOiAxMDAlICFpbXBvcnRhbnQ7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICA8dGQgYWxpZ249ImNlbnRlciIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBwYWRkaW5nOiAwOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAgIA0KPHRhYmxlIGFsaWduPSJjZW50ZXIiIGNsYXNzPSJib3JkZXItYm90dG9tIHdpZHRoLWZ1bGwgdGV4dC1jZW50ZXIiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgYm9yZGVyLWJvdHRvbS13aWR0aDogMXB4ICFpbXBvcnRhbnQ7IGJvcmRlci1ib3R0b20tY29sb3I6ICNlMWU0ZTggIWltcG9ydGFudDsgYm9yZGVyLWJvdHRvbS1zdHlsZTogc29saWQgIWltcG9ydGFudDsgd2lkdGg6IDEwMCUgIWltcG9ydGFudDsgdGV4dC1hbGlnbjogY2VudGVyICFpbXBvcnRhbnQ7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICA8dGQgY2xhc3M9ImQtYmxvY2sgcHgtMyBwdC0zIHAtc20tNCIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGRpc3BsYXk6IGJsb2NrICFpbXBvcnRhbnQ7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBwYWRkaW5nOiAxNnB4IDE2cHggMDsiPg0KICAgICAgPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiBhbGlnbj0iY2VudGVyIiBjbGFzcz0id2lkdGgtZnVsbCIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgd2lkdGg6IDEwMCUgIWltcG9ydGFudDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IDA7Ij4NCiAgICAgICAgDQogICAgPGltZyBzcmM9Imh0dHBzOi8vZ2l0aHViLmdpdGh1YmFzc2V0cy5jb20vYXNzZXRzL2FjdGlvbnMtMWNjMGMzY2NmZTE4LnBuZyIgd2lkdGg9IjU2IiBoZWlnaHQ9IjU2IiBhbHQ9IiIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBib3JkZXItc3R5bGU6IG5vbmU7IiAvPg0KICA8dGFibGUgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dGJvZHkgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgPHRkIGhlaWdodD0iMTIiIHN0eWxlPSJmb250LXNpemU6IDEycHg7IGxpbmUtaGVpZ2h0OiAxMnB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPiYjMTYwOzwvdGQ-DQogICAgPC90cj4NCiAgPC90Ym9keT4NCjwvdGFibGU-DQoNCjxoMyBjbGFzcz0ibGgtY29uZGVuc2VkIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgbWFyZ2luLXRvcDogMDsgbWFyZ2luLWJvdHRvbTogMDsgZm9udC1zaXplOiAyMHB4OyBmb250LXdlaWdodDogNjAwOyBsaW5lLWhlaWdodDogMS4yNSAhaW1wb3J0YW50OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPjogTm8gam9icyB3ZXJlIHJ1bjwvaDM-DQo8dGFibGUgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dGJvZHkgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgPHRkIGhlaWdodD0iMTYiIHN0eWxlPSJmb250LXNpemU6IDE2cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPiYjMTYwOzwvdGQ-DQogICAgPC90cj4NCiAgPC90Ym9keT4NCjwvdGFibGU-DQoNCg0KDQogIDx0YWJsZSBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYWxpZ249ImNlbnRlciIgY2xhc3M9IndpZHRoLWZ1bGwiIHdpZHRoPSIxMDAlIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgYm9yZGVyLXNwYWNpbmc6IDA7IGJvcmRlci1jb2xsYXBzZTogY29sbGFwc2U7IHdpZHRoOiAxMDAlICFpbXBvcnRhbnQ7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICA8dGQgYWxpZ249ImNlbnRlciIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBwYWRkaW5nOiAwOyI-DQogICAgPHRhYmxlIHdpZHRoPSIxMDAlIiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRkIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPg0KICAgICAgPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPg0KICAgICAgICAgICAgICA8IS0tW2lmIG1zb10-IDx0YWJsZT48dHI-PHRkIGFsaWduPSJjZW50ZXIiIGJnY29sb3I9IiMyOGE3NDUiPiA8IVtlbmRpZl0tLT4NCiAgICAgICAgICAgICAgICA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vcXV0dWJrb3RoYXJpL3doYXRzYXBwLWFpLWFzc2lzdGFudC12MS9hY3Rpb25zL3J1bnMvMjA4ODk1MDQyMDAiIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vb3BlbmVyIG5vcmVmZXJyZXIiIGNsYXNzPSJidG4gYnRuLWxhcmdlIGJ0bi1wcmltYXJ5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogIzFmODgzZCAhaW1wb3J0YW50OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyBjb2xvcjogI2ZmZjsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBwb3NpdGlvbjogcmVsYXRpdmU7IGRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiBpbmhlcml0OyBmb250LXdlaWdodDogNTAwOyBsaW5lLWhlaWdodDogMS41OyB3aGl0ZS1zcGFjZTogbm93cmFwOyB2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOyBjdXJzb3I6IHBvaW50ZXI7IC13ZWJraXQtdXNlci1zZWxlY3Q6IG5vbmU7IHVzZXItc2VsZWN0OiBub25lOyBib3JkZXItcmFkaXVzOiAuNWVtOyBhcHBlYXJhbmNlOiBub25lOyBib3gtc2hhZG93OiAwIDFweCAwIHJnYmEoMjcsMzEsMzUsLjEpLGluc2V0IDAgMXB4IDAgaHNsYSgwLDAlLDEwMCUsLjAzKTsgdHJhbnNpdGlvbjogYmFja2dyb3VuZC1jb2xvciAuMnMgY3ViaWMtYmV6aWVyKDAuMywgMCwgMC41LCAxKTsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IC43NWVtIDEuNWVtOyBib3JkZXI6IDFweCBzb2xpZCAjMWY4ODNkOyI-VmlldyB3b3JrZmxvdyBydW48L2E-DQogICAgICAgICAgICAgIDwhLS1baWYgbXNvXT4gPC90ZD48L3RyPjwvdGFibGU-IDwhW2VuZGlmXS0tPg0KICAgICAgICAgIDwvdGQ-DQogICAgICAgIDwvdHI-DQogICAgICA8L3RhYmxlPg0KICAgIDwvdGQ-DQogIDwvdHI-DQo8L3RhYmxlPg0KDQo8L3RkPg0KICA8L3RyPg0KPC90YWJsZT4NCiAgPHRhYmxlIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgPHRib2R5IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgIDx0ZCBoZWlnaHQ9IjMyIiBzdHlsZT0iZm9udC1zaXplOiAzMnB4OyBsaW5lLWhlaWdodDogMzJweDsgYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IDA7Ij4mIzE2MDs8L3RkPg0KICAgIDwvdHI-DQogIDwvdGJvZHk-DQo8L3RhYmxlPg0KDQoNCjwvdGQ-DQogIDwvdHI-DQo8L3RhYmxlPg0KICAgIDwvdGQ-DQogIDwvdHI-DQo8L3RhYmxlPg0KDQoNCg0KDQo8L3RkPg0KICA8L3RyPg0KPC90YWJsZT4NCiAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCiAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgPC90YWJsZT4NCiAgICAgICAgICAgIDx0YWJsZSBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYWxpZ249ImNlbnRlciIgY2xhc3M9IndpZHRoLWZ1bGwgdGV4dC1jZW50ZXIiIHdpZHRoPSIxMDAlIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgYm9yZGVyLXNwYWNpbmc6IDA7IGJvcmRlci1jb2xsYXBzZTogY29sbGFwc2U7IHdpZHRoOiAxMDAlICFpbXBvcnRhbnQ7IHRleHQtYWxpZ246IGNlbnRlciAhaW1wb3J0YW50OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPg0KICAgICAgICAgICAgICA8dGFibGUgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGJvcmRlci1zcGFjaW5nOiAwOyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICA8dGJvZHkgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgPHRyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgICAgPHRkIGhlaWdodD0iMTYiIHN0eWxlPSJmb250LXNpemU6IDE2cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsgcGFkZGluZzogMDsiPiYjMTYwOzwvdGQ-DQogICAgPC90cj4NCiAgPC90Ym9keT4NCjwvdGFibGU-DQoNCiAgICAgICAgICAgICAgPHRhYmxlIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgPHRib2R5IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiPg0KICAgIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICAgIDx0ZCBoZWlnaHQ9IjE2IiBzdHlsZT0iZm9udC1zaXplOiAxNnB4OyBsaW5lLWhlaWdodDogMTZweDsgYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7IHBhZGRpbmc6IDA7Ij4mIzE2MDs8L3RkPg0KICAgIDwvdHI-DQogIDwvdGJvZHk-DQo8L3RhYmxlPg0KDQogICAgICAgICAgICAgIDxwIGNsYXNzPSJmNSB0ZXh0LWdyYXktbGlnaHQiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBtYXJnaW4tdG9wOiAwOyBtYXJnaW4tYm90dG9tOiAxMHB4OyBjb2xvcjogIzZhNzM3ZCAhaW1wb3J0YW50OyBmb250LXNpemU6IDE0cHggIWltcG9ydGFudDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4gIDwvcD48cCBzdHlsZT0iZm9udC1zaXplOiBzbWFsbDsgLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OiBub25lOyBjb2xvcjogIzY2NjsgYm94LXNpemluZzogYm9yZGVyLWJveDsgbWFyZ2luLXRvcDogMDsgbWFyZ2luLWJvdHRvbTogMTBweDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4mIzgyMTI7PGJyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LWZhbWlseTogLWFwcGxlLXN5c3RlbSxCbGlua01hY1N5c3RlbUZvbnQsJnF1b3Q7U2Vnb2UgVUkmcXVvdDssSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWYsJnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDsgIWltcG9ydGFudDsiIC8-WW91IGFyZSByZWNlaXZpbmcgdGhpcyBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGlzIHRocmVhZC48YnIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyIgLz48YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vc2V0dGluZ3Mvbm90aWZpY2F0aW9ucyIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6IHJnYmEoMCwwLDAsMCk7IGJveC1zaXppbmc6IGJvcmRlci1ib3g7IGNvbG9yOiAjMDM2NmQ2OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-TWFuYWdlIHlvdXIgR2l0SHViIEFjdGlvbnMgbm90aWZpY2F0aW9uczwvYT48L3A-DQoNCjwvdGQ-DQogIDwvdHI-DQo8L3RhYmxlPg0KICAgICAgICAgICAgPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiBhbGlnbj0iY2VudGVyIiBjbGFzcz0id2lkdGgtZnVsbCB0ZXh0LWNlbnRlciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBib3JkZXItc3BhY2luZzogMDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgd2lkdGg6IDEwMCUgIWltcG9ydGFudDsgdGV4dC1hbGlnbjogY2VudGVyICFpbXBvcnRhbnQ7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogIDx0ciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICA8dGQgYWxpZ249ImNlbnRlciIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBwYWRkaW5nOiAwOyI-DQogIDx0YWJsZSBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgYm9yZGVyLXNwYWNpbmc6IDA7IGJvcmRlci1jb2xsYXBzZTogY29sbGFwc2U7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogIDx0Ym9keSBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNTeXN0ZW1Gb250LCZxdW90O1NlZ29lIFVJJnF1b3Q7LEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmLCZxdW90O0FwcGxlIENvbG9yIEVtb2ppJnF1b3Q7LCZxdW90O1NlZ29lIFVJIEVtb2ppJnF1b3Q7ICFpbXBvcnRhbnQ7Ij4NCiAgICA8dHIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-DQogICAgICA8dGQgaGVpZ2h0PSIxNiIgc3R5bGU9ImZvbnQtc2l6ZTogMTZweDsgbGluZS1oZWlnaHQ6IDE2cHg7IGJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyBwYWRkaW5nOiAwOyI-JiMxNjA7PC90ZD4NCiAgICA8L3RyPg0KICA8L3Rib2R5Pg0KPC90YWJsZT4NCg0KICA8cCBjbGFzcz0iZjYgdGV4dC1ncmF5LWxpZ2h0IiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgbWFyZ2luLXRvcDogMDsgbWFyZ2luLWJvdHRvbTogMTBweDsgY29sb3I6ICM2YTczN2QgIWltcG9ydGFudDsgZm9udC1zaXplOiAxMnB4ICFpbXBvcnRhbnQ7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLEJsaW5rTWFjU3lzdGVtRm9udCwmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OyAhaW1wb3J0YW50OyI-R2l0SHViLCBJbmMuICYjMTI1Mzk7ODggQ29saW4gUCBLZWxseSBKciBTdHJlZXQgJiMxMjUzOTtTYW4gRnJhbmNpc2NvLCBDQSA5NDEwNzwvcD4NCjwvdGQ-DQogIDwvdHI-DQo8L3RhYmxlPg0KDQogICAgICAgICAgPC9jZW50ZXI-DQogICAgICAgIDwvdGQ-DQogICAgICA8L3RyPg0KICAgIDwvdGFibGU-DQogICAgPCEtLSBwcmV2ZW50IEdtYWlsIG9uIGlPUyBmb250IHNpemUgbWFuaXB1bGF0aW9uIC0tPg0KICAgPGRpdiBzdHlsZT0iZGlzcGxheTogbm9uZTsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udDogMTVweC8wIGFwcGxlLXN5c3RlbSwgQmxpbmtNYWNTeXN0ZW1Gb250LCAmcXVvdDtTZWdvZSBVSSZxdW90OyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZiwmcXVvdDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OywmcXVvdDtTZWdvZSBVSSBFbW9qaSZxdW90OzsiPiAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyAmIzE2MDsgJiMxNjA7ICYjMTYwOyA8L2Rpdj4NCiAgPC9ib2R5Pg0KPC9odG1sPg0K"}}]},"sizeEstimate":32283,"historyId":"2854149","internalDate":"1768105892000"}', '2026-01-11T04:56:22.722Z', '19bab52e11df6fe0', '19bab52e11df6fe0', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('f4dc05b3c1cceb34723340e5d8b5f305', '101f04af63cbefc2bf8f0a98b9ae1205', 'Kotak-BankAlerts <BankAlerts@kotak.bank.in>', 'Account Balance - Weekly', '<html><head><style>.a3 { font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: normal; color: #003366; text-decoration: none }
</style></head><body><font class=a3>

Dear ATIF FAKHRUDDIN KOTHARI,
<br>
<br>
We wish to advise you that balance in your account XXXX2623 as on 11-JAN-2026 is  
<br>
<br>
Available Balance: INR 14066.70
<br>
<br>
Combined Available Balance: INR 14066.70
<br>
<br><p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: normal; color: #003366; text-decoration: none"> Please do not reply to this message. To reach us, <a target="_blank" href="https://www.kotak.bank.in/en/reach-us.html">click here</a>.</p><style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: normal; text-decoration: none"><a target="_blank" href="https://www.kotak.bank.in/en/disclaimer.html">Disclaimer</a></style><br><br><a target="_blank" href="https://www.kotak.bank.in/en/campaigns/email-footer-url.html"><img src="https://www.kotak.bank.in/content/dam/Kotak/email-campaigns/emailfooter-whatsapp.png"></a><br></html>', '2026-01-11T03:30:10.000Z', '{"id":"19bab1ade66ff6f5","threadId":"19bab1ade66ff6f5","labelIds":["UNREAD","CATEGORY_PERSONAL","INBOX"],"snippet":"Dear ATIF FAKHRUDDIN KOTHARI, We wish to advise you that balance in your account XXXX2623 as on 11-JAN-2026 is Available Balance: INR 14066.70 Combined Available Balance: INR 14066.70 Please do not","payload":{"partId":"","mimeType":"multipart/mixed","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2549101pxc;        Sat, 10 Jan 2026 19:30:23 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IG1/cisKnhOaQmsPsAtQCgEahYD6hDj+AxMCVpjNb215+OZSLFmKodeNd1tjagO631UoRDf"},{"name":"X-Received","value":"by 2002:a05:6a20:2583:b0:366:14ac:e204 with SMTP id adf61e73a8af0-3898fa57649mr11446219637.66.1768102223564;        Sat, 10 Jan 2026 19:30:23 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768102223; cv=none;        d=google.com; s=arc-20240605;        b=W9Xrya8ucWWpWC5+cZzIjt9k/WhBScdXCdn6HCNwoxx9ZCu6fq7Tag2eg0f5+5rvKo         F3ubffcUd53BjU+WFWAzhfqfuIOktpU+eMkXK6wS/soHWUVSzqfmvCNO8M7mHQdGzmu5         ZhvbLGfgAFhnBY29KOg9VRK3FpUPk200Stxgzk7hcW8H1w5OXQk7KZ1jCFOgD7P/QDoa         MEfHrcVJik64HHc9QioJXKuAb4RM3o71ObH4vRjcJgPKC2wXQt9eLo273iWu4ypD6GVX         8SCLI+W4lOjCwxf5q/UU+aDKGlquvfwgMi/OVjLQhxQnrdR/HnJpaT6PydLduHm3Pi4t         2yAQ=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=account balance - weekly:mime-version:subject:to:from:date         :message-id:dkim-signature;        bh=VOlT33Fvy9ztDLbuAQC+I6AGit0xpq3LNaN8akYNdCI=;        fh=+eG3VtXlG0jmElw0Ge4dogMVqVsSct8Kcrb3cptok1I=;        b=c1lvcb0kwAjStkIaFJdWDUvR5KGek1PCBNcOYKdGUpFgnVOl5x3NKXkW8pN7Xhn6LV         GOc/32XVuHKrF85XEBffHCvnwlhaih+f452043fioCofjrxtEIjDfjcztd0ElwUO8iuZ         MQn0ZcBFiiH6owmOk3m7kReXtcTvmR5/IvCSqAxmYbBRt91PfDCdIUn6XD2wDnqvf4bM         KGbF2xoiDLCB5QR1Fld8KzN1u3cFht0GmAAvikLDHp/rTrtaxhNDYxT01qpW2Thhlk5q         Foz3sHD5SZiyLZRR86baRkWYvFPswpX93IF46fjCKGJsV+5HWQmY4z86qasyLvTksnas         zlkw==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@kotak.bank.in header.s=outgoing01 header.b=dF0V2OYy;       spf=pass (google.com: domain of bankalerts@kotak.bank.in designates 121.241.26.211 as permitted sender) smtp.mailfrom=BankAlerts@kotak.bank.in;       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=kotak.bank.in"},{"name":"Return-Path","value":"<BankAlerts@kotak.bank.in>"},{"name":"Received","value":"from alerts65.kotak.com (alerts65.kotak.com. [121.241.26.211])        by mx.google.com with ESMTPS id 41be03b00d2f7-c4cc83881e7si21628085a12.240.2026.01.10.19.30.22        for <KOTHARIQUTUB@gmail.com>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Sat, 10 Jan 2026 19:30:23 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of bankalerts@kotak.bank.in designates 121.241.26.211 as permitted sender) client-ip=121.241.26.211;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@kotak.bank.in header.s=outgoing01 header.b=dF0V2OYy;       spf=pass (google.com: domain of bankalerts@kotak.bank.in designates 121.241.26.211 as permitted sender) smtp.mailfrom=BankAlerts@kotak.bank.in;       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=kotak.bank.in"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; c=relaxed/relaxed;  d=kotak.bank.in; i=@kotak.bank.in; q=dns/txt;  s=outgoing01; t=1768102223; x=1799638223;  h=message-id:date:from:to:subject:mime-version;  bh=VOlT33Fvy9ztDLbuAQC+I6AGit0xpq3LNaN8akYNdCI=;  b=dF0V2OYy9jc+6q77XouO+2NWuxnLIxxYs4OiVK/FewfvKbIO3OHxyMNZ   FglF1kWHlwfXLWc/axcO1ATP10wPLGNlc8rY1OayrfQE6df0l3eyQ9MqI   iEpppKQC/OaWZYRgSBf2W1n/KeFVGeGgMAhLxZ52jN68+OH3YUPnr6fR0   0WMyBbAjCrM2ldCMmrFGQXMVOS+LxtL78ofOk39j6dH2A1cuIeCftUQkI   XX32EvzJpVK2nY/XIlm3UrXizHYGCny8wuPzHGzpPr2CH9+pIR35RXo7v   mJKdtzVUZFPAjyUxS3dBUFe6OQ+QGXRjvqiMUlKVghdlzNJ4W58LoUkEz   g==;"},{"name":"X-CSE-ConnectionGUID","value":"4/iFCty2Qe2lm/5jMg7hPQ=="},{"name":"X-CSE-MsgGUID","value":"y/b77SheQO216EvmUAHCZA=="},{"name":"Message-ID","value":"<-278184795.1768102210124.JavaMail.wasadmin@KBPRVMUW00236>"},{"name":"Date","value":"Sun, 11 Jan 2026 09:00:10 +0530 (GMT+05:30)"},{"name":"From","value":"Kotak-BankAlerts <BankAlerts@kotak.bank.in>"},{"name":"To","value":"KOTHARIQUTUB@gmail.com"},{"name":"Subject","value":"Account Balance - Weekly"},{"name":"Mime-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/mixed; boundary=\"----=_Part_5856088_1687589022.1768102210124\""},{"name":"Account Balance - Weekly","value":"UTF-8"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"7bit"}],"body":{"size":1103,"data":"PGh0bWw-PGhlYWQ-PHN0eWxlPi5hMyB7IGZvbnQtZmFtaWx5OiBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGNvbG9yOiAjMDAzMzY2OyB0ZXh0LWRlY29yYXRpb246IG5vbmUgfQ0KPC9zdHlsZT48L2hlYWQ-PGJvZHk-PGZvbnQgY2xhc3M9YTM-DQoNCkRlYXIgQVRJRiBGQUtIUlVERElOIEtPVEhBUkksDQo8YnI-DQo8YnI-DQpXZSB3aXNoIHRvIGFkdmlzZSB5b3UgdGhhdCBiYWxhbmNlIGluIHlvdXIgYWNjb3VudCBYWFhYMjYyMyBhcyBvbiAxMS1KQU4tMjAyNiBpcyAgDQo8YnI-DQo8YnI-DQpBdmFpbGFibGUgQmFsYW5jZTogSU5SIDE0MDY2LjcwDQo8YnI-DQo8YnI-DQpDb21iaW5lZCBBdmFpbGFibGUgQmFsYW5jZTogSU5SIDE0MDY2LjcwDQo8YnI-DQo8YnI-PHAgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGNvbG9yOiAjMDAzMzY2OyB0ZXh0LWRlY29yYXRpb246IG5vbmUiPiBQbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMgbWVzc2FnZS4gVG8gcmVhY2ggdXMsIDxhIHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL3d3dy5rb3Rhay5iYW5rLmluL2VuL3JlYWNoLXVzLmh0bWwiPmNsaWNrIGhlcmU8L2E-LjwvcD48c3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IHRleHQtZGVjb3JhdGlvbjogbm9uZSI-PGEgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vd3d3LmtvdGFrLmJhbmsuaW4vZW4vZGlzY2xhaW1lci5odG1sIj5EaXNjbGFpbWVyPC9hPjwvc3R5bGU-PGJyPjxicj48YSB0YXJnZXQ9Il9ibGFuayIgaHJlZj0iaHR0cHM6Ly93d3cua290YWsuYmFuay5pbi9lbi9jYW1wYWlnbnMvZW1haWwtZm9vdGVyLXVybC5odG1sIj48aW1nIHNyYz0iaHR0cHM6Ly93d3cua290YWsuYmFuay5pbi9jb250ZW50L2RhbS9Lb3Rhay9lbWFpbC1jYW1wYWlnbnMvZW1haWxmb290ZXItd2hhdHNhcHAucG5nIj48L2E-PGJyPjwvaHRtbD4="}}]},"sizeEstimate":5292,"historyId":"2854085","internalDate":"1768102210000"}', '2026-01-11T04:56:22.958Z', '19bab1ade66ff6f5', '19bab1ade66ff6f5', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('d82204612bd4dc09b90ebd83c14cfbe3', '101f04af63cbefc2bf8f0a98b9ae1205', 'Seller Notification <seller-notification@amazon.in>', 'Sold, ship now: Atom-999 Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem & Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop & Professional Use', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        

<!--[if gte mso 15]>
<xml>
	<o:OfficeDocumentSettings>
	<o:AllowPNG/>
	<o:PixelsPerInch>96</o:PixelsPerInch>
	</o:OfficeDocumentSettings>
</xml>
<![endif]-->
<meta charset="UTF-8">
<!--[if !mso]><!-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--<![endif]-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="http://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet" type="text/css">
<style type="text/css">
	
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 300;
    src: local(''Amazon Ember Light''), local(''AmazonEmber-Light''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 300;
    src: local(''Amazon Ember Light Italic''), local(''AmazonEmber-LightItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 400;
    src: local(''Amazon Ember''), local(''AmazonEmber''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 400;
    src: local(''Amazon Ember Italic''), local(''AmazonEmber-Italic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 600;
    src: local(''Amazon Ember Medium''), local(''AmazonEmber-Medium''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 600;
    src: local(''Amazon Ember Medium Italic''), local(''AmazonEmber-MediumItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 700;
    src: local(''Amazon Ember Bold''), local(''AmazonEmber-Bold''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 700;
    src: local(''Amazon Ember Bold Italic''), local(''AmazonEmber-BoldItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff) format(''woff'');
}



	.nbus-survey{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:visited{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:hover{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:focus{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:active{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	
	one-column{border-spacing:0px;background-color:#FFFFFF;border:0px;padding:0px;width:100%;column-count:1;}
	endrImageBlock{padding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrImageBlockInner{padding:0px;}
	endrImageContentContainer{adding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrTextContentContainer{min-width:100%;width:100%;border-collapse:collapse;background-color:#FFFFFF;border:0px;padding:0px;border-spacing:0px;}
	endrTextBlock{min-width:100%;border-collapse:collapse;background-color:#ffffff;width:100%padding:0px;border-spacing:0px;border:0px;}
	preview-text{display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';}
	
	p{
	text-align: left;
	margin-top:10px;
	margin-bottom:10px;
	margin-right:0;
	margin-left:0;
	padding-top:0;
	padding-bottom:0;
	padding-right:0;
	padding-left:0;
	line-height:185%;
	}
	table{
	border-collapse:collapse;
	}
	h1,h2,h3,h4,h5,h6{
	display:block;
	margin:0;
	padding:0;
	}
	img,a img{
	border:0;
	height:auto;
	outline:none;
	text-decoration:none;
	}
	pre{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	font-family:''Amazon Ember'';
	min-width:100%;
	white-space: pre-wrap;       /* Since CSS 2.1 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
	}
	body,#bodyTable,#bodyCell{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	background-color:#e4e3e4;
	color:#999999
	font-family:''Amazon Ember'';
	min-width:100%;
	}
	#outlook a{
	padding:0;
	}
	img{
	-ms-interpolation-mode:bicubic;
	}
	table{
	mso-table-lspace:0pt;
	mso-table-rspace:0pt;
	}
	.ReadMsgBody{
	width:100%;
	}
	.ExternalClass{
	width:100%;
	}
	p,a,li,td,blockquote{
	mso-line-height-rule:exactly;
	}
	a[href^=tel],a[href^=sms]{
	color:inherit;
	cursor:default;
	text-decoration:none;
	}
	p,a,li,td,body,table,blockquote{
	-ms-text-size-adjust:100%;
	-webkit-text-size-adjust:100%;
	}
	.ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{
	line-height:100%;
	}
	a[x-apple-data-detectors]{
	color:inherit !important;
	text-decoration:none !important;
	font-size:inherit !important;
	font-family:inherit !important;
	font-weight:inherit !important;
	line-height:inherit !important;
	}
	.templateContainer{
	max-width:600px !important;
	}
	.endrImage{
	vertical-align:bottom;
	}
	.endrTextContent{
	word-break:break-word;
	padding-top:15px;
	padding-bottom:10px;
	padding-right:18px;
	padding-left:18px;
	text-align: left;
	}
	.endrTextContent img{
	height:auto !important;
	}
	.endrDividerBlock{
	table-layout:fixed !important;
	}
	body { margin:0 !important; }
	div[style*="margin: 16px 0"] { margin:0 !important; }

	body,#bodyTable{
	background-color:#e4e3e4;
	color:#999999;
	font-family: ''Amazon Ember'';
	}
	
	.templateBlocks{
	background-color:#FFFFFF;
	border-top-width:0;
	border-bottom-width:0;
	padding-top:0;
	padding-bottom:0;
	font-size:15px;
	line-height:185%;
	text-align:left;
	background-color:#FFFFFF;
	}
	
	.templateQuoteBlocks{
	background-color:#F04D44;
	}
	
	#bodyCell{
	border-top:0;
	}

	h1{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:30px;
	font-style:normal;
	font-weight:normal;
	line-height:120%;
	letter-spacing:normal;
	padding-top:2px;
	padding-bottom:2px;
	}

	a{
	color:#e74c3c;
	font-weight:normal;
	text-decoration:underline;
	}

	h2{
	color:#848484;
	font-family: ''Amazon Ember'';
	font-size:15px;
	font-style:normal;
	font-weight:normal;
	line-height:145%;
	letter-spacing:1px;
	padding-top:5px;
	padding-bottom:4px;
	}

	h3{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:140%;
	letter-spacing:normal;
	text-align:left;
	padding-top:2px;
	padding-bottom:2px;
	}

	h4{
	color:#666666;
	font-family: ''Amazon Ember'';
	font-size:16px;
	font-style:normal;
	font-weight:normal;
	line-height:125%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-bottom:4px;
	}

	h5{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	h6{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:26px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:right;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	#templatePreheader{
	border-top:0;
	border-bottom:0;
	padding-top:4px;
	padding-bottom:12px;
	}

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templatePreheader .endrTextContent a,#templatePreheader .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}

	#templateHeader{
	background-color:#303942;
	border-top:0px solid #e4e3e4;
	border-bottom:0;
	padding-top:0px;
	padding-bottom:0px;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent h1{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent a,#templateHeader .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:none;
	}

	#templateSeparator{
	padding-top:8px;
	padding-bottom:8px;
	}

	.templateLowerBody{
	background-color:#455C64;
	border-bottom:0;
	padding-top:1px;
	padding-bottom:1px;
	}

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:150%;
	text-align:left;
	}

	.templateLowerBody .endrTextContent a,.templateLowerBody .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:underline;
	}

	.templateLowerBody .endrTextContent h1 {
	color:#ffffff;
	font-weight:700;
	font-size:18px;
	}

	.templateSocial{
	background-color:#e4e3e4;
	padding-top:13px;
	padding-bottom:3px;
	}

	#templateFooter{
	border-top:0;
	border-bottom:0;
	padding-top:5px;
	padding-bottom:5px;
	}

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templateFooter .endrTextContent a,#templateFooter .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}
	
	@media only screen and (min-width:768px){
	.templateContainer{
	width:600px !important;
	}
	}	
	
	@media only screen and (max-width: 480px){
	
	.templateHeader{
		display: none;
	}
		
	.bigimage .endrImageContent{
	padding-top:0px !important;

	}
	.templateContainer{
	width:100% !important;
	max-width:600px;
	}	@media only screen and (max-width: 480px){
	body,table,td,p,a,li,blockquote{
	-webkit-text-size-adjust:none !important;
	}
	}	@media only screen and (max-width: 480px){
	body{
	width:100% !important;
	min-width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	#bodyCell{
	padding-top:10px !important;
	}
	}	@media only screen and (max-width: 480px){
	.columnWrapper{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImage{
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionTopContent,.endrCaptionBottomContent,.endrTextContentContainer,.endrBoxedTextContentContainer,.endrImageGroupContentContainer,.endrCaptionLeftTextContentContainer,.endrCaptionRightTextContentContainer,.endrCaptionLeftImageContentContainer,.endrCaptionRightImageContentContainer,.endrImageCardLeftTextContentContainer,.endrImageCardRightTextContentContainer{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrBoxedTextContentContainer{
	min-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.column{
	width:100% !important;
	max-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.endrImageGroupContent{
	padding:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionLeftContentOuter .endrTextContent,.endrCaptionRightContentOuter .endrTextContent{
	padding-top:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardTopImageContent,.endrCaptionBlockInner .endrCaptionTopContent:last-child .endrTextContent{
	padding-top:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardBottomImageContent{
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockInner{
	padding-top:0 !important;
	padding-bottom:0 !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockOuter{
	padding-top:9px !important;
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrTextContent,.endrBoxedTextContentColumn{
	padding-right:18px !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardLeftImageContent,.endrImageCardRightImageContent{
	padding-right:18px !important;
	padding-bottom:0 !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.mcpreview-image-uploader{
	display:none !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){

	h1{
	font-size:22px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h2{
	font-size:20px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h3{
	font-size:18px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h4{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){
	
	.endrBoxedTextContentContainer .endrTextContent,.endrBoxedTextContentContainer .endrTextContent p{
	font-size:14px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader{
	display:block !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	font-size:16px !important;
	line-height:100% !important;
	text-align:center !important;
	}

	#templateHeader .endrTextContent, #templateHeader .endrTextContent h1{
	font-size:20px !important;
	line-height:100% !important;
	padding-bottom:10px !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateUpperBody .endrTextContent,#templateUpperBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	
	}	@media only screen and (max-width: 480px){

	#templateColumns .columnContainer .endrTextContent,#templateColumns .columnContainer .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	text-align:center !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}
</style>

<!--[if mso]>
<style type="text/css">
body, table, td {font-family: ''Amazon Ember'';}
h1 {font-family: ''Amazon Ember'';}
h2 {font-family: ''Amazon Ember'';}
h3 {font-family: ''Amazon Ember'';}
h4 {font-family: ''Amazon Ember'';}
h5 {font-family: ''Amazon Ember'';}
h6 {font-family: ''Amazon Ember'';}
h7 {font-family: ''Amazon Ember'';}
p {font-family: ''Amazon Ember'';}
</style>
<![endif]-->

<!--[if gt mso 15]>
<style type="text/css" media="all">
/* Outlook 2016 Height Fix */
table, tr, td {border-collapse: collapse;}
tr {border-collapse: collapse; }
body {background-color:#ffffff;}
</style>
<![endif]-->    </head>

    <body>
        <center class="wrapper" style="width:100%;table-layout:fixed;background-color:#e4e3e4;">
  <div class="webkit" style="max-width:600px;margin:0 auto;">
      <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable" style="border-collapse:collapse;height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;width:100%;background-color:#e4e3e4;color:#5a5a5a;font-family:''Lato'', Helvetica, Arial, sans-serif;">
        <tbody><tr>
            <td align="center" valign="top" id="bodyCell" style="height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;width:100%;padding-top:10px;padding-bottom:10px;border-top-width:0;">
<!-- BEGIN TEMPLATE // -->
<!--[if (gte mso 9)|(IE)]>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;border-collapse:collapse;" >
	<tr>
	<td align="center" valign="top" width="600" style="width:600px;" >
		<![endif]-->
		<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-header>
		<tbody><tr>
		<td>
        <div style="display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';">
            Ship by: 12/01/2026, Standard Shipping
        </div>

        <!-- BLOCK Logo Center -->
 <table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" data-space-sc-header>
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
          <td class="templateHeader" valign="top" style="padding: 20px 0; padding-left:40px">
          <img align="center" alt="" src="https://m.media-amazon.com/images/G/01/SPACE/logo-selling_coach.png" width="200" style="max-width:200px;padding-bottom:0;display:inline !important;vertical-align:bottom;border-width:0;height:auto;outline-style:none;text-decoration:none;-ms-interpolation-mode:bicubic;">
          </td>
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
<!-- ENDR Header  -->


</td>
</tr>
</tbody></table>

<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;background-color:#ffffff;" bgcolor="#ffffff">
<tbody><tr>
<td>
        <table class="one-column">
            <tbody><tr valign="top" class="templateBlocks">
                <td valign="top">
                    <table class="endrTextBlock">
                        <tbody class="endrTextBlockOuter">
                            <tr>
                                <td valign="top" class="endrTextBlockInner">
                                    <table align="left" class="endrTextContentContainer">
                                        <tbody>
                                            <tr>
                                                <td valign="top" class="endrTextContent" align="center">
                                                    <p style="text-align:left;margin-top:10px;margin-bottom:10px;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;line-height:185%;">
                                                        

                                









            </p><div style="text-align:left">
                            
    
    
    <p>Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026.</p>

                            
                    <p>Please review your order:</p>
    
                <center>
                    <div style="margin: 20px 0px 20px 10px; padding:10px; display:inline-block; background-color:#006574;">
    <a style="color:#fff; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/7c6710ff-ce65-355f-9d4e-bcc660be37fd?nt=SOLD_SHIP_NOW&amp;sk=CLSCMtSEuHUqZje61qmQ031SaGrXyA5GVz8oFbHxexPoBMRDgL6SIbs_q33HwUY4fOF1saa1c4YC6rwXZRvzZg&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9vcmRlcnMtdjMvb3JkZXIvNDA0LTQ0MDIxODUtODAwMTkzNz9yZWZfPXh4X2VtYWlsX2JvZHlfc2hpcA">
        View Order
    </a>
</div>

                            <div style="margin: 20px 0px 20px 20px; padding:10px; display:inline-block; background-color:#e3eced;">
    <a style="color:#002f36; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/a3d27493-2086-33cb-9205-743b2310164e?nt=SOLD_SHIP_NOW&amp;sk=j8cWhygTWhD2qJrU_fajmlp7XfpaX6Qxw0QgsbGfoYohzdj7wobREhfGddiOTopvBPhhIEACvYmYE0t3c9xTQg&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9oZWxwL2h1Yi9yZWZlcmVuY2UvRzIwMTM4MzM0MD9yZWZfPXh4X2VtYWlsX2JvZHlfaGVscA">
        Get Help Shipping Your Order
    </a>
</div>
    </center>
    <h3>Order Details</h3>
                                <b>Order ID:</b> 404-4402185-8001937
    <br>
                <b>Order date:</b> 11/01/2026
    <br>
                                        <b>Please ship this order using:</b> Standard Shipping
        <br>
                            <b>Collect on Delivery prepaid:</b> INR 0.00
        <br>
                            <b>Collect on Delivery amount:</b> INR 747.00
        <br>
        <br>
                                        
                                                    <b>Ship by:</b> 12/01/2026
            <br>
                                        <b>Item:</b> Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem &amp; Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop &amp; Professional Use
        <br>
                                                                    <b>Condition:</b> New
                    <br>
                                                                            <b>SKU:</b> Atom-999
        <br>
                                <b>Quantity:</b> 1
        <br>
                                            <b>Price:</b> INR 627.12
    <br>
                                                            <b>Tax:</b> INR 112.88
        <br>
                                                                                                                                                                                                                                                                                                                                                                                    <b>Amazon fees:</b> -INR 109.98
    <br>
                                                                                                                                                                                    <b>Collect on Delivery fees:</b> INR 5.94
        <br>
                                                
    
    
</div>
                                                    <p></p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody></table>


                

					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-footer data-space-sc-footer>
					<tbody><tr>
					<td>
				
					<!-- BLOCK Footer About Us -->
					<table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" dir="auto">
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<center style="margin-top: 20px;">
                        	<a style="padding: 7px 24px; text-decoration: none; background: #fff; border: 1px solid #EC937C; border-radius: 5px; color: #7F1809; font-family: ''Amazon Ember''; font-size: 13px; font-weight: 600;display: inline-block; margin-bottom: 10px" href="https://sellercentral.amazon.in/notifications/feedback?deliveryId=1389784310422346&amp;communicationName=SOLD_SHIP_NOW&amp;deliveryChannel=EMAIL">
                    <img src="https://m.media-amazon.com/images/G/01/space/icon.png" style="margin-right: 10px;vertical-align: middle;" width="20" height="20">Report an issue with this email
                  </a>
                        </center><p style="text-align:center !important;margin-top:10px;margin-bottom:10px;margin-right:10px;margin-left:15px;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;color:#ffffff;font-family:''Amazon Ember'';font-size:13px;line-height:150%;">If you have any questions visit: <a href="https://sellercentral.amazon.in/nms/sellermobile/redirect/36547e50-c067-3626-9197-4a7673b53931?nt=SOLD_SHIP_NOW&amp;sk=uOush5APnLwsX0xwlJJqhHrMdLhBpPz8ZmNcv11ewQWh8bIfqCzbfFJlDagYHbZYgj_wSSOZwJMbxD-jgZxHiw&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbg" metric="help" style="text-decoration: none; color: #ffffff;">Seller Central</a><br><br>
											    To change your email preferences visit: <a href="https://sellercentral.amazon.in/nms/redirect/c32f4f37-f1a4-3d5a-a93a-60d167f73929?nt=SOLD_SHIP_NOW&amp;sk=NTdYF2ccaEuT5QXw3T_bgdez68cAYCsEkTP5tZPtKw65M1lJzndaEkmPHgflk9mnduNPx4itz9F2WYZE4oachA&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL3JlZj1pZF9ub3RpZnByZWZfZG5hdl94eF8" metric="optout" style="text-decoration: none; color: #ffffff;">Notification Preferences</a><br><br>
																		We hope you found this message to be useful. However, if you''d rather not receive future e-mails of this sort from Amazon.com, please opt-out <a href="https://sellercentral.amazon.in/nms/redirect/6562bccd-707a-3db7-8761-b099a103d971?nt=SOLD_SHIP_NOW&amp;sk=VAv2deBCGgErbCSNAJaFywuwPYlqCfUEKTM_lazaqgdKpnn-Ht6ZIYVU-VSUP4IVUNZItvM6I7TDBx0wqhRwhw&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL29wdG91dD9vcHRvdXRJZD1hYmZkMzRjYi0zNGM4LTRlYzYtOTMxYi05YWNjYmVmZGFlOGI" metric="optout" style="text-decoration: none; color: #ffffff;">here.</a><br><br>
												Copyright  2026 Amazon, Inc, or its affiliates. All rights reserved.<br> 
												Amazon Seller Services Private Limited, 8th floor, Brigade Gateway, 26/1 Dr. Rajkumar Road, Bangalore 560055 (Karnataka)<br></p><table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
                        
                        
                        
											
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
					<!-- BLOCK Footer About Us -->
					</td>
					</tr>
					</tbody></table>
					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;">
					<tbody><tr>
					<td>
				
					</td>
					</tr>
					</tbody></table>
					<!--[if (gte mso 9)|(IE)]>
				</td>
				</tr>
			</table>
			<![endif]-->
			<!-- // END TEMPLATE -->
			</td>
		</tr>
		</tbody></table>    

</td></tr></tbody></table></div></center><img src="https://sellercentral.amazon.in/nms/img/375107ac-bd3a-3140-94da-435e2a50ef1e?sk=IZtfZRp0jcZy0g5IIXoV0jbTQxCNnUS3LthfLIqzTJ4foZaQs51dyLUBDdUoTJuYqEch7iSV8gY0HVqZQQqTFw&amp;n=1">
<div id="spc-watermark">
  <p style="font-size: 10px !important;padding-bottom: 10px !important;display: table !important;margin: 5px auto 10px !important;text-align: center !important;color: #a2a2a2 !important;font-family: ''Amazon Ember'' !important;font-weight: 400 !important;">SPC-EUAmazon-1389784310422346</p>
</div></body></html>', '2026-01-11T03:29:18.000Z', '{"id":"19bab19e331b48ed","threadId":"19ba74365c56df1b","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"Ship by: 12/01/2026, Standard Shipping Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026. Please review your order: View Order Get Help Shipping","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2548792pxc;        Sat, 10 Jan 2026 19:29:19 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IG4S7w/urvH+xIOiUAABwTp00p4n3A5QArNDcZqbSwcGjkQQVtQfWnxYIwdhRYC0ay/u2CM"},{"name":"X-Received","value":"by 2002:a05:6000:40da:b0:431:808:2d58 with SMTP id ffacd0b85a97d-432c376161bmr15423261f8f.51.1768102159025;        Sat, 10 Jan 2026 19:29:19 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768102159; cv=none;        d=google.com; s=arc-20240605;        b=FlSbZKxH0tQy3aJXaeUdMSKy3O8tj4NE6pdp5Uw293IVFaIlBjoy7pgStftiJcd4HI         a3QHSGfo24oUPYOpti0dHAqrVMF8OS/1ieZfNdLDbkCiwghpo4v5IWPsc5kH9nlgJX+c         aMWur/APAhsIZkO/r/aLkDJqOOfD+juxLRm1tB9WjfyIdv2dCH6cxWjoCYMdVOzQP09D         l/eWA/DflX25R9LbZifjOFOwdYOWJo48MDdtIMh7BFRABUkR0gb402OQBbPHMayordjt         cIAD+ntHsGPpL+8lkaRwJcxPjchuFx8+byEA9bKiYT/DVZ3/Pzc3ruqdN8nRBEuFWrA9         bQag=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=feedback-id:list-unsubscribe-post:list-unsubscribe:bounces-to         :mime-version:subject:message-id:to:reply-to:from:date         :dkim-signature:dkim-signature;        bh=ka2aznbY0ut68zqoBJ3zZXjEqKvbHlF7SBxpNj9fPGI=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=j0HlfbxgTRYZrF9JPVLce8yEk4+Zshnb5oEV9ayWkY1mn/gnLfOQ/B3ELpikZp1Dj/         KdiGDWGEVkgyBx3QOy6Rua4xy2vywPifhvvcbwozVM5x+3GDW/N750W+bvxO31Kk991G         BU9sS8xTA9Mj9LmLtYbFgVhEpCcGYaKSggmwLccihK4xMEffUVtBkAcWXAYmMK7zDGkl         FnYQW9lnO7vTx+y5LoEEX12Ws5ViVuVKazoe6FdXRn3GdGoh28MjvPzsZX12uYJ5bydN         X1o3YVtcodsTZjmuUjCnMZaUMgn7an+zbO9mjaOem1csgS7+8idWQfrpQ+44DyEPALCv         8HHA==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=PUqt+bI2;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=PF1oUOZk;       spf=pass (google.com: domain of 0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com designates 76.223.149.191 as permitted sender) smtp.mailfrom=0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"Return-Path","value":"<0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com>"},{"name":"Received","value":"from c149-191.smtp-out.eu-west-1.amazonses.com (c149-191.smtp-out.eu-west-1.amazonses.com. [76.223.149.191])        by mx.google.com with ESMTPS id ffacd0b85a97d-432bd0d9d86si23298700f8f.64.2026.01.10.19.29.18        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Sat, 10 Jan 2026 19:29:19 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of 0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com designates 76.223.149.191 as permitted sender) client-ip=76.223.149.191;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=PUqt+bI2;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=PF1oUOZk;       spf=pass (google.com: domain of 0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com designates 76.223.149.191 as permitted sender) smtp.mailfrom=0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=oispgif7zht3cwr3nad5jndkl43aztnu; d=amazon.in; t=1768102158; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post; bh=EiQuhgr3Nm3pT5tIZW/115YVvAV3Ky1dCz5NBNjjn/M=; b=PUqt+bI22sozMEAyqK3ntOgbDyFdK6W4W6tDZmcpUsFrS6fTvXgvUGk15B6xdXU2 br+rQYpLDlPjzjxTnbEa2vMx965rUEbjwzdKn+z0mXNxdA7k83ZoDJW/vMbKNi6H6qh Gt4t4yLa1AR5qJNv8ImvXPI8HP129wBOs5QLjjFhYRAAp/zx3UJbp2iqIPHT10HVe6Y luzFakHUUwgWHrtJUAEMB/4xOUAZ8rJEew/MJwTHGXboTnWHbH854JLQR+4xOO6zuUi 5X1fh55jQ4d11oAADi7Xl3xDOytDO1eStA5kG8Akp+EmvsWoooHrja6LrCjU82SyiJ4 UqKdwOLSug=="},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768102158; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post:Feedback-ID; bh=EiQuhgr3Nm3pT5tIZW/115YVvAV3Ky1dCz5NBNjjn/M=; b=PF1oUOZk8CLhoXkyP1IN5Yk3yl67wJr4KLO2bqlm5DMbnLwLz2MCRFSD/ihWt+K+ gX9qyqP8XOF5nyaQW6IzC0O1fvzUTmdOhQMyVCnERAEN5kzkOseNMGUC884hR/g+lu9 wKozycxl2oMszyauLoH7o422SkKUAa0DHQpjZpOU="},{"name":"Date","value":"Sun, 11 Jan 2026 03:29:18 +0000"},{"name":"From","value":"Seller Notification <seller-notification@amazon.in>"},{"name":"Reply-To","value":"seller-notification@amazon.in"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Message-ID","value":"<0102019bab19e0c5-3e87c0b4-0efd-4a97-8c37-b4ec2045c124-000000@eu-west-1.amazonses.com>"},{"name":"Subject","value":"Sold, ship now: Atom-999 Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem & Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop & Professional Use"},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/alternative; boundary=\"----=_Part_1396536_621865788.1768102158526\""},{"name":"Bounces-to","value":"RTE+NE-null-b1cb1A02797783JTCU7UCP03P@sellernotifications.amazon.com"},{"name":"X-Space-Message-ID","value":"1389784310422346"},{"name":"X-Marketplace-ID","value":"A21TJRUUN4KGV"},{"name":"List-Unsubscribe","value":"<https://sellercentral.amazon.in/notifications/preferences/optout/header-one-click?optoutId=abfd34cb-34c8-4ec6-931b-9accbefdae8b>"},{"name":"List-Unsubscribe-Post","value":"List-Unsubscribe=One-Click"},{"name":"Feedback-ID","value":"::1.eu-west-1.QXQDwfZxBksRk8Fey1ctk1ELdO+bec9bLwquzardhBQ=:AmazonSES"},{"name":"X-SES-Outgoing","value":"2026.01.11-76.223.149.191"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"7bit"}],"body":{"size":31284,"data":"PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg0KPGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zOnY9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206dm1sIiB4bWxuczpvPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTpvZmZpY2UiPg0KDQogICAgPGhlYWQ-DQogICAgICAgIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4NCiAgICAgICAgDQoNCjwhLS1baWYgZ3RlIG1zbyAxNV0-DQo8eG1sPg0KCTxvOk9mZmljZURvY3VtZW50U2V0dGluZ3M-DQoJPG86QWxsb3dQTkcvPg0KCTxvOlBpeGVsc1BlckluY2g-OTY8L286UGl4ZWxzUGVySW5jaD4NCgk8L286T2ZmaWNlRG9jdW1lbnRTZXR0aW5ncz4NCjwveG1sPg0KPCFbZW5kaWZdLS0-DQo8bWV0YSBjaGFyc2V0PSJVVEYtOCI-DQo8IS0tW2lmICFtc29dPjwhLS0-DQoJCTxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSI-DQoJPCEtLTwhW2VuZGlmXS0tPg0KPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIj4NCjx0aXRsZT48L3RpdGxlPg0KPGxpbmsgaHJlZj0iaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TGF0bzo0MDAsNzAwIiByZWw9InN0eWxlc2hlZXQiIHR5cGU9InRleHQvY3NzIj4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQoJDQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogbm9ybWFsOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0JyksIGxvY2FsKCdBbWF6b25FbWJlci1MaWdodCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9sdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0IEl0YWxpYycpLCBsb2NhbCgnQW1hem9uRW1iZXItTGlnaHRJdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbHRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0aXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXInKSwgbG9jYWwoJ0FtYXpvbkVtYmVyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnX2Jhc2Uud29mZjIpIGZvcm1hdCgnd29mZjInKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBpdGFsaWM7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDYwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgTWVkaXVtJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW0nKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9tZF9iYXNlLndvZmYpIGZvcm1hdCgnd29mZicpOw0KfQ0KQGZvbnQtZmFjZSB7DQogICAgZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KICAgIGZvbnQtc3R5bGU6IGl0YWxpYzsNCiAgICBmb250LXdlaWdodDogNjAwOw0KICAgIHNyYzogbG9jYWwoJ0FtYXpvbiBFbWJlciBNZWRpdW0gSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX21kaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDcwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgQm9sZCcpLCBsb2NhbCgnQW1hem9uRW1iZXItQm9sZCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkX2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiA3MDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIEJvbGQgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1Cb2xkSXRhbGljJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkaXRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZGl0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQoNCg0KDQoJLm5idXMtc3VydmV5e2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJLm5idXMtc3VydmV5OnZpc2l0ZWR7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6aG92ZXJ7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6Zm9jdXN7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6YWN0aXZle2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJDQoJb25lLWNvbHVtbntib3JkZXItc3BhY2luZzowcHg7YmFja2dyb3VuZC1jb2xvcjojRkZGRkZGO2JvcmRlcjowcHg7cGFkZGluZzowcHg7d2lkdGg6MTAwJTtjb2x1bW4tY291bnQ6MTt9DQoJZW5kckltYWdlQmxvY2t7cGFkZGluZzowcHg7Ym9yZGVyLXNwYWNpbmc6MHB4O21pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTt3aWR0aDoxMDAlO2JvcmRlcjowcHg7fQ0KCWVuZHJJbWFnZUJsb2NrSW5uZXJ7cGFkZGluZzowcHg7fQ0KCWVuZHJJbWFnZUNvbnRlbnRDb250YWluZXJ7YWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7bWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO3dpZHRoOjEwMCU7Ym9yZGVyOjBweDt9DQoJZW5kclRleHRDb250ZW50Q29udGFpbmVye21pbi13aWR0aDoxMDAlO3dpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO2JhY2tncm91bmQtY29sb3I6I0ZGRkZGRjtib3JkZXI6MHB4O3BhZGRpbmc6MHB4O2JvcmRlci1zcGFjaW5nOjBweDt9DQoJZW5kclRleHRCbG9ja3ttaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO3dpZHRoOjEwMCVwYWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7Ym9yZGVyOjBweDt9DQoJcHJldmlldy10ZXh0e2Rpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQoJDQoJcHsNCgl0ZXh0LWFsaWduOiBsZWZ0Ow0KCW1hcmdpbi10b3A6MTBweDsNCgltYXJnaW4tYm90dG9tOjEwcHg7DQoJbWFyZ2luLXJpZ2h0OjA7DQoJbWFyZ2luLWxlZnQ6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJcGFkZGluZy1yaWdodDowOw0KCXBhZGRpbmctbGVmdDowOw0KCWxpbmUtaGVpZ2h0OjE4NSU7DQoJfQ0KCXRhYmxlew0KCWJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsNCgl9DQoJaDEsaDIsaDMsaDQsaDUsaDZ7DQoJZGlzcGxheTpibG9jazsNCgltYXJnaW46MDsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZyxhIGltZ3sNCglib3JkZXI6MDsNCgloZWlnaHQ6YXV0bzsNCglvdXRsaW5lOm5vbmU7DQoJdGV4dC1kZWNvcmF0aW9uOm5vbmU7DQoJfQ0KCXByZXsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJZm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7DQoJbWluLXdpZHRoOjEwMCU7DQoJd2hpdGUtc3BhY2U6IHByZS13cmFwOyAgICAgICAvKiBTaW5jZSBDU1MgMi4xICovDQogICAgd2hpdGUtc3BhY2U6IC1tb3otcHJlLXdyYXA7ICAvKiBNb3ppbGxhLCBzaW5jZSAxOTk5ICovDQogICAgd2hpdGUtc3BhY2U6IC1wcmUtd3JhcDsgICAgICAvKiBPcGVyYSA0LTYgKi8NCiAgICB3aGl0ZS1zcGFjZTogLW8tcHJlLXdyYXA7ICAgIC8qIE9wZXJhIDcgKi8NCiAgICB3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7ICAgICAgIC8qIEludGVybmV0IEV4cGxvcmVyIDUuNSsgKi8NCgl9DQoJYm9keSwjYm9keVRhYmxlLCNib2R5Q2VsbHsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCWNvbG9yOiM5OTk5OTkNCglmb250LWZhbWlseTonQW1hem9uIEVtYmVyJzsNCgltaW4td2lkdGg6MTAwJTsNCgl9DQoJI291dGxvb2sgYXsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZ3sNCgktbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7DQoJfQ0KCXRhYmxlew0KCW1zby10YWJsZS1sc3BhY2U6MHB0Ow0KCW1zby10YWJsZS1yc3BhY2U6MHB0Ow0KCX0NCgkuUmVhZE1zZ0JvZHl7DQoJd2lkdGg6MTAwJTsNCgl9DQoJLkV4dGVybmFsQ2xhc3N7DQoJd2lkdGg6MTAwJTsNCgl9DQoJcCxhLGxpLHRkLGJsb2NrcXVvdGV7DQoJbXNvLWxpbmUtaGVpZ2h0LXJ1bGU6ZXhhY3RseTsNCgl9DQoJYVtocmVmXj10ZWxdLGFbaHJlZl49c21zXXsNCgljb2xvcjppbmhlcml0Ow0KCWN1cnNvcjpkZWZhdWx0Ow0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCglwLGEsbGksdGQsYm9keSx0YWJsZSxibG9ja3F1b3Rlew0KCS1tcy10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJfQ0KCS5FeHRlcm5hbENsYXNzLC5FeHRlcm5hbENsYXNzIHAsLkV4dGVybmFsQ2xhc3MgdGQsLkV4dGVybmFsQ2xhc3MgZGl2LC5FeHRlcm5hbENsYXNzIHNwYW4sLkV4dGVybmFsQ2xhc3MgZm9udHsNCglsaW5lLWhlaWdodDoxMDAlOw0KCX0NCglhW3gtYXBwbGUtZGF0YS1kZXRlY3RvcnNdew0KCWNvbG9yOmluaGVyaXQgIWltcG9ydGFudDsNCgl0ZXh0LWRlY29yYXRpb246bm9uZSAhaW1wb3J0YW50Ow0KCWZvbnQtc2l6ZTppbmhlcml0ICFpbXBvcnRhbnQ7DQoJZm9udC1mYW1pbHk6aW5oZXJpdCAhaW1wb3J0YW50Ow0KCWZvbnQtd2VpZ2h0OmluaGVyaXQgIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDppbmhlcml0ICFpbXBvcnRhbnQ7DQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgltYXgtd2lkdGg6NjAwcHggIWltcG9ydGFudDsNCgl9DQoJLmVuZHJJbWFnZXsNCgl2ZXJ0aWNhbC1hbGlnbjpib3R0b207DQoJfQ0KCS5lbmRyVGV4dENvbnRlbnR7DQoJd29yZC1icmVhazpicmVhay13b3JkOw0KCXBhZGRpbmctdG9wOjE1cHg7DQoJcGFkZGluZy1ib3R0b206MTBweDsNCglwYWRkaW5nLXJpZ2h0OjE4cHg7DQoJcGFkZGluZy1sZWZ0OjE4cHg7DQoJdGV4dC1hbGlnbjogbGVmdDsNCgl9DQoJLmVuZHJUZXh0Q29udGVudCBpbWd7DQoJaGVpZ2h0OmF1dG8gIWltcG9ydGFudDsNCgl9DQoJLmVuZHJEaXZpZGVyQmxvY2t7DQoJdGFibGUtbGF5b3V0OmZpeGVkICFpbXBvcnRhbnQ7DQoJfQ0KCWJvZHkgeyBtYXJnaW46MCAhaW1wb3J0YW50OyB9DQoJZGl2W3N0eWxlKj0ibWFyZ2luOiAxNnB4IDAiXSB7IG1hcmdpbjowICFpbXBvcnRhbnQ7IH0NCg0KCWJvZHksI2JvZHlUYWJsZXsNCgliYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7DQoJY29sb3I6Izk5OTk5OTsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJfQ0KCQ0KCS50ZW1wbGF0ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGRkZGRkY7DQoJYm9yZGVyLXRvcC13aWR0aDowOw0KCWJvcmRlci1ib3R0b20td2lkdGg6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJZm9udC1zaXplOjE1cHg7DQoJbGluZS1oZWlnaHQ6MTg1JTsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJYmFja2dyb3VuZC1jb2xvcjojRkZGRkZGOw0KCX0NCgkNCgkudGVtcGxhdGVRdW90ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGMDRENDQ7DQoJfQ0KCQ0KCSNib2R5Q2VsbHsNCglib3JkZXItdG9wOjA7DQoJfQ0KDQoJaDF7DQoJY29sb3I6IzQ1NWM2NDsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjMwcHg7DQoJZm9udC1zdHlsZTpub3JtYWw7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCWxpbmUtaGVpZ2h0OjEyMCU7DQoJbGV0dGVyLXNwYWNpbmc6bm9ybWFsOw0KCXBhZGRpbmctdG9wOjJweDsNCglwYWRkaW5nLWJvdHRvbToycHg7DQoJfQ0KDQoJYXsNCgljb2xvcjojZTc0YzNjOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCWgyew0KCWNvbG9yOiM4NDg0ODQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxNXB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDUlOw0KCWxldHRlci1zcGFjaW5nOjFweDsNCglwYWRkaW5nLXRvcDo1cHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWgzew0KCWNvbG9yOiM0NTVjNjQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDAlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MnB4Ow0KCXBhZGRpbmctYm90dG9tOjJweDsNCgl9DQoNCgloNHsNCgljb2xvcjojNjY2NjY2Ow0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTZweDsNCglmb250LXN0eWxlOm5vcm1hbDsNCglmb250LXdlaWdodDpub3JtYWw7DQoJbGluZS1oZWlnaHQ6MTI1JTsNCglsZXR0ZXItc3BhY2luZzpub3JtYWw7DQoJdGV4dC1hbGlnbjpsZWZ0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWg1ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MTFweDsNCglwYWRkaW5nLXJpZ2h0OjIwcHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCXBhZGRpbmctbGVmdDoyMHB4Ow0KCX0NCg0KCWg2ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyNnB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1yaWdodDoyMHB4Ow0KCXBhZGRpbmctYm90dG9tOjhweDsNCglwYWRkaW5nLWxlZnQ6MjBweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXJ7DQoJYm9yZGVyLXRvcDowOw0KCWJvcmRlci1ib3R0b206MDsNCglwYWRkaW5nLXRvcDo0cHg7DQoJcGFkZGluZy1ib3R0b206MTJweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxMnB4Ow0KCWxpbmUtaGVpZ2h0OjE1MCU7DQoJdGV4dC1hbGlnbjpjZW50ZXI7DQoJfQ0KDQoJI3RlbXBsYXRlUHJlaGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgYSwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwIGF7DQoJY29sb3I6I2ZiZmJmYjsNCglmb250LXdlaWdodDpub3JtYWw7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsNCgl9DQoNCgkjdGVtcGxhdGVIZWFkZXJ7DQoJYmFja2dyb3VuZC1jb2xvcjojMzAzOTQyOw0KCWJvcmRlci10b3A6MHB4IHNvbGlkICNlNGUzZTQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjBweDsNCglwYWRkaW5nLWJvdHRvbTowcHg7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxMDAlOw0KCXRleHQtYWxpZ246cmlnaHQ7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgaDF7DQoJY29sb3I6I2ZmZmZmZjsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjIwcHg7DQoJbGluZS1oZWlnaHQ6MTAwJTsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCg0KCSN0ZW1wbGF0ZVNlcGFyYXRvcnsNCglwYWRkaW5nLXRvcDo4cHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keXsNCgliYWNrZ3JvdW5kLWNvbG9yOiM0NTVDNjQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjFweDsNCglwYWRkaW5nLWJvdHRvbToxcHg7DQoJfQ0KDQoJLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQsLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246bGVmdDsNCgl9DQoNCgkudGVtcGxhdGVMb3dlckJvZHkgLmVuZHJUZXh0Q29udGVudCBhLC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHAgYXsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IGgxIHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0OjcwMDsNCglmb250LXNpemU6MThweDsNCgl9DQoNCgkudGVtcGxhdGVTb2NpYWx7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCXBhZGRpbmctdG9wOjEzcHg7DQoJcGFkZGluZy1ib3R0b206M3B4Ow0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlcnsNCglib3JkZXItdG9wOjA7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjVweDsNCglwYWRkaW5nLWJvdHRvbTo1cHg7DQoJfQ0KDQoJI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmJmYmZiOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTJweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246Y2VudGVyOw0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7DQoJfQ0KCQ0KCUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDo3NjhweCl7DQoJLnRlbXBsYXRlQ29udGFpbmVyew0KCXdpZHRoOjYwMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JDQoJDQoJQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLnRlbXBsYXRlSGVhZGVyew0KCQlkaXNwbGF5OiBub25lOw0KCX0NCgkJDQoJLmJpZ2ltYWdlIC5lbmRySW1hZ2VDb250ZW50ew0KCXBhZGRpbmctdG9wOjBweCAhaW1wb3J0YW50Ow0KDQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgl3aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJbWF4LXdpZHRoOjYwMHB4Ow0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJYm9keSx0YWJsZSx0ZCxwLGEsbGksYmxvY2txdW90ZXsNCgktd2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6bm9uZSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCWJvZHl7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCW1pbi13aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJI2JvZHlDZWxsew0KCXBhZGRpbmctdG9wOjEwcHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uV3JhcHBlcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25Ub3BDb250ZW50LC5lbmRyQ2FwdGlvbkJvdHRvbUNvbnRlbnQsLmVuZHJUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJJbWFnZUdyb3VwQ29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0VGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJDYXB0aW9uUmlnaHRUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRyQ2FwdGlvblJpZ2h0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkTGVmdFRleHRDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkUmlnaHRUZXh0Q29udGVudENvbnRhaW5lcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXJ7DQoJbWluLXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfSBAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9IEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VHcm91cENvbnRlbnR7DQoJcGFkZGluZzo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25MZWZ0Q29udGVudE91dGVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJDYXB0aW9uUmlnaHRDb250ZW50T3V0ZXIgLmVuZHJUZXh0Q29udGVudHsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZFRvcEltYWdlQ29udGVudCwuZW5kckNhcHRpb25CbG9ja0lubmVyIC5lbmRyQ2FwdGlvblRvcENvbnRlbnQ6bGFzdC1jaGlsZCAuZW5kclRleHRDb250ZW50ew0KCXBhZGRpbmctdG9wOjE4cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZEJvdHRvbUltYWdlQ29udGVudHsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlR3JvdXBCbG9ja0lubmVyew0KCXBhZGRpbmctdG9wOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTowICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJLmVuZHJJbWFnZUdyb3VwQmxvY2tPdXRlcnsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kclRleHRDb250ZW50LC5lbmRyQm94ZWRUZXh0Q29udGVudENvbHVtbnsNCglwYWRkaW5nLXJpZ2h0OjE4cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VDYXJkTGVmdEltYWdlQ29udGVudCwuZW5kckltYWdlQ2FyZFJpZ2h0SW1hZ2VDb250ZW50ew0KCXBhZGRpbmctcmlnaHQ6MThweCAhaW1wb3J0YW50Ow0KCXBhZGRpbmctYm90dG9tOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5tY3ByZXZpZXctaW1hZ2UtdXBsb2FkZXJ7DQoJZGlzcGxheTpub25lICFpbXBvcnRhbnQ7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDF7DQoJZm9udC1zaXplOjIycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxMjUlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgloMnsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEyNSUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCWgzew0KCWZvbnQtc2l6ZToxOHB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTI1JSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDR7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTRweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZVByZWhlYWRlcnsNCglkaXNwbGF5OmJsb2NrICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxMnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCgl0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50LCAjdGVtcGxhdGVIZWFkZXIgLmVuZHJUZXh0Q29udGVudCBoMXsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbToxMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxNnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgkNCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50LC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJdGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50LCN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjEycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0NCjwvc3R5bGU-DQoNCjwhLS1baWYgbXNvXT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQpib2R5LCB0YWJsZSwgdGQge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoMSB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmgyIHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDMge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNCB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmg1IHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDYge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNyB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCnAge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQo8L3N0eWxlPg0KPCFbZW5kaWZdLS0-DQoNCjwhLS1baWYgZ3QgbXNvIDE1XT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgbWVkaWE9ImFsbCI-DQovKiBPdXRsb29rIDIwMTYgSGVpZ2h0IEZpeCAqLw0KdGFibGUsIHRyLCB0ZCB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTt9DQp0ciB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgfQ0KYm9keSB7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO30NCjwvc3R5bGU-DQo8IVtlbmRpZl0tLT4gICAgPC9oZWFkPg0KDQogICAgPGJvZHk-DQogICAgICAgIDxjZW50ZXIgY2xhc3M9IndyYXBwZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO3RhYmxlLWxheW91dDpmaXhlZDtiYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7Ij4NCiAgPGRpdiBjbGFzcz0id2Via2l0IiBzdHlsZT0ibWF4LXdpZHRoOjYwMHB4O21hcmdpbjowIGF1dG87Ij4NCiAgICAgIDx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgaGVpZ2h0PSIxMDAlIiB3aWR0aD0iMTAwJSIgaWQ9ImJvZHlUYWJsZSIgc3R5bGU9ImJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTtoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDt3aWR0aDoxMDAlO2JhY2tncm91bmQtY29sb3I6I2U0ZTNlNDtjb2xvcjojNWE1YTVhO2ZvbnQtZmFtaWx5OidMYXRvJywgSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsiPg0KICAgICAgICA8dGJvZHk-PHRyPg0KICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiBpZD0iYm9keUNlbGwiIHN0eWxlPSJoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7d2lkdGg6MTAwJTtwYWRkaW5nLXRvcDoxMHB4O3BhZGRpbmctYm90dG9tOjEwcHg7Ym9yZGVyLXRvcC13aWR0aDowOyI-DQo8IS0tIEJFR0lOIFRFTVBMQVRFIC8vIC0tPg0KPCEtLVtpZiAoZ3RlIG1zbyA5KXwoSUUpXT4NCjx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgd2lkdGg9IjYwMCIgc3R5bGU9IndpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiID4NCgk8dHI-DQoJPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiB3aWR0aD0iNjAwIiBzdHlsZT0id2lkdGg6NjAwcHg7IiA-DQoJCTwhW2VuZGlmXS0tPg0KCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGRhdGEtc3BhY2UtaGVhZGVyPg0KCQk8dGJvZHk-PHRyPg0KCQk8dGQ-DQogICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsiPg0KICAgICAgICAgICAgU2hpcCBieTogMTIvMDEvMjAyNiwgU3RhbmRhcmQgU2hpcHBpbmcNCiAgICAgICAgPC9kaXY-DQoNCiAgICAgICAgPCEtLSBCTE9DSyBMb2dvIENlbnRlciAtLT4NCiA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjA7IiBkYXRhLXNwYWNlLXNjLWhlYWRlcj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICA8dGQgY2xhc3M9InRlbXBsYXRlSGVhZGVyIiB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6IDIwcHggMDsgcGFkZGluZy1sZWZ0OjQwcHgiPg0KICAgICAgICAgIDxpbWcgYWxpZ249ImNlbnRlciIgYWx0PSIiIHNyYz0iaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvU1BBQ0UvbG9nby1zZWxsaW5nX2NvYWNoLnBuZyIgd2lkdGg9IjIwMCIgc3R5bGU9Im1heC13aWR0aDoyMDBweDtwYWRkaW5nLWJvdHRvbTowO2Rpc3BsYXk6aW5saW5lICFpbXBvcnRhbnQ7dmVydGljYWwtYWxpZ246Ym90dG9tO2JvcmRlci13aWR0aDowO2hlaWdodDphdXRvO291dGxpbmUtc3R5bGU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTstbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7Ij4NCiAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCjwhLS0gRU5EUiBIZWFkZXIgIC0tPg0KDQoNCjwvdGQ-DQo8L3RyPg0KPC90Ym9keT48L3RhYmxlPg0KDQo8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmOyIgYmdjb2xvcj0iI2ZmZmZmZiI-DQo8dGJvZHk-PHRyPg0KPHRkPg0KICAgICAgICA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iPg0KICAgICAgICAgICAgPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlQmxvY2tzIj4NCiAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiPg0KICAgICAgICAgICAgICAgICAgICA8dGFibGUgY2xhc3M9ImVuZHJUZXh0QmxvY2siPg0KICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5IGNsYXNzPSJlbmRyVGV4dEJsb2NrT3V0ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0iZW5kclRleHRCbG9ja0lubmVyIj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0YWJsZSBhbGlnbj0ibGVmdCIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnQiIGFsaWduPSJjZW50ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7bWFyZ2luLXRvcDoxMHB4O21hcmdpbi1ib3R0b206MTBweDttYXJnaW4tcmlnaHQ6MDttYXJnaW4tbGVmdDowO3BhZGRpbmctdG9wOjA7cGFkZGluZy1ib3R0b206MDtwYWRkaW5nLXJpZ2h0OjA7cGFkZGluZy1sZWZ0OjA7bGluZS1oZWlnaHQ6MTg1JTsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KDQoNCg0KDQoNCg0KDQoNCiAgICAgICAgICAgIDwvcD48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgIA0KICAgIA0KICAgIDxwPkNvbmdyYXR1bGF0aW9ucywgeW91IGhhdmUgYSBuZXcgb3JkZXIgb24gQW1hem9uISBZb3VyIGN1c3RvbWVyIGlzIGV4cGVjdGluZyB0aGlzIHRvIHNoaXAgYnkgMTIvMDEvMjAyNi48L3A-DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgPHA-UGxlYXNlIHJldmlldyB5b3VyIG9yZGVyOjwvcD4NCiAgICANCiAgICAgICAgICAgICAgICA8Y2VudGVyPg0KICAgICAgICAgICAgICAgICAgICA8ZGl2IHN0eWxlPSJtYXJnaW46IDIwcHggMHB4IDIwcHggMTBweDsgcGFkZGluZzoxMHB4OyBkaXNwbGF5OmlubGluZS1ibG9jazsgYmFja2dyb3VuZC1jb2xvcjojMDA2NTc0OyI-DQogICAgPGEgc3R5bGU9ImNvbG9yOiNmZmY7IHRleHQtZGVjb3JhdGlvbjpub25lOyIgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvc2VsbGVybW9iaWxlL3JlZGlyZWN0LzdjNjcxMGZmLWNlNjUtMzU1Zi05ZDRlLWJjYzY2MGJlMzdmZD9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1DTFNDTXRTRXVIVXFaamU2MXFtUTAzMVNhR3JYeUE1R1Z6OG9GYkh4ZXhQb0JNUkRnTDZTSWJzX3EzM0h3VVk0Zk9GMXNhYTFjNFlDNnJ3WFpSdnpaZyZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl2Y21SbGNuTXRkak12YjNKa1pYSXZOREEwTFRRME1ESXhPRFV0T0RBd01Ua3pOejl5WldaZlBYaDRYMlZ0WVdsc1gySnZaSGxmYzJocGNBIj4NCiAgICAgICAgVmlldyBPcmRlcg0KICAgIDwvYT4NCjwvZGl2Pg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luOiAyMHB4IDBweCAyMHB4IDIwcHg7IHBhZGRpbmc6MTBweDsgZGlzcGxheTppbmxpbmUtYmxvY2s7IGJhY2tncm91bmQtY29sb3I6I2UzZWNlZDsiPg0KICAgIDxhIHN0eWxlPSJjb2xvcjojMDAyZjM2OyB0ZXh0LWRlY29yYXRpb246bm9uZTsiIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC9hM2QyNzQ5My0yMDg2LTMzY2ItOTIwNS03NDNiMjMxMDE2NGU_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9ajhjV2h5Z1RXaEQycUpyVV9mYWptbHA3WGZwYVg2UXh3MFFnc2JHZm9Zb2h6ZGo3d29iUkVoZkdkZGlPVG9wdkJQaGhJRUFDdlltWUUwdDNjOXhUUWcmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5b1pXeHdMMmgxWWk5eVpXWmxjbVZ1WTJVdlJ6SXdNVE00TXpNME1EOXlaV1pmUFhoNFgyVnRZV2xzWDJKdlpIbGZhR1ZzY0EiPg0KICAgICAgICBHZXQgSGVscCBTaGlwcGluZyBZb3VyIE9yZGVyDQogICAgPC9hPg0KPC9kaXY-DQogICAgPC9jZW50ZXI-DQogICAgPGgzPk9yZGVyIERldGFpbHM8L2gzPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5PcmRlciBJRDo8L2I-IDQwNC00NDAyMTg1LTgwMDE5MzcNCiAgICA8YnI-DQogICAgICAgICAgICAgICAgPGI-T3JkZXIgZGF0ZTo8L2I-IDExLzAxLzIwMjYNCiAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UGxlYXNlIHNoaXAgdGhpcyBvcmRlciB1c2luZzo8L2I-IFN0YW5kYXJkIFNoaXBwaW5nDQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db2xsZWN0IG9uIERlbGl2ZXJ5IHByZXBhaWQ6PC9iPiBJTlIgMC4wMA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-Q29sbGVjdCBvbiBEZWxpdmVyeSBhbW91bnQ6PC9iPiBJTlIgNzQ3LjAwDQogICAgICAgIDxicj4NCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNoaXAgYnk6PC9iPiAxMi8wMS8yMDI2DQogICAgICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-SXRlbTo8L2I-IEdyaXBpdCBEaWdpdGFsIEpld2VsbGVyeSBXZWlnaGluZyBTY2FsZSAxMDAwZyB4IDAuMDFnIC0gUG9ydGFibGUgR29sZCwgU2lsdmVyLCBHZW0gJmFtcDsgQ29pbiBXZWlnaGluZyBNYWNoaW5lIHdpdGggTENEIERpc3BsYXkgLSBQcmVjaXNpb24gV2VpZ2h0IFNjYWxlIGZvciBIb21lLCBTaG9wICZhbXA7IFByb2Zlc3Npb25hbCBVc2UNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db25kaXRpb246PC9iPiBOZXcNCiAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNLVTo8L2I-IEF0b20tOTk5DQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UXVhbnRpdHk6PC9iPiAxDQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UHJpY2U6PC9iPiBJTlIgNjI3LjEyDQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-VGF4OjwvYj4gSU5SIDExMi44OA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5BbWF6b24gZmVlczo8L2I-IC1JTlIgMTA5Ljk4DQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-Q29sbGVjdCBvbiBEZWxpdmVyeSBmZWVzOjwvYj4gSU5SIDUuOTQNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgDQogICAgDQo8L2Rpdj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cD48L3A-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgIDwvdGQ-DQogICAgICAgICAgICA8L3RyPg0KICAgICAgICA8L3Rib2R5PjwvdGFibGU-DQoNCg0KICAgICAgICAgICAgICAgIA0KDQoJCQkJCQ0KCQkJCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7IiBkYXRhLXNwYWNlLWZvb3RlciBkYXRhLXNwYWNlLXNjLWZvb3Rlcj4NCgkJCQkJPHRib2R5Pjx0cj4NCgkJCQkJPHRkPg0KCQkJCQ0KCQkJCQk8IS0tIEJMT0NLIEZvb3RlciBBYm91dCBVcyAtLT4NCgkJCQkJPHRhYmxlIGNsYXNzPSJvbmUtY29sdW1uIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3JkZXItc3BhY2luZzowOyIgZGlyPSJhdXRvIj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8Y2VudGVyIHN0eWxlPSJtYXJnaW4tdG9wOiAyMHB4OyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPGEgc3R5bGU9InBhZGRpbmc6IDdweCAyNHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGJhY2tncm91bmQ6ICNmZmY7IGJvcmRlcjogMXB4IHNvbGlkICNFQzkzN0M7IGJvcmRlci1yYWRpdXM6IDVweDsgY29sb3I6ICM3RjE4MDk7IGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsgZm9udC1zaXplOiAxM3B4OyBmb250LXdlaWdodDogNjAwO2Rpc3BsYXk6IGlubGluZS1ibG9jazsgbWFyZ2luLWJvdHRvbTogMTBweCIgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL2ZlZWRiYWNrP2RlbGl2ZXJ5SWQ9MTM4OTc4NDMxMDQyMjM0NiZhbXA7Y29tbXVuaWNhdGlvbk5hbWU9U09MRF9TSElQX05PVyZhbXA7ZGVsaXZlcnlDaGFubmVsPUVNQUlMIj4NCiAgICAgICAgICAgICAgICAgICAgPGltZyBzcmM9Imh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL3NwYWNlL2ljb24ucG5nIiBzdHlsZT0ibWFyZ2luLXJpZ2h0OiAxMHB4O3ZlcnRpY2FsLWFsaWduOiBtaWRkbGU7IiB3aWR0aD0iMjAiIGhlaWdodD0iMjAiPlJlcG9ydCBhbiBpc3N1ZSB3aXRoIHRoaXMgZW1haWwNCiAgICAgICAgICAgICAgICAgIDwvYT4NCiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2VudGVyPjxwIHN0eWxlPSJ0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50O21hcmdpbi10b3A6MTBweDttYXJnaW4tYm90dG9tOjEwcHg7bWFyZ2luLXJpZ2h0OjEwcHg7bWFyZ2luLWxlZnQ6MTVweDtwYWRkaW5nLXRvcDowO3BhZGRpbmctYm90dG9tOjA7cGFkZGluZy1yaWdodDowO3BhZGRpbmctbGVmdDowO2NvbG9yOiNmZmZmZmY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTsiPklmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMgdmlzaXQ6IDxhIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC8zNjU0N2U1MC1jMDY3LTM2MjYtOTE5Ny00YTc2NzNiNTM5MzE_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9dU91c2g1QVBuTHdzWDB4d2xKSnFoSHJNZExoQnBQejhabU5jdjExZXdRV2g4YklmcUN6YmZGSmxEYWdZSGJaWWdqX3dTU09ad0pNYnhELWpnWnhIaXcmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmciIG1ldHJpYz0iaGVscCIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgY29sb3I6ICNmZmZmZmY7Ij5TZWxsZXIgQ2VudHJhbDwvYT48YnI-PGJyPg0KCQkJCQkJCQkJCQkgICAgVG8gY2hhbmdlIHlvdXIgZW1haWwgcHJlZmVyZW5jZXMgdmlzaXQ6IDxhIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3JlZGlyZWN0L2MzMmY0ZjM3LWYxYTQtM2Q1YS1hOTNhLTYwZDE2N2Y3MzkyOT9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1OVGRZRjJjY2FFdVQ1UVh3M1RfYmdkZXo2OGNBWUNzRWtUUDV0WlB0S3c2NU0xbEp6bmRhRWttUEhnZmxrOW1uZHVOUHg0aXR6OUYyV1laRTRvYWNoQSZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl1YjNScFptbGpZWFJwYjI1ekwzQnlaV1psY21WdVkyVnpMM0psWmoxcFpGOXViM1JwWm5CeVpXWmZaRzVoZGw5NGVGOCIgbWV0cmljPSJvcHRvdXQiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjZmZmZmZmOyI-Tm90aWZpY2F0aW9uIFByZWZlcmVuY2VzPC9hPjxicj48YnI-DQoJCQkJCQkJCQkJCQkJCQkJCQlXZSBob3BlIHlvdSBmb3VuZCB0aGlzIG1lc3NhZ2UgdG8gYmUgdXNlZnVsLiBIb3dldmVyLCBpZiB5b3UnZCByYXRoZXIgbm90IHJlY2VpdmUgZnV0dXJlIGUtbWFpbHMgb2YgdGhpcyBzb3J0IGZyb20gQW1hem9uLmNvbSwgcGxlYXNlIG9wdC1vdXQgPGEgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvcmVkaXJlY3QvNjU2MmJjY2QtNzA3YS0zZGI3LTg3NjEtYjA5OWExMDNkOTcxP250PVNPTERfU0hJUF9OT1cmYW1wO3NrPVZBdjJkZUJDR2dFcmJDU05BSmFGeXd1d1BZbHFDZlVFS1RNX2xhemFxZ2RLcG5uLUh0NlpJWVZVLVZTVVA0SVZVTlpJdHZNNkk3VERCeDB3cWhSd2h3JmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJpOXViM1JwWm1sallYUnBiMjV6TDNCeVpXWmxjbVZ1WTJWekwyOXdkRzkxZEQ5dmNIUnZkWFJKWkQxaFltWmtNelJqWWkwek5HTTRMVFJsWXpZdE9UTXhZaTA1WVdOalltVm1aR0ZsT0dJIiBtZXRyaWM9Im9wdG91dCIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgY29sb3I6ICNmZmZmZmY7Ij5oZXJlLjwvYT48YnI-PGJyPg0KCQkJCQkJCQkJCQkJQ29weXJpZ2h0ICAyMDI2IEFtYXpvbiwgSW5jLCBvciBpdHMgYWZmaWxpYXRlcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC48YnI-IA0KCQkJCQkJCQkJCQkJQW1hem9uIFNlbGxlciBTZXJ2aWNlcyBQcml2YXRlIExpbWl0ZWQsIDh0aCBmbG9vciwgQnJpZ2FkZSBHYXRld2F5LCAyNi8xIERyLiBSYWprdW1hciBSb2FkLCBCYW5nYWxvcmUgNTYwMDU1IChLYXJuYXRha2EpPGJyPjwvcD48dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICANCgkJCQkJCQkJCQkJDQogICAgICAgICAgICAgICAgICAgICAgICAJCQkJCTwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGFibGU-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KCQkJCQkJPC90ZD4NCgkJCQkJPC90cj4NCgkJCQkJPC90Ym9keT48L3RhYmxlPg0KCQkJCQk8IS0tIEJMT0NLIEZvb3RlciBBYm91dCBVcyAtLT4NCgkJCQkJPC90ZD4NCgkJCQkJPC90cj4NCgkJCQkJPC90Ym9keT48L3RhYmxlPg0KCQkJCQkNCgkJCQkJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBjbGFzcz0idGVtcGxhdGVDb250YWluZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7Ij4NCgkJCQkJPHRib2R5Pjx0cj4NCgkJCQkJPHRkPg0KCQkJCQ0KCQkJCQk8L3RkPg0KCQkJCQk8L3RyPg0KCQkJCQk8L3Rib2R5PjwvdGFibGU-DQoJCQkJCTwhLS1baWYgKGd0ZSBtc28gOSl8KElFKV0-DQoJCQkJPC90ZD4NCgkJCQk8L3RyPg0KCQkJPC90YWJsZT4NCgkJCTwhW2VuZGlmXS0tPg0KCQkJPCEtLSAvLyBFTkQgVEVNUExBVEUgLS0-DQoJCQk8L3RkPg0KCQk8L3RyPg0KCQk8L3Rib2R5PjwvdGFibGU-ICAgIA0KDQo8L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvZGl2PjwvY2VudGVyPjxpbWcgc3JjPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9pbWcvMzc1MTA3YWMtYmQzYS0zMTQwLTk0ZGEtNDM1ZTJhNTBlZjFlP3NrPUladGZaUnAwamNaeTBnNUlJWG9WMGpiVFF4Q05uVVMzTHRoZkxJcXpUSjRmb1phUXM1MWR5TFVCRGRVb1RKdVlxRWNoN2lTVjhnWTBIVnFaUVFxVEZ3JmFtcDtuPTEiPg0KPGRpdiBpZD0ic3BjLXdhdGVybWFyayI-DQogIDxwIHN0eWxlPSJmb250LXNpemU6IDEwcHggIWltcG9ydGFudDtwYWRkaW5nLWJvdHRvbTogMTBweCAhaW1wb3J0YW50O2Rpc3BsYXk6IHRhYmxlICFpbXBvcnRhbnQ7bWFyZ2luOiA1cHggYXV0byAxMHB4ICFpbXBvcnRhbnQ7dGV4dC1hbGlnbjogY2VudGVyICFpbXBvcnRhbnQ7Y29sb3I6ICNhMmEyYTIgIWltcG9ydGFudDtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcicgIWltcG9ydGFudDtmb250LXdlaWdodDogNDAwICFpbXBvcnRhbnQ7Ij5TUEMtRVVBbWF6b24tMTM4OTc4NDMxMDQyMjM0NjwvcD4NCjwvZGl2PjwvYm9keT48L2h0bWw-"}}]},"sizeEstimate":37323,"historyId":"2854077","internalDate":"1768102158000"}', '2026-01-11T04:56:23.211Z', '19bab19e331b48ed', '19ba74365c56df1b', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('e74441e70fe77c633f4c26a1feca046d', '101f04af63cbefc2bf8f0a98b9ae1205', 'ET AI <newsletter@economictimesnews.com>', 'ET AI: China is closing in on US technology lead despite constraints, AI researchers say', '<html lang="en">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>ET AI: China is closing in on US technology lead despite constraints, AI researchers say</title>
  <meta name="description" content="Stay ahead with the AI Newsletter by The Economic Times. Get the latest updates on artificial intelligence, machine learning, AI startups, and innovations delivered to your inbox.">
  <link rel="canonical" href="https://economictimes.indiatimes.com/ai_newsletter.cms">
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Faustina:ital,wght@0,300..800;1,300..800&amp;family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&amp;family=Montserrat:ital,wght@0,100..900;1,100..900&amp;family=Sofia+Sans+Condensed:ital,wght@0,1..1000;1,1..1000&amp;family=Sofia+Sans:ital,wght@0,1..1000;1,1..1000&amp;display=swap">
  <style>
            @media screen and (max-width: 500px) {
                .mainDiv {
                    width: calc(100% - 20px) !important;
                    padding: 20px 10px !important;
                }
                table {
                    width: 100% !important;
                }
                .ainewsBox {
                    padding: 15px !important;
                }
                .story_title {
                    font-size: 18px !important;
                }
                .card_title {
                    font-size: 20px !important;
                }
                img {
                    max-width: 100% !important;
                    height: auto !important;
                }
                .topSponsoredHeader img{
                        max-width: 125px !important;
                        width: auto !important;
                        max-height: 60px !important;
                }
                .masterClass .headingMclass {
                    font-size: 17px !important;
                }
                .masterClass .Mpragraph{font-size: 12px !important;}
            }
            .news_ltr_list li {
                margin-bottom: 15px;
            }
            .card_title {
                font-family: Montserrat;
                font-weight: 700;
                font-size: 25px;
                line-height: 100%;
                letter-spacing: 0%;
                text-align: center;
                vertical-align: middle;
                text-transform: uppercase;
            }
            .story_title {
                font-family: ''Times New Roman'', Times, serif;
                font-weight: 600;
                font-size: 22px;
                line-height: 121%;
                letter-spacing: 0%;
                vertical-align: middle;
                margin: 0 !important;
            }
            .story_img {
                max-width: 100%;
                height: auto;
            }
            .story_read_more {
                color: #181a93;
                text-decoration: underline;
                cursor: pointer;
                font-family: ''Times New Roman'', Times, serif;
                font-weight: 700;
                font-size: 13px;
                line-height: 145%;
            }
            .title_img {
                width: 25px;
                height: 25px;
            }
            .top_headings {
                font-family: ''Times New Roman'', Times, serif;
                font-weight: 700;
                font-size: 14px;
                line-height: 145%;
                vertical-align: middle;
            }
            .red_text {
                color: #d91f23;
            }
            .pick_of_the_day {
                font-family: ''Times New Roman'', Times, serif;
                font-weight: 500;
                font-size: 13px;
                line-height: 145%;
                vertical-align: middle;
                text-decoration: underline;
                cursor: pointer;
            }
            .around_the_web {
                font-family: ''Times New Roman'', Times, serif;
                font-size: 13px;
                line-height: 121%;
                vertical-align: middle;
            }
            .iitprogatag{
                display: inline-block;
                font-weight: 600;
                font-size: 10px;
                line-height: 100%;
                letter-spacing: 0;
                border: 0.65px solid #e92121 !important;
                padding: 6px 10px;
                color: #e92121 !important;
                border-radius: 5.17px;
                text-decoration: none !important;
            }
            @media only screen and (max-width:500px){
                .aiMaintitle{
                    font-size: 9px !important;
                    padding: 8px 9px 0 !important;
                }
                .aiSubtitle{
                    font-size: 10px !important;
                    padding: 0px 9px !important;
                }
                .iitprogaMain{
                    padding: 10px 9px 12px !important;
                }
                .iitprogatag{
                    font-size: 9px !important;
                    padding: 6px !important;

                }
            }
        </style>
 </head>
 <body style="margin:0; padding:0; font-size:16px; font-family:Inter,Helvetica, Arial, sans-serif; color:#000002; background-color:#ffffff;">
  <!--##isClientEnabled=false##--> <img src="https://nltrack.indiatimes.com/tracking/track/on?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc" height="1" width="1" alt=" " style="height:1px;width:1px"><!--/<img-->
  <div style="max-width: 600px; margin: 0 auto; background: #fff; padding: 20px;" class="mainDiv">
   <table style="width: 100%; max-width:600px; margin: 0 auto; padding: 24px 0; border-radius: 8px; table-layout: fixed;" border="0" cellspacing="0" cellpadding="0">
    <tbody>
     <tr>
      <td>
       <div style="display:none !important;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;">
        China is closing in on US technology lead despite constraints, AI researchers say
       </div></td>
     </tr>
     <tr>
      <td align="center" colspan="2" style="width: 100%; max-width: 600px; min-width: 320px;">
       <table style="width: 100%; border-radius: 10px;">
        <tbody>
         <tr>
          <td>
           <table style="width: 100%;border-collapse: collapse;background-color:#fff;" class="table table">
            <tbody>
             <tr>
              <td><!-- could not get data --> <!--/market_nlsponsored_cont.cms?msid=123164841&utm_campaign=AInewsletter&position=top&tn=et_ai_newsletterpotime:4--></td>
             </tr>
            </tbody>
           </table></td>
         </tr>
         <tr>
          <td align="center" colspan="2" style="text-align: center; border-radius: 10px;"><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed89"><img alt="Et_ai_banner" src="https://economictimes.indiatimes.com/photo/120406011.cms" style="width: 100%; max-width: 600px; height: auto;"></a></td>
         </tr>
         <tr>
          <td align="center" colspan="2" style="text-align: center; border-radius: 10px;padding-top:20px"><!-- could not get data --> <!--/market_nlsponsored_cont.cms?msid=123164841&utm_campaign=AInewsletter&position=banner&tn=et_ai_newsletterpotime:4--></td>
         </tr>
         <tr>
          <td align="center" colspan="2" style="text-align: center; font-weight: 500; color: #282b2e; margin: 0; padding: 0; font-family: ''Times New Roman'', Times, serif; font-weight: 400; font-size: 14px; text-align: left; vertical-align: middle; line-height: 20px; padding: 25px 0;">
           <table style="width: 100%; border: 2px solid #ffe9e2; border-radius: 10px; padding: 25px 30px;">
            <tbody>
             <tr>
              <td>
               <p style="font-size: 17px;"><span style="font-size: 17px; font-weight: 600;">Good morning Reader, </span><!--##AINLSUMMARY##--></p>
               <p style="font-size: 17px;"><strong>In today''s newsletter:</strong></p>
               <ul class="news_ltr_list">
                <li style="font-size: 17px;">China is closing in on US technology lead despite constraints, AI researchers say</li>
                <li style="font-size: 17px;">India AI Mission fuels startup ecosystem, strengthens push to make India ''global AI producer'': Experts</li>
                <li style="font-size: 17px;">In changed stance, Zoho’s Sridhar Vembu says AI won’t replace software engineers</li>
                <li style="font-size: 17px;">PM Modi tells IndiaAI startups to showcase local AI use cases at February summit</li>
               </ul></td>
             </tr>
            </tbody>
           </table></td>
         </tr>
         <tr>
          <td align="center" colspan="2">
           <table style="width: 600px; border-collapse: collapse; font-family: ''Times New Roman'', Times, serif; border-radius: 5px 5px 0 0;">
            <tbody>
             <tr>
              <td align="center" colspan="2" style="text-align: center; padding:0;  border-radius: 10px;">
               <p style="margin:0;padding:0" class="card_title"><img alt="ai_in_news_banner" src="https://economictimes.indiatimes.com/photo/120405981.cms" style="max-width: 600px;height:auto;"></p></td>
             </tr>
             <tr xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:java="java">
              <td style="margin-bottom:0;">
               <table width="100%" cellpadding="0" class="ainewsBox" cellspacing="0">
                <tbody>
                 <tr>
                  <td align="center" colspan="2" style="text-align:center;border-radius:10px;"><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed8b"><img alt="Ad_img" style="width:100%;max-width:600px;height:auto;border-radius:10px;margin-bottom:20px;" src="https://economictimes.indiatimes.com/photo/124090770.cms?imgsize=438218"></a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr><!--/ai_banner.cms?utm_campaign=AInewsletter&tname=et_ai_newsletterpotime:13--><!-- could not get data --> <!--/market_nlsponsored_cont.cms?msid=123164841&utm_campaign=AInewsletter&position=bottom&tn=et_ai_newsletterpotime:3--><!--##aigenarticle##-->
             <tr>
              <td align="center" colspan="2" style="                                                                             color: #282b2e;                                                                             padding: 0;                                                                             font-family: ''Times New Roman'', Times, serif;                                                                             font-weight: 400;                                                                             font-size: 14px;                                                                             text-align: left;                                                                             vertical-align: middle;                                                                             line-height: 20px;                                                                             padding: 5px 0 20px;                                                                         ">
               <table class="ainewsBox" style="width: 600px; border: 2px solid #ffe9e2; border-radius: 10px; padding: 25px 55px;">
                <tbody>
                 <tr>
                  <td>
                   <p style="font-family: ''Times New Roman'', Times, serif; font-weight: 600; font-size: 22px; line-height: 121%; vertical-align: middle;margin: 0 !important;" class="story_title">PM Modi tells IndiaAI startups to showcase local AI use cases at February summit</p>
                   <p style="text-align: center;margin-bottom: 20px;"><img style="max-width: 100%;height: auto;" alt="article_img" class="story_img" src="http://economictimes.indiatimes.com/thumb/126452298.cms?width=525&amp;height=393&amp;resizemode=4"></p>
                   <p style="font-size: 17px;">The PM held a closed-door meeting at his residence on January 8 with about a dozen founders from the IndiaAI Mission cohort. Union IT minister Ashwini Vaishnaw and senior officials of MeitY also attended the meeting. Modi told the founders to develop safe and authenticated AI, prioritising trust, transparency, and watermarking in their models to build user confidence and comply with evolving regulations.</p><a target="_blank" class="story_read_more" href="https://nltrack.indiatimes.com/tracking/track/cl/native?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c533b" title="PM Modi tells IndiaAI startups to showcase local AI use cases at February summit"> Read full article here </a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
             <tr>
              <td><!-- could not get data --> <!--/masterclass_mailer_widget.cms?utm_source=ai_newsletterpotime:1--></td>
             </tr>
             <tr>
              <td align="center" colspan="2" style="                                                                             color: #282b2e;                                                                             padding: 0;                                                                             font-family: ''Times New Roman'', Times, serif;                                                                             font-weight: 400;                                                                             font-size: 14px;                                                                             text-align: left;                                                                             vertical-align: middle;                                                                             line-height: 20px;                                                                             padding: 5px 0 20px;                                                                         ">
               <table class="ainewsBox" style="width: 600px; border: 2px solid #ffe9e2; border-radius: 10px; padding: 25px 55px;">
                <tbody>
                 <tr>
                  <td>
                   <p style="font-family: ''Times New Roman'', Times, serif; font-weight: 600; font-size: 22px; line-height: 121%; vertical-align: middle;margin: 0 !important;" class="story_title">Nine ITIs in Odisha to get AI labs: CM Mohan Charan Majhi</p>
                   <p style="text-align: center;margin-bottom: 20px;"><img style="max-width: 100%;height: auto;" alt="article_img" class="story_img" src="http://economictimes.indiatimes.com/thumb/126451261.cms?width=525&amp;height=393&amp;resizemode=4"></p>
                   <p style="font-size: 17px;">Odisha chief minister Mohan Charan Majhi on Friday said artificial intelligence (AI) laboratories are being set up in nine Industrial Training Institutes (ITIs) of the state.</p><a target="_blank" class="story_read_more" href="https://nltrack.indiatimes.com/tracking/track/cl/native?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c533c" title="Nine ITIs in Odisha to get AI labs: CM Mohan Charan Majhi"> Read full article here </a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
             <tr>
              <td>
               <table style="padding-bottom:16px;" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tbody>
                 <tr>
                  <td style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 16px; line-height: 1.2; padding-bottom:8px;padding-left: 7px;" align="left" colspan="5"><a target="_blank" style="display:block; color:#000;text-decoration: none;" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed8c"><span style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 16px; line-height: 1.2; letter-spacing: 0; vertical-align: middle;">Explore Courses</span><img alt="arrowIcon" src="https://economictimes.indiatimes.com/photo/125914896.cms" style="vertical-align: middle;margin-left: 6px;margin-top: 2px; max-width:6px !important;"></a></td>
                  <td style="padding-bottom:8px;padding-right: 7px;" align="right" colspan="4"><a target="_blank" style="display:block; max-width: 170px;height:auto;" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed8c"><img alt="ai_in_news_banner" style="max-width: 100%;height:auto;" src="https://economictimes.indiatimes.com/photo/125863466.cms"></a></td>
                 </tr>
                 <tr>
                  <td style="width:7px;line-height:0">&nbsp;</td>
                  <td valign="top" style="border: 0.65px solid #dddddd; border-radius: 10.34px; overflow: hidden; width:33%; min-width: 98px;">
                   <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                     <tr>
                      <td valign="top" style="padding:0;line-height:0"><img alt="ai_in_news_banner" style="max-width: 100%;height:auto;" src="https://economictimes.indiatimes.com/photo/125932375.cms"></td>
                     </tr>
                     <tr>
                      <td valign="top" style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; vertical-align: top; color:#e92121;padding:8px 13px 0; height:30px;" class="aiMaintitle">For Leaders</td>
                     </tr>
                     <tr>
                      <td valign="top" style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 12px; line-height: 1.2; letter-spacing: 0; color:#1e1e1e;padding:0px 13px; height:70px;" class="aiSubtitle">AI-Powere​d Decision Making</td>
                     </tr>
                     <tr>
                      <td style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; color:#e92121;padding:10px 13px 12px;" class="iitprogaMain"><a target="_blank" style="display: inline-block; font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; border:0.65px solid #e92121; padding:6px 10px; color: #e92121; border-radius: 5.17px; text-decoration: none;" class="iitprogatag" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=69630444b4004908c95316cd"><span style="vertical-align: middle;">Know more</span><img alt="KnowMoreIcon" src="https://economictimes.indiatimes.com/photo/125914894.cms" style="vertical-align: middle;margin-left: 3px;    margin-top: 2px; max-width:10px !important;"></a></td>
                     </tr>
                    </tbody>
                   </table></td>
                  <td style="width:7px;line-height:0">&nbsp;</td>
                  <td style="width:7px;line-height:0">&nbsp;</td>
                  <td valign="top" style="border: 0.65px solid #dddddd; border-radius: 10.34px; overflow: hidden; width:33%; min-width: 98px;">
                   <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                     <tr>
                      <td valign="top" style="padding:0;line-height:0"><img alt="ai_in_news_banner" style="max-width: 100%;height:auto;" src="https://economictimes.indiatimes.com/photo/125932308.cms"></td>
                     </tr>
                     <tr>
                      <td valign="top" style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; vertical-align: top; color:#e92121;padding:8px 13px 0; height:30px;" class="aiMaintitle">For Leaders</td>
                     </tr>
                     <tr>
                      <td valign="top" style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 12px; line-height: 1.2; letter-spacing: 0; color:#1e1e1e;padding:0px 13px; height:70px;" class="aiSubtitle">Generative AI Application for Leaders</td>
                     </tr>
                     <tr>
                      <td style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; color:#e92121;padding:10px 13px 12px;" class="iitprogaMain"><a target="_blank" style="display: inline-block; font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; border:0.65px solid #e92121; padding:6px 10px; color: #e92121; border-radius: 5.17px; text-decoration: none;" class="iitprogatag" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=69630444b4004908c95316cd"><span style="vertical-align: middle;">Know more</span><img alt="KnowMoreIcon" src="https://economictimes.indiatimes.com/photo/125914894.cms" style="vertical-align: middle;margin-left: 3px;    margin-top: 2px; max-width:10px !important;"></a></td>
                     </tr>
                    </tbody>
                   </table></td>
                  <td style="width:7px;line-height:0">&nbsp;</td>
                  <td style="width:7px;line-height:0">&nbsp;</td>
                  <td valign="top" style="border: 0.65px solid #dddddd; border-radius: 10.34px; overflow: hidden; width:33%; min-width: 98px;">
                   <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                     <tr>
                      <td valign="top" style="padding:0;line-height:0"><img alt="ai_in_news_banner" style="max-width: 100%;height:auto;" src="https://economictimes.indiatimes.com/photo/125932309.cms"></td>
                     </tr>
                     <tr>
                      <td valign="top" style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; vertical-align: top; color:#e92121;padding:8px 13px 0; height:30px;" class="aiMaintitle">For Product and Business Managers</td>
                     </tr>
                     <tr>
                      <td valign="top" style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 12px; line-height: 1.2; letter-spacing: 0; color:#1e1e1e;padding:0px 13px; height:70px;" class="aiSubtitle">AI-Powered Professional Certification in Product Management</td>
                     </tr>
                     <tr>
                      <td style="font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; color:#e92121;padding:10px 13px 12px;" class="iitprogaMain"><a target="_blank" style="display: inline-block; font-family: ''Montserrat'', sans-serif; font-weight: 600; font-size: 10px; line-height: 1.2; letter-spacing: 0; border:0.65px solid #e92121; padding:6px 10px; color: #e92121; border-radius: 5.17px; text-decoration: none;" class="iitprogatag" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=69630444b4004908c95316cf"><span style="vertical-align: middle;">Know more</span><img alt="KnowMoreIcon" src="https://economictimes.indiatimes.com/photo/125914894.cms" style="vertical-align: middle;margin-left: 3px;    margin-top: 2px; max-width:10px !important;"></a></td>
                     </tr>
                    </tbody>
                   </table></td>
                  <td style="width:7px;line-height:0">&nbsp;</td>
                 </tr>
                </tbody>
               </table><!--/et_ai_explore_courses.cms?utm_source=ai_newsletterpotime:15--></td>
             </tr>
             <tr>
              <td align="center" colspan="2" style="color: #282b2e; margin: 0; font-family: ''Times New Roman'', Times, serif; font-weight: 400; font-size: 14px; text-align: left; vertical-align: middle; line-height: 20px; padding: 5px 0 20px;">
               <table class="ainewsBox" style="width: 100%; border: 2px solid #ffe9e2; border-radius: 10px; padding: 25px 55px;">
                <tbody>
                 <tr>
                  <td>
                   <p style="font-family: ''Times New Roman'', Times, serif; font-weight: 600; font-size: 22px; line-height: 121%; vertical-align: middle; margin: 0 0 20px !important;" class="story_title"><span style="vertical-align: middle; margin-right: 8px;"><img style="width: 25px; height: 25px; max-width: 25px; height: auto;" alt="" src="https://economictimes.indiatimes.com/photo/120343652.cms" class="title_img"></span> Popular AI tools for you</p><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c533d" title="Synthesia"><span class="red_text">Synthesia</span> - Create AI videos with digital avatars.</a><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c533e" title="Teal"><span class="red_text">Teal</span> - Job search copilot powered by AI.</a><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c533f" title="Textio"><span class="red_text">Textio</span> - Augmented writing platform to create inclusive content.</a><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5340" title="Tidio AI"><span class="red_text">Tidio AI</span> - AI-powered customer service chatbots.</a><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5341" title="v0"><span class="red_text">v0</span> - Generate web UIs with AI from Vercel.</a><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5342" title="Vista Social"><span class="red_text">Vista Social</span> - AI-powered social media management platform.</a><a target="_blank" style="display:block; color:#000;margin-bottom:16px" class="top_headings" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5343" title="Wordtune"><span class="red_text">Wordtune</span> - Rephrase and enhance writing with AI.</a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
             <tr>
              <td align="center" colspan="2" style="                                                                         color: #282b2e;                                                                         margin: 0;                                                                         font-family: ''Times New Roman'', Times, serif;                                                                         font-weight: 400;                                                                         font-size: 14px;                                                                         text-align: left;                                                                         vertical-align: middle;                                                                         line-height: 20px;                                                                         padding: 5px 0 20px;                                                                     ">
               <table class="ainewsBox" style="width: 600px; border: 2px solid #ffe9e2; border-radius: 10px; padding: 25px 55px;">
                <tbody>
                 <tr>
                  <td>
                   <p style="font-family: ''Times New Roman'', Times, serif; font-weight: 600; font-size: 22px; line-height: 121%; vertical-align: middle; margin: 0 0 20px !important;" class="story_title"><span style="vertical-align: middle; margin-right: 8px;"><img style="width: 25px;height: 25px;max-width:25px; height:auto;" alt="" src="https://economictimes.indiatimes.com/photo/120343649.cms" class="title_img"></span> Special picks of the day</p><a style="display:block;font-size: 14px;font-weight: 500;text-decoration: underline;color:#000000;margin-bottom:17px" target="_blank" class="pick_of_the_day" href="https://nltrack.indiatimes.com/tracking/track/cl/native?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c533c" title="Nine ITIs in Odisha to get AI labs: CM Mohan Charan Majhi">Nine ITIs in Odisha to get AI labs: CM Mohan Charan Majhi</a><a style="display:block;font-size: 14px;font-weight: 500;text-decoration: underline;color:#000000;margin-bottom:17px" target="_blank" class="pick_of_the_day" href="https://nltrack.indiatimes.com/tracking/track/cl/native?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5344" title="Brew, smell, and serve: AI steals the show at CES 2026">Brew, smell, and serve: AI steals the show at CES 2026</a><a style="display:block;font-size: 14px;font-weight: 500;text-decoration: underline;color:#000000;margin-bottom:17px" target="_blank" class="pick_of_the_day" href="https://nltrack.indiatimes.com/tracking/track/cl/native?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5345" title="AI gobbling up memory chips essential to gadget makers">AI gobbling up memory chips essential to gadget makers</a><a style="display:block;font-size: 14px;font-weight: 500;text-decoration: underline;color:#000000;margin-bottom:17px" target="_blank" class="pick_of_the_day" href="https://nltrack.indiatimes.com/tracking/track/cl/native?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6962f614ef202620ae2c5346" title="Indonesia temporarily blocks access to Grok over sexualised images">Indonesia temporarily blocks access to Grok over sexualised images</a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
             <tr>
              <td align="center" colspan="2" style="                                                                         color: #282b2e;                                                                         margin: 0;                                                                         font-family: ''Times New Roman'', Times, serif;                                                                         font-weight: 400;                                                                         font-size: 14px;                                                                         text-align: left;                                                                         vertical-align: middle;                                                                         line-height: 20px;                                                                         padding: 5px 0 20px;                                                                     ">
               <table class="ainewsBox" style="width: 600px; border: 2px solid #ffe9e2; border-radius: 10px; padding: 25px 55px;">
                <tbody>
                 <tr>
                  <td>
                   <p style="font-family: ''Times New Roman'', Times, serif; font-weight: 600; font-size: 22px; line-height: 121%; vertical-align: middle; margin: 0 0 20px !important;" class="story_title"><span style="vertical-align: middle; margin-right: 8px;"><img style="width: 25px;height: 25px;max-width:25px; height:auto;" alt="" src="https://economictimes.indiatimes.com/photo/120343644.cms" class="title_img"></span> Around the web</p>
                   <ul style=" margin: 0; padding: 0; padding-left: 20px;">
                    <li style="font-size: 14px; margin-bottom: 10px;" class="around_the_web">OpenAI is reportedly asking contractors to upload real work from past jobs</li>
                    <li style="font-size: 14px; margin-bottom: 10px;" class="around_the_web">Indonesia blocks Grok over non-consensual, sexualized deepfakes</li>
                    <li style="font-size: 14px; margin-bottom: 10px;" class="around_the_web">CES 2026: Everything revealed, from Nvidia’s debuts to AMD’s new chips to Razer’s AI oddities&nbsp;</li>
                    <li style="font-size: 14px; margin-bottom: 10px;" class="around_the_web">‘Physical AI’ Is Coming for Your Car</li>
                    <li style="font-size: 14px; margin-bottom: 10px;" class="around_the_web">AI Devices Are Coming. Will Your Favorite Apps Be Along for the Ride?</li>
                    <li style="font-size: 14px; margin-bottom: 10px;" class="around_the_web">People Are Using AI to Falsely Identify the Federal Agent Who Shot Renee Good</li>
                   </ul></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
            </tbody>
           </table></td>
         </tr>
         <tr>
          <td align="center" colspan="2">
           <table style="width: 600px; border: 2px solid #ffe9e2; border-radius: 10px;">
            <tbody>
             <tr>
              <td style="text-align: center; padding: 27px 0 13px 0;">
               <h4 style="font-family: ''Times New Roman'', Times, serif; font-weight: 500; font-size: 20px; line-height: 30px; margin: 0; padding: 0;">How would you rate today''s Newsletter?</h4></td>
             </tr>
             <tr>
              <td>
               <table style="margin: auto; padding-bottom: 18px;">
                <tbody>
                 <tr>
                  <td style="text-align: center; padding-top: 10px; padding-right: 15px;"><a title="Love it!!" target="_blank" style="text-decoration: none; font-size: 14px; color: #000; font-weight: bold;" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed90"><img src="https://economictimes.indiatimes.com/photo/120343632.cms" style="width: 70px; display: block; margin: auto; padding-bottom: 5px;" alt="love it"><span style="font-family: ''Times New Roman'', Times, serif; font-weight: 500; font-size: 15px; line-height: 121%; letter-spacing: 0%; vertical-align: middle;">Love it!!</span></a></td>
                  <td style="text-align: center; padding-top: 10px; padding-right: 15px;"><a title="Mehh" target="_blank" style="text-decoration: none; font-size: 14px; color: #000; font-weight: bold;" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed91"><img src="https://economictimes.indiatimes.com/photo/120343637.cms" style="width: 70px; display: block; margin: auto; padding-bottom: 5px;" alt="love it"><span style="font-family: ''Times New Roman'', Times, serif; font-weight: 500; font-size: 15px; line-height: 121%; letter-spacing: 0%; vertical-align: middle;">Mehh</span></a></td>
                  <td style="text-align: center; padding-top: 10px; padding-right: 15px;"><a title="Hate it" target="_blank" style="text-decoration: none; font-size: 14px; color: #000; font-weight: bold;" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed93"><img src="https://economictimes.indiatimes.com/photo/120343641.cms" style="width: 70px; display: block; margin: auto; padding-bottom: 5px;" alt="love it"><span style="font-family: ''Times New Roman'', Times, serif; font-weight: 500; font-size: 15px; line-height: 121%; letter-spacing: 0%; vertical-align: middle;">Hate it</span></a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
            </tbody>
           </table></td>
         </tr>
         <tr>
          <td align="center" style="padding-top: 0px;">
           <table role="presentation" width="600" cellspacing="0" cellpadding="0" border="0" style="border-collapse: collapse; background: #000; color: #fff; border-radius: 0px 0px 5px 5px; font-family: ''Times New Roman'', Times, serif;width: 600px;">
            <tbody>
             <tr>
              <td align="center" style="padding: 20px;">
               <p style="margin: 10px; font-size: 18px; font-weight: bold;">Read your daily news from anywhere.</p>
               <table role="presentation" cellspacing="0" cellpadding="0" border="0" style="border-collapse: collapse;">
                <tbody>
                 <tr>
                  <td align="center" style="padding-right: 10px;"><a style="text-decoration:none;" target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed95"><img src="https://img.etimg.com/photo/119459295.cms" alt="App Store" style="border: 0; max-width: 120px; width: 100%; height: auto;"></a></td>
                  <td align="center"><a style="text-decoration:none;" target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed97"><img src="https://img.etimg.com/photo/119459294.cms" alt="Google Play" style="border: 0; max-width: 120px; width: 100%; height: auto;"></a></td>
                 </tr>
                </tbody>
               </table></td>
             </tr>
             <tr>
              <td align="center" style="font-size: 14px; line-height: 1.5;">
               <p style="margin: 0;"><strong>Thanks for reading.</strong> We''ll be back tomorrow with more interesting stories and updates.<br>
                 Follow us on <a style="color:#1155CC; text-decoration:underline;" target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed98">Twitter</a>, <a style="color:#1155CC; text-decoration:underline;" target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed99">Facebook</a>, <a style="color:#1155CC; text-decoration:underline;" target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed9a">YouTube</a>, and <a style="color:#1155CC; text-decoration:underline;" target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed9c">LinkedIn</a>.</p></td>
             </tr>
             <tr>
              <td align="center" style="padding: 15px;">
               <p style="margin: 0; font-size: 14px; line-height: 1.4;">Brought to you by</p></td>
             </tr>
             <tr>
              <td align="center" style="padding-bottom: 20px;"><img width="220" height="25" src="https://img.etimg.com/photo/119459288.cms" style="margin: 0; padding: 0; border: 0;" alt="ET Logo"></td>
             </tr>
             <tr>
              <td align="center" style="padding: 20px 0 5px 0; font-size: 12px; line-height: 1.5; background: #fff; color: #000;">To ensure delivery directly to your inbox, please add <a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125ed9f" style="color: #024e97; text-decoration: none;"> newsletter@economictimesnews.com </a> to your address book today. If you are having trouble viewing this newsletter, please <a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125eda0" style="color: #024e97; text-decoration: none;"> click here </a></td>
             </tr>
             <tr>
              <td align="center" style="padding: 5px; font-size: 12px; line-height: 1.5; background: #fff; color: #000;">To unsubscribe or edit your subscriptions please <a target="_blank" style="color: #024e97; text-decoration: none;" href="https://economictimes.indiatimes.com/subscription.cms?process=1?utm_source=newsletter&amp;utm_medium=email&amp;utm_campaign=ai_newsletter&amp;utm_content=unsubscribe&amp;key=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;nauth=27a4740edfde2c39c072d85be6ff45af41018a525786c74ea9981e2f26b6ac0be213139401d23ba0f7eba7aad0cf79236f90dc7c97b4e9de58fd5335e47ed29c59b96844f7883209da5a874efce7fc69ea1f9d89f9a2ec16&amp;sid=67dd9502f3c5e3a852fb8da2"> click here </a></td>
             </tr>
             <tr>
              <td align="center" style="padding: 20px; font-size: 12px; line-height: 1.5; background: #fff;">
               <p style="margin: 0; color: #000;">© 2025 <span class="il">Times</span> Internet Limited</p>
               <p style="margin: 5px 0 0 0; color: #fff;"><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125eda1" style="font-size: 12px; color: #024e97; text-decoration: none; display: inline-block;"> About us </a><span style="font-size: 11px; margin: 0 2px; padding: 0 3px;">|</span><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125eda1" style="font-size: 12px; color: #024e97; text-decoration: none; display: inline-block;"> Advertise with us </a><span style="font-size: 11px; margin: 0 2px; padding: 0 3px;">|</span><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125eda1" style="font-size: 12px; color: #024e97; text-decoration: none; display: inline-block;"> Feedback </a><span style="font-size: 11px; margin: 0 2px; padding: 0 3px;">|</span><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125eda1" style="font-size: 12px; color: #024e97; text-decoration: none; display: inline-block;"> Sitemap </a><span style="font-size: 11px; margin: 0 2px; padding: 0 3px;">|</span><a target="_blank" href="https://nltrack.indiatimes.com/tracking/track/cl?param=d39df860a5370e09dcb9269f48f985624a5410ac346fea1509282584bf4c937244e10681a41aa1d20d565825381fd23df394629a3846e776c5f75cc469c3908dd01776cba7ab6e95d8a1f65db4b783ec1be77c55bc10facc&amp;o=6961b2c3877dfe493125eda1" style="font-size: 12px; color: #024e97; text-decoration: none; display: inline-block;"> Code of Ethics </a></p></td>
             </tr>
            </tbody>
           </table></td>
         </tr>
        </tbody>
       </table></td>
     </tr>
    </tbody>
   </table>
  </div>
 </body>
</html>', '2026-01-11T02:20:15.000Z', '{"id":"19baae07831c9861","threadId":"19baae07831c9861","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"China is closing in on US technology lead despite constraints, AI researchers say Et_ai_banner Good morning Reader, In today&#39;s newsletter: China is closing in on US technology lead despite","payload":{"partId":"","mimeType":"multipart/mixed","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2534613pxc;        Sat, 10 Jan 2026 18:26:36 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IFGtFR334owI2o84NjPDj10DPDkViozWryDsj71p0L0MokOoLeM1uvp1BfXN+Ml+UbUElUg"},{"name":"X-Received","value":"by 2002:a17:903:1a6b:b0:295:8da5:c634 with SMTP id d9443c01a7336-2a3ee41354amr123840345ad.9.1768098396653;        Sat, 10 Jan 2026 18:26:36 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768098396; cv=none;        d=google.com; s=arc-20240605;        b=jlZsgs0z6hNfhwRTrcAwt6803aFWB30mP4wClaBUeEpap/Sllu7mhfHhpxsYiAMzE3         aUwLhZyjQXBewnnNfKX/NeLIR1pmjGue42UCp9Y1YqV/ij+wtVJd6IUUvN8jWW8YOvka         AmxPcStaTYfXhSIYAAnVxTytaDVQZXM4iPkeSMADjEk0tL48P0nBYoIMd6+huF2F7iAd         T/bgb4E/Gd4NtSSU9nApXSDFuEW0z4IeUv5chJGXTFrAJ6Dtp/rE+1YjoNhyH8scxV21         2JD2eIUGlA5dzLAEtdYScG03v3IRPw6SPt1PcNpjGfRqnMM310tK/SpGTh7QqNpzqaqf         x4dA=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=etonline-id:feedback-id:precedence:list-unsubscribe-post         :list-unsubscribe:mime-version:subject:message-id:to:reply-to:from         :date:recieved:dkim-signature:dkim-filter;        bh=pRNBF/thoSTpbomz6CUOp2XUlLOyD2Qk+9jRAh829Hc=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=R2JLNBfayG5L/XLsLkYXhFBzEgJhZkp/vPo3cjhQETwobvDvlDzv+pjj8O1tARvKui         pKIzR4Rqy3Btjky3uilKb8/DMjqWmXXhDWbtr3YBO4mWYlidBbma7hJzTlhQY+TnxYht         od6vmZfgsvoqPNNUxdbwCOFOtqQZ6EMdeBuvg0i4c75WuBCTWWA+4Sdg10s0qHCVQHsj         Me9bNTkCoOvbGsdtIKzdUvCsJECGIplO51+wGm+ns2uIOX3PQS/SycVL2VlzzlHs+b9m         MhMITIaST/80PEQADHrD8cBOQly1wcOz/WVfrD4Jh9mkpdkiRxXBAIfQ3J3MnsLQfaIW         Yg7A==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@economictimesnews.com header.s=default header.b=YEh3YWbb;       spf=pass (google.com: domain of newsletter+67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029-kothariqutub=gmail.com@economictimesnews.com designates 219.65.85.55 as permitted sender) smtp.mailfrom=\"newsletter+67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029-kothariqutub=gmail.com@economictimesnews.com\";       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=economictimesnews.com"},{"name":"Return-Path","value":"<newsletter+67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029-kothariqutub=gmail.com@economictimesnews.com>"},{"name":"Received","value":"from smtp179.economictimesonline.com (smtp179.economictimesonline.com. [219.65.85.55])        by mx.google.com with ESMTPS id d9443c01a7336-2a3e3cb5e35si261355525ad.113.2026.01.10.18.26.36        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Sat, 10 Jan 2026 18:26:36 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of newsletter+67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029-kothariqutub=gmail.com@economictimesnews.com designates 219.65.85.55 as permitted sender) client-ip=219.65.85.55;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@economictimesnews.com header.s=default header.b=YEh3YWbb;       spf=pass (google.com: domain of newsletter+67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029-kothariqutub=gmail.com@economictimesnews.com designates 219.65.85.55 as permitted sender) smtp.mailfrom=\"newsletter+67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029-kothariqutub=gmail.com@economictimesnews.com\";       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=economictimesnews.com"},{"name":"DKIM-Filter","value":"OpenDKIM Filter v2.11.0 smtp179.economictimesonline.com 7607342B6EBA"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; c=relaxed/relaxed; d=economictimesnews.com; s=default; t=1768098015; bh=pRNBF/thoSTpbomz6CUOp2XUlLOyD2Qk+9jRAh829Hc=; h=Date:From:Reply-To:To:Subject:List-Unsubscribe:From; b=YEh3YWbbHXvkZ/UTgCWfUVg5oucbXdPCRJYdku26aujw+izRAHDHPLHlqciZW1DiR\t K3VbfJni+Hs+eWax2dGh7cauhrc27rl1ECjcrHhj3CpQW9dZdli7ms09VFEtecK9MW\t nuL4zMFhjVfO+pWT65OiHZ0QozPgR/bahkIjL7dk="},{"name":"Received","value":"from internal-mta (unknown [10.66.1.39]) by smtp179.economictimesonline.com (Postfix) with ESMTP id 7607342B6EBA for <kothariqutub@gmail.com>; Sun, 11 Jan 2026 07:50:15 +0530 (IST)"},{"name":"Recieved","value":"from internal"},{"name":"Date","value":"Sun, 11 Jan 2026 07:50:15 +0530 (IST)"},{"name":"From","value":"ET AI <newsletter@economictimesnews.com>"},{"name":"Reply-To","value":"newsletter@economictimesnews.com"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Message-ID","value":"<67dd9502f3c5e3a852fb8da2.6962f614ef202620ae2c5338.6671a48961d3321884d2a029@economictimesonline.com>"},{"name":"Subject","value":"ET AI: China is closing in on US technology lead despite constraints, AI researchers say"},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/mixed; boundary=\"----=_Part_30755289_1952701100.1768098015448\""},{"name":"List-Unsubscribe","value":"<https://etsub3.indiatimes.com/et-mailing-subscription/ok/unsubscribe/oneclick?umid=6671a48961d3321884d2a029&sid=67dd9502f3c5e3a852fb8da2>"},{"name":"List-Unsubscribe-Post","value":"List-Unsubscribe=One-Click"},{"name":"Precedence","value":"bulk"},{"name":"Feedback-ID","value":"6962f614ef202620ae2c5338:6671a48961d3321884d2a029:NEWSLETTER:etonline"},{"name":"ETOnline-ID","value":"Ckh4Yt5gEJUWeEwBsuOwF3j5CHU"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"multipart/related","filename":"","headers":[{"name":"Content-Type","value":"multipart/related; boundary=\"----=_Part_30755290_1972704828.1768098015448\""}],"body":{"size":0},"parts":[{"partId":"0.0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html;charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"quoted-printable"}],"body":{"size":48979,"data":"PGh0bWwgbGFuZz0iZW4iPg0KIDxoZWFkPg0KICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD1VVEYtOCI-DQogIDxtZXRhIGNoYXJzZXQ9IlVURi04Ij4NCiAgPG1ldGEgY29udGVudD0id2lkdGg9ZGV2aWNlLXdpZHRoLCBpbml0aWFsLXNjYWxlPTEuMCIgbmFtZT0idmlld3BvcnQiPg0KICA8dGl0bGU-RVQgQUk6IENoaW5hIGlzIGNsb3NpbmcgaW4gb24gVVMgdGVjaG5vbG9neSBsZWFkIGRlc3BpdGUgY29uc3RyYWludHMsIEFJIHJlc2VhcmNoZXJzIHNheTwvdGl0bGU-DQogIDxtZXRhIG5hbWU9ImRlc2NyaXB0aW9uIiBjb250ZW50PSJTdGF5IGFoZWFkIHdpdGggdGhlIEFJIE5ld3NsZXR0ZXIgYnkgVGhlIEVjb25vbWljIFRpbWVzLiBHZXQgdGhlIGxhdGVzdCB1cGRhdGVzIG9uIGFydGlmaWNpYWwgaW50ZWxsaWdlbmNlLCBtYWNoaW5lIGxlYXJuaW5nLCBBSSBzdGFydHVwcywgYW5kIGlubm92YXRpb25zIGRlbGl2ZXJlZCB0byB5b3VyIGluYm94LiI-DQogIDxsaW5rIHJlbD0iY2Fub25pY2FsIiBocmVmPSJodHRwczovL2Vjb25vbWljdGltZXMuaW5kaWF0aW1lcy5jb20vYWlfbmV3c2xldHRlci5jbXMiPg0KICA8bGluayBocmVmPSJodHRwczovL2ZvbnRzLmdvb2dsZWFwaXMuY29tIiByZWw9InByZWNvbm5lY3QiPg0KICA8bGluayBocmVmPSJodHRwczovL2ZvbnRzLmdzdGF0aWMuY29tIiByZWw9InByZWNvbm5lY3QiPg0KICA8bGluayByZWw9InN0eWxlc2hlZXQiIGhyZWY9Imh0dHBzOi8vZm9udHMuZ29vZ2xlYXBpcy5jb20vY3NzMj9mYW1pbHk9RmF1c3RpbmE6aXRhbCx3Z2h0QDAsMzAwLi44MDA7MSwzMDAuLjgwMCZhbXA7ZmFtaWx5PUludGVyOml0YWwsb3Bzeix3Z2h0QDAsMTQuLjMyLDEwMC4uOTAwOzEsMTQuLjMyLDEwMC4uOTAwJmFtcDtmYW1pbHk9TW9udHNlcnJhdDppdGFsLHdnaHRAMCwxMDAuLjkwMDsxLDEwMC4uOTAwJmFtcDtmYW1pbHk9U29maWErU2FucytDb25kZW5zZWQ6aXRhbCx3Z2h0QDAsMS4uMTAwMDsxLDEuLjEwMDAmYW1wO2ZhbWlseT1Tb2ZpYStTYW5zOml0YWwsd2dodEAwLDEuLjEwMDA7MSwxLi4xMDAwJmFtcDtkaXNwbGF5PXN3YXAiPg0KICA8c3R5bGU-DQogICAgICAgICAgICBAbWVkaWEgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA1MDBweCkgew0KICAgICAgICAgICAgICAgIC5tYWluRGl2IHsNCiAgICAgICAgICAgICAgICAgICAgd2lkdGg6IGNhbGMoMTAwJSAtIDIwcHgpICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDIwcHggMTBweCAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICB0YWJsZSB7DQogICAgICAgICAgICAgICAgICAgIHdpZHRoOiAxMDAlICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIC5haW5ld3NCb3ggew0KICAgICAgICAgICAgICAgICAgICBwYWRkaW5nOiAxNXB4ICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIC5zdG9yeV90aXRsZSB7DQogICAgICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogMThweCAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAuY2FyZF90aXRsZSB7DQogICAgICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogMjBweCAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBpbWcgew0KICAgICAgICAgICAgICAgICAgICBtYXgtd2lkdGg6IDEwMCUgIWltcG9ydGFudDsNCiAgICAgICAgICAgICAgICAgICAgaGVpZ2h0OiBhdXRvICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIC50b3BTcG9uc29yZWRIZWFkZXIgaW1new0KICAgICAgICAgICAgICAgICAgICAgICAgbWF4LXdpZHRoOiAxMjVweCAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgICAgICAgICAgd2lkdGg6IGF1dG8gIWltcG9ydGFudDsNCiAgICAgICAgICAgICAgICAgICAgICAgIG1heC1oZWlnaHQ6IDYwcHggIWltcG9ydGFudDsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgLm1hc3RlckNsYXNzIC5oZWFkaW5nTWNsYXNzIHsNCiAgICAgICAgICAgICAgICAgICAgZm9udC1zaXplOiAxN3B4ICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIC5tYXN0ZXJDbGFzcyAuTXByYWdyYXBoe2ZvbnQtc2l6ZTogMTJweCAhaW1wb3J0YW50O30NCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIC5uZXdzX2x0cl9saXN0IGxpIHsNCiAgICAgICAgICAgICAgICBtYXJnaW4tYm90dG9tOiAxNXB4Ow0KICAgICAgICAgICAgfQ0KICAgICAgICAgICAgLmNhcmRfdGl0bGUgew0KICAgICAgICAgICAgICAgIGZvbnQtZmFtaWx5OiBNb250c2VycmF0Ow0KICAgICAgICAgICAgICAgIGZvbnQtd2VpZ2h0OiA3MDA7DQogICAgICAgICAgICAgICAgZm9udC1zaXplOiAyNXB4Ow0KICAgICAgICAgICAgICAgIGxpbmUtaGVpZ2h0OiAxMDAlOw0KICAgICAgICAgICAgICAgIGxldHRlci1zcGFjaW5nOiAwJTsNCiAgICAgICAgICAgICAgICB0ZXh0LWFsaWduOiBjZW50ZXI7DQogICAgICAgICAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTsNCiAgICAgICAgICAgICAgICB0ZXh0LXRyYW5zZm9ybTogdXBwZXJjYXNlOw0KICAgICAgICAgICAgfQ0KICAgICAgICAgICAgLnN0b3J5X3RpdGxlIHsNCiAgICAgICAgICAgICAgICBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsNCiAgICAgICAgICAgICAgICBmb250LXdlaWdodDogNjAwOw0KICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogMjJweDsNCiAgICAgICAgICAgICAgICBsaW5lLWhlaWdodDogMTIxJTsNCiAgICAgICAgICAgICAgICBsZXR0ZXItc3BhY2luZzogMCU7DQogICAgICAgICAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTsNCiAgICAgICAgICAgICAgICBtYXJnaW46IDAgIWltcG9ydGFudDsNCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIC5zdG9yeV9pbWcgew0KICAgICAgICAgICAgICAgIG1heC13aWR0aDogMTAwJTsNCiAgICAgICAgICAgICAgICBoZWlnaHQ6IGF1dG87DQogICAgICAgICAgICB9DQogICAgICAgICAgICAuc3RvcnlfcmVhZF9tb3JlIHsNCiAgICAgICAgICAgICAgICBjb2xvcjogIzE4MWE5MzsNCiAgICAgICAgICAgICAgICB0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTsNCiAgICAgICAgICAgICAgICBjdXJzb3I6IHBvaW50ZXI7DQogICAgICAgICAgICAgICAgZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7DQogICAgICAgICAgICAgICAgZm9udC13ZWlnaHQ6IDcwMDsNCiAgICAgICAgICAgICAgICBmb250LXNpemU6IDEzcHg7DQogICAgICAgICAgICAgICAgbGluZS1oZWlnaHQ6IDE0NSU7DQogICAgICAgICAgICB9DQogICAgICAgICAgICAudGl0bGVfaW1nIHsNCiAgICAgICAgICAgICAgICB3aWR0aDogMjVweDsNCiAgICAgICAgICAgICAgICBoZWlnaHQ6IDI1cHg7DQogICAgICAgICAgICB9DQogICAgICAgICAgICAudG9wX2hlYWRpbmdzIHsNCiAgICAgICAgICAgICAgICBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsNCiAgICAgICAgICAgICAgICBmb250LXdlaWdodDogNzAwOw0KICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogMTRweDsNCiAgICAgICAgICAgICAgICBsaW5lLWhlaWdodDogMTQ1JTsNCiAgICAgICAgICAgICAgICB2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOw0KICAgICAgICAgICAgfQ0KICAgICAgICAgICAgLnJlZF90ZXh0IHsNCiAgICAgICAgICAgICAgICBjb2xvcjogI2Q5MWYyMzsNCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIC5waWNrX29mX3RoZV9kYXkgew0KICAgICAgICAgICAgICAgIGZvbnQtZmFtaWx5OiAnVGltZXMgTmV3IFJvbWFuJywgVGltZXMsIHNlcmlmOw0KICAgICAgICAgICAgICAgIGZvbnQtd2VpZ2h0OiA1MDA7DQogICAgICAgICAgICAgICAgZm9udC1zaXplOiAxM3B4Ow0KICAgICAgICAgICAgICAgIGxpbmUtaGVpZ2h0OiAxNDUlOw0KICAgICAgICAgICAgICAgIHZlcnRpY2FsLWFsaWduOiBtaWRkbGU7DQogICAgICAgICAgICAgICAgdGV4dC1kZWNvcmF0aW9uOiB1bmRlcmxpbmU7DQogICAgICAgICAgICAgICAgY3Vyc29yOiBwb2ludGVyOw0KICAgICAgICAgICAgfQ0KICAgICAgICAgICAgLmFyb3VuZF90aGVfd2ViIHsNCiAgICAgICAgICAgICAgICBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsNCiAgICAgICAgICAgICAgICBmb250LXNpemU6IDEzcHg7DQogICAgICAgICAgICAgICAgbGluZS1oZWlnaHQ6IDEyMSU7DQogICAgICAgICAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTsNCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIC5paXRwcm9nYXRhZ3sNCiAgICAgICAgICAgICAgICBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7DQogICAgICAgICAgICAgICAgZm9udC13ZWlnaHQ6IDYwMDsNCiAgICAgICAgICAgICAgICBmb250LXNpemU6IDEwcHg7DQogICAgICAgICAgICAgICAgbGluZS1oZWlnaHQ6IDEwMCU7DQogICAgICAgICAgICAgICAgbGV0dGVyLXNwYWNpbmc6IDA7DQogICAgICAgICAgICAgICAgYm9yZGVyOiAwLjY1cHggc29saWQgI2U5MjEyMSAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgIHBhZGRpbmc6IDZweCAxMHB4Ow0KICAgICAgICAgICAgICAgIGNvbG9yOiAjZTkyMTIxICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgYm9yZGVyLXJhZGl1czogNS4xN3B4Ow0KICAgICAgICAgICAgICAgIHRleHQtZGVjb3JhdGlvbjogbm9uZSAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgfQ0KICAgICAgICAgICAgQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOjUwMHB4KXsNCiAgICAgICAgICAgICAgICAuYWlNYWludGl0bGV7DQogICAgICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogOXB4ICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDhweCA5cHggMCAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAuYWlTdWJ0aXRsZXsNCiAgICAgICAgICAgICAgICAgICAgZm9udC1zaXplOiAxMHB4ICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDBweCA5cHggIWltcG9ydGFudDsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgLmlpdHByb2dhTWFpbnsNCiAgICAgICAgICAgICAgICAgICAgcGFkZGluZzogMTBweCA5cHggMTJweCAhaW1wb3J0YW50Ow0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAuaWl0cHJvZ2F0YWd7DQogICAgICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogOXB4ICFpbXBvcnRhbnQ7DQogICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDZweCAhaW1wb3J0YW50Ow0KDQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgfQ0KICAgICAgICA8L3N0eWxlPg0KIDwvaGVhZD4NCiA8Ym9keSBzdHlsZT0ibWFyZ2luOjA7IHBhZGRpbmc6MDsgZm9udC1zaXplOjE2cHg7IGZvbnQtZmFtaWx5OkludGVyLEhlbHZldGljYSwgQXJpYWwsIHNhbnMtc2VyaWY7IGNvbG9yOiMwMDAwMDI7IGJhY2tncm91bmQtY29sb3I6I2ZmZmZmZjsiPg0KICA8IS0tIyNpc0NsaWVudEVuYWJsZWQ9ZmFsc2UjIy0tPiA8aW1nIHNyYz0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL29uP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjIiBoZWlnaHQ9IjEiIHdpZHRoPSIxIiBhbHQ9IiAiIHN0eWxlPSJoZWlnaHQ6MXB4O3dpZHRoOjFweCI-PCEtLS88aW1nLS0-DQogIDxkaXYgc3R5bGU9Im1heC13aWR0aDogNjAwcHg7IG1hcmdpbjogMCBhdXRvOyBiYWNrZ3JvdW5kOiAjZmZmOyBwYWRkaW5nOiAyMHB4OyIgY2xhc3M9Im1haW5EaXYiPg0KICAgPHRhYmxlIHN0eWxlPSJ3aWR0aDogMTAwJTsgbWF4LXdpZHRoOjYwMHB4OyBtYXJnaW46IDAgYXV0bzsgcGFkZGluZzogMjRweCAwOyBib3JkZXItcmFkaXVzOiA4cHg7IHRhYmxlLWxheW91dDogZml4ZWQ7IiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCI-DQogICAgPHRib2R5Pg0KICAgICA8dHI-DQogICAgICA8dGQ-DQogICAgICAgPGRpdiBzdHlsZT0iZGlzcGxheTpub25lICFpbXBvcnRhbnQ7dmlzaWJpbGl0eTpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtc2l6ZToxcHg7Y29sb3I6I2ZmZmZmZjtsaW5lLWhlaWdodDoxcHg7bWF4LWhlaWdodDowcHg7bWF4LXdpZHRoOjBweDtvcGFjaXR5OjA7b3ZlcmZsb3c6aGlkZGVuOyI-DQogICAgICAgIENoaW5hIGlzIGNsb3NpbmcgaW4gb24gVVMgdGVjaG5vbG9neSBsZWFkIGRlc3BpdGUgY29uc3RyYWludHMsIEFJIHJlc2VhcmNoZXJzIHNheQ0KICAgICAgIDwvZGl2PjwvdGQ-DQogICAgIDwvdHI-DQogICAgIDx0cj4NCiAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0id2lkdGg6IDEwMCU7IG1heC13aWR0aDogNjAwcHg7IG1pbi13aWR0aDogMzIwcHg7Ij4NCiAgICAgICA8dGFibGUgc3R5bGU9IndpZHRoOiAxMDAlOyBib3JkZXItcmFkaXVzOiAxMHB4OyI-DQogICAgICAgIDx0Ym9keT4NCiAgICAgICAgIDx0cj4NCiAgICAgICAgICA8dGQ-DQogICAgICAgICAgIDx0YWJsZSBzdHlsZT0id2lkdGg6IDEwMCU7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTtiYWNrZ3JvdW5kLWNvbG9yOiNmZmY7IiBjbGFzcz0idGFibGUgdGFibGUiPg0KICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkPjwhLS0gY291bGQgbm90IGdldCBkYXRhIC0tPiA8IS0tL21hcmtldF9ubHNwb25zb3JlZF9jb250LmNtcz9tc2lkPTEyMzE2NDg0MSZ1dG1fY2FtcGFpZ249QUluZXdzbGV0dGVyJnBvc2l0aW9uPXRvcCZ0bj1ldF9haV9uZXdzbGV0dGVycG90aW1lOjQtLT48L3RkPg0KICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICA8L3RhYmxlPjwvdGQ-DQogICAgICAgICA8L3RyPg0KICAgICAgICAgPHRyPg0KICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyOyBib3JkZXItcmFkaXVzOiAxMHB4OyI-PGEgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkODkiPjxpbWcgYWx0PSJFdF9haV9iYW5uZXIiIHNyYz0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3Bob3RvLzEyMDQwNjAxMS5jbXMiIHN0eWxlPSJ3aWR0aDogMTAwJTsgbWF4LXdpZHRoOiA2MDBweDsgaGVpZ2h0OiBhdXRvOyI-PC9hPjwvdGQ-DQogICAgICAgICA8L3RyPg0KICAgICAgICAgPHRyPg0KICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyOyBib3JkZXItcmFkaXVzOiAxMHB4O3BhZGRpbmctdG9wOjIwcHgiPjwhLS0gY291bGQgbm90IGdldCBkYXRhIC0tPiA8IS0tL21hcmtldF9ubHNwb25zb3JlZF9jb250LmNtcz9tc2lkPTEyMzE2NDg0MSZ1dG1fY2FtcGFpZ249QUluZXdzbGV0dGVyJnBvc2l0aW9uPWJhbm5lciZ0bj1ldF9haV9uZXdzbGV0dGVycG90aW1lOjQtLT48L3RkPg0KICAgICAgICAgPC90cj4NCiAgICAgICAgIDx0cj4NCiAgICAgICAgICA8dGQgYWxpZ249ImNlbnRlciIgY29sc3Bhbj0iMiIgc3R5bGU9InRleHQtYWxpZ246IGNlbnRlcjsgZm9udC13ZWlnaHQ6IDUwMDsgY29sb3I6ICMyODJiMmU7IG1hcmdpbjogMDsgcGFkZGluZzogMDsgZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7IGZvbnQtd2VpZ2h0OiA0MDA7IGZvbnQtc2l6ZTogMTRweDsgdGV4dC1hbGlnbjogbGVmdDsgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgbGluZS1oZWlnaHQ6IDIwcHg7IHBhZGRpbmc6IDI1cHggMDsiPg0KICAgICAgICAgICA8dGFibGUgc3R5bGU9IndpZHRoOiAxMDAlOyBib3JkZXI6IDJweCBzb2xpZCAjZmZlOWUyOyBib3JkZXItcmFkaXVzOiAxMHB4OyBwYWRkaW5nOiAyNXB4IDMwcHg7Ij4NCiAgICAgICAgICAgIDx0Ym9keT4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZD4NCiAgICAgICAgICAgICAgIDxwIHN0eWxlPSJmb250LXNpemU6IDE3cHg7Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxN3B4OyBmb250LXdlaWdodDogNjAwOyI-R29vZCBtb3JuaW5nIFJlYWRlciwgPC9zcGFuPjwhLS0jI0FJTkxTVU1NQVJZIyMtLT48L3A-DQogICAgICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1zaXplOiAxN3B4OyI-PHN0cm9uZz5JbiB0b2RheSdzIG5ld3NsZXR0ZXI6PC9zdHJvbmc-PC9wPg0KICAgICAgICAgICAgICAgPHVsIGNsYXNzPSJuZXdzX2x0cl9saXN0Ij4NCiAgICAgICAgICAgICAgICA8bGkgc3R5bGU9ImZvbnQtc2l6ZTogMTdweDsiPkNoaW5hIGlzIGNsb3NpbmcgaW4gb24gVVMgdGVjaG5vbG9neSBsZWFkIGRlc3BpdGUgY29uc3RyYWludHMsIEFJIHJlc2VhcmNoZXJzIHNheTwvbGk-DQogICAgICAgICAgICAgICAgPGxpIHN0eWxlPSJmb250LXNpemU6IDE3cHg7Ij5JbmRpYSBBSSBNaXNzaW9uIGZ1ZWxzIHN0YXJ0dXAgZWNvc3lzdGVtLCBzdHJlbmd0aGVucyBwdXNoIHRvIG1ha2UgSW5kaWEgJ2dsb2JhbCBBSSBwcm9kdWNlcic6IEV4cGVydHM8L2xpPg0KICAgICAgICAgICAgICAgIDxsaSBzdHlsZT0iZm9udC1zaXplOiAxN3B4OyI-SW4gY2hhbmdlZCBzdGFuY2UsIFpvaG_igJlzIFNyaWRoYXIgVmVtYnUgc2F5cyBBSSB3b27igJl0IHJlcGxhY2Ugc29mdHdhcmUgZW5naW5lZXJzPC9saT4NCiAgICAgICAgICAgICAgICA8bGkgc3R5bGU9ImZvbnQtc2l6ZTogMTdweDsiPlBNIE1vZGkgdGVsbHMgSW5kaWFBSSBzdGFydHVwcyB0byBzaG93Y2FzZSBsb2NhbCBBSSB1c2UgY2FzZXMgYXQgRmVicnVhcnkgc3VtbWl0PC9saT4NCiAgICAgICAgICAgICAgIDwvdWw-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgPC90YWJsZT48L3RkPg0KICAgICAgICAgPC90cj4NCiAgICAgICAgIDx0cj4NCiAgICAgICAgICA8dGQgYWxpZ249ImNlbnRlciIgY29sc3Bhbj0iMiI-DQogICAgICAgICAgIDx0YWJsZSBzdHlsZT0id2lkdGg6IDYwMHB4OyBib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOyBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgYm9yZGVyLXJhZGl1czogNXB4IDVweCAwIDA7Ij4NCiAgICAgICAgICAgIDx0Ym9keT4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyOyBwYWRkaW5nOjA7ICBib3JkZXItcmFkaXVzOiAxMHB4OyI-DQogICAgICAgICAgICAgICA8cCBzdHlsZT0ibWFyZ2luOjA7cGFkZGluZzowIiBjbGFzcz0iY2FyZF90aXRsZSI-PGltZyBhbHQ9ImFpX2luX25ld3NfYmFubmVyIiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjA0MDU5ODEuY21zIiBzdHlsZT0ibWF4LXdpZHRoOiA2MDBweDtoZWlnaHQ6YXV0bzsiPjwvcD48L3RkPg0KICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgPHRyIHhtbG5zOnhodG1sPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiB4bWxuczpqYXZhPSJqYXZhIj4NCiAgICAgICAgICAgICAgPHRkIHN0eWxlPSJtYXJnaW4tYm90dG9tOjA7Ij4NCiAgICAgICAgICAgICAgIDx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNsYXNzPSJhaW5ld3NCb3giIGNlbGxzcGFjaW5nPSIwIj4NCiAgICAgICAgICAgICAgICA8dGJvZHk-DQogICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXI7Ym9yZGVyLXJhZGl1czoxMHB4OyI-PGEgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkOGIiPjxpbWcgYWx0PSJBZF9pbWciIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtoZWlnaHQ6YXV0bztib3JkZXItcmFkaXVzOjEwcHg7bWFyZ2luLWJvdHRvbToyMHB4OyIgc3JjPSJodHRwczovL2Vjb25vbWljdGltZXMuaW5kaWF0aW1lcy5jb20vcGhvdG8vMTI0MDkwNzcwLmNtcz9pbWdzaXplPTQzODIxOCI-PC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPjwhLS0vYWlfYmFubmVyLmNtcz91dG1fY2FtcGFpZ249QUluZXdzbGV0dGVyJnRuYW1lPWV0X2FpX25ld3NsZXR0ZXJwb3RpbWU6MTMtLT48IS0tIGNvdWxkIG5vdCBnZXQgZGF0YSAtLT4gPCEtLS9tYXJrZXRfbmxzcG9uc29yZWRfY29udC5jbXM_bXNpZD0xMjMxNjQ4NDEmdXRtX2NhbXBhaWduPUFJbmV3c2xldHRlciZwb3NpdGlvbj1ib3R0b20mdG49ZXRfYWlfbmV3c2xldHRlcnBvdGltZTozLS0-PCEtLSMjYWlnZW5hcnRpY2xlIyMtLT4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0iICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb2xvcjogIzI4MmIyZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbnQtd2VpZ2h0OiA0MDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb250LXNpemU6IDE0cHg7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZXh0LWFsaWduOiBsZWZ0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmUtaGVpZ2h0OiAyMHB4OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFkZGluZzogNXB4IDAgMjBweDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIj4NCiAgICAgICAgICAgICAgIDx0YWJsZSBjbGFzcz0iYWluZXdzQm94IiBzdHlsZT0id2lkdGg6IDYwMHB4OyBib3JkZXI6IDJweCBzb2xpZCAjZmZlOWUyOyBib3JkZXItcmFkaXVzOiAxMHB4OyBwYWRkaW5nOiAyNXB4IDU1cHg7Ij4NCiAgICAgICAgICAgICAgICA8dGJvZHk-DQogICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgIDx0ZD4NCiAgICAgICAgICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMjJweDsgbGluZS1oZWlnaHQ6IDEyMSU7IHZlcnRpY2FsLWFsaWduOiBtaWRkbGU7bWFyZ2luOiAwICFpbXBvcnRhbnQ7IiBjbGFzcz0ic3RvcnlfdGl0bGUiPlBNIE1vZGkgdGVsbHMgSW5kaWFBSSBzdGFydHVwcyB0byBzaG93Y2FzZSBsb2NhbCBBSSB1c2UgY2FzZXMgYXQgRmVicnVhcnkgc3VtbWl0PC9wPg0KICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJ0ZXh0LWFsaWduOiBjZW50ZXI7bWFyZ2luLWJvdHRvbTogMjBweDsiPjxpbWcgc3R5bGU9Im1heC13aWR0aDogMTAwJTtoZWlnaHQ6IGF1dG87IiBhbHQ9ImFydGljbGVfaW1nIiBjbGFzcz0ic3RvcnlfaW1nIiBzcmM9Imh0dHA6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3RodW1iLzEyNjQ1MjI5OC5jbXM_d2lkdGg9NTI1JmFtcDtoZWlnaHQ9MzkzJmFtcDtyZXNpemVtb2RlPTQiPjwvcD4NCiAgICAgICAgICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1zaXplOiAxN3B4OyI-VGhlIFBNIGhlbGQgYSBjbG9zZWQtZG9vciBtZWV0aW5nIGF0IGhpcyByZXNpZGVuY2Ugb24gSmFudWFyeSA4IHdpdGggYWJvdXQgYSBkb3plbiBmb3VuZGVycyBmcm9tIHRoZSBJbmRpYUFJIE1pc3Npb24gY29ob3J0LiBVbmlvbiBJVCBtaW5pc3RlciBBc2h3aW5pIFZhaXNobmF3IGFuZCBzZW5pb3Igb2ZmaWNpYWxzIG9mIE1laXRZIGFsc28gYXR0ZW5kZWQgdGhlIG1lZXRpbmcuIE1vZGkgdG9sZCB0aGUgZm91bmRlcnMgdG8gZGV2ZWxvcCBzYWZlIGFuZCBhdXRoZW50aWNhdGVkIEFJLCBwcmlvcml0aXNpbmcgdHJ1c3QsIHRyYW5zcGFyZW5jeSwgYW5kIHdhdGVybWFya2luZyBpbiB0aGVpciBtb2RlbHMgdG8gYnVpbGQgdXNlciBjb25maWRlbmNlIGFuZCBjb21wbHkgd2l0aCBldm9sdmluZyByZWd1bGF0aW9ucy48L3A-PGEgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSJzdG9yeV9yZWFkX21vcmUiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbC9uYXRpdmU_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MmY2MTRlZjIwMjYyMGFlMmM1MzNiIiB0aXRsZT0iUE0gTW9kaSB0ZWxscyBJbmRpYUFJIHN0YXJ0dXBzIHRvIHNob3djYXNlIGxvY2FsIEFJIHVzZSBjYXNlcyBhdCBGZWJydWFyeSBzdW1taXQiPiBSZWFkIGZ1bGwgYXJ0aWNsZSBoZXJlIDwvYT48L3RkPg0KICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICA8L3RhYmxlPjwvdGQ-DQogICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZD48IS0tIGNvdWxkIG5vdCBnZXQgZGF0YSAtLT4gPCEtLS9tYXN0ZXJjbGFzc19tYWlsZXJfd2lkZ2V0LmNtcz91dG1fc291cmNlPWFpX25ld3NsZXR0ZXJwb3RpbWU6MS0tPjwvdGQ-DQogICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0iICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb2xvcjogIzI4MmIyZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbnQtd2VpZ2h0OiA0MDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb250LXNpemU6IDE0cHg7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZXh0LWFsaWduOiBsZWZ0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmUtaGVpZ2h0OiAyMHB4OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFkZGluZzogNXB4IDAgMjBweDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIj4NCiAgICAgICAgICAgICAgIDx0YWJsZSBjbGFzcz0iYWluZXdzQm94IiBzdHlsZT0id2lkdGg6IDYwMHB4OyBib3JkZXI6IDJweCBzb2xpZCAjZmZlOWUyOyBib3JkZXItcmFkaXVzOiAxMHB4OyBwYWRkaW5nOiAyNXB4IDU1cHg7Ij4NCiAgICAgICAgICAgICAgICA8dGJvZHk-DQogICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgIDx0ZD4NCiAgICAgICAgICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMjJweDsgbGluZS1oZWlnaHQ6IDEyMSU7IHZlcnRpY2FsLWFsaWduOiBtaWRkbGU7bWFyZ2luOiAwICFpbXBvcnRhbnQ7IiBjbGFzcz0ic3RvcnlfdGl0bGUiPk5pbmUgSVRJcyBpbiBPZGlzaGEgdG8gZ2V0IEFJIGxhYnM6IENNIE1vaGFuIENoYXJhbiBNYWpoaTwvcD4NCiAgICAgICAgICAgICAgICAgICA8cCBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyO21hcmdpbi1ib3R0b206IDIwcHg7Ij48aW1nIHN0eWxlPSJtYXgtd2lkdGg6IDEwMCU7aGVpZ2h0OiBhdXRvOyIgYWx0PSJhcnRpY2xlX2ltZyIgY2xhc3M9InN0b3J5X2ltZyIgc3JjPSJodHRwOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS90aHVtYi8xMjY0NTEyNjEuY21zP3dpZHRoPTUyNSZhbXA7aGVpZ2h0PTM5MyZhbXA7cmVzaXplbW9kZT00Ij48L3A-DQogICAgICAgICAgICAgICAgICAgPHAgc3R5bGU9ImZvbnQtc2l6ZTogMTdweDsiPk9kaXNoYSBjaGllZiBtaW5pc3RlciBNb2hhbiBDaGFyYW4gTWFqaGkgb24gRnJpZGF5IHNhaWQgYXJ0aWZpY2lhbCBpbnRlbGxpZ2VuY2UgKEFJKSBsYWJvcmF0b3JpZXMgYXJlIGJlaW5nIHNldCB1cCBpbiBuaW5lIEluZHVzdHJpYWwgVHJhaW5pbmcgSW5zdGl0dXRlcyAoSVRJcykgb2YgdGhlIHN0YXRlLjwvcD48YSB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9InN0b3J5X3JlYWRfbW9yZSIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsL25hdGl2ZT9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYyZjYxNGVmMjAyNjIwYWUyYzUzM2MiIHRpdGxlPSJOaW5lIElUSXMgaW4gT2Rpc2hhIHRvIGdldCBBSSBsYWJzOiBDTSBNb2hhbiBDaGFyYW4gTWFqaGkiPiBSZWFkIGZ1bGwgYXJ0aWNsZSBoZXJlIDwvYT48L3RkPg0KICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICA8L3RhYmxlPjwvdGQ-DQogICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZD4NCiAgICAgICAgICAgICAgIDx0YWJsZSBzdHlsZT0icGFkZGluZy1ib3R0b206MTZweDsiIGJvcmRlcj0iMCIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiB3aWR0aD0iMTAwJSI-DQogICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9ImZvbnQtZmFtaWx5OiAnTW9udHNlcnJhdCcsIHNhbnMtc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMTZweDsgbGluZS1oZWlnaHQ6IDEuMjsgcGFkZGluZy1ib3R0b206OHB4O3BhZGRpbmctbGVmdDogN3B4OyIgYWxpZ249ImxlZnQiIGNvbHNwYW49IjUiPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTpibG9jazsgY29sb3I6IzAwMDt0ZXh0LWRlY29yYXRpb246IG5vbmU7IiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZDhjIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6ICdNb250c2VycmF0Jywgc2Fucy1zZXJpZjsgZm9udC13ZWlnaHQ6IDYwMDsgZm9udC1zaXplOiAxNnB4OyBsaW5lLWhlaWdodDogMS4yOyBsZXR0ZXItc3BhY2luZzogMDsgdmVydGljYWwtYWxpZ246IG1pZGRsZTsiPkV4cGxvcmUgQ291cnNlczwvc3Bhbj48aW1nIGFsdD0iYXJyb3dJY29uIiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjU5MTQ4OTYuY21zIiBzdHlsZT0idmVydGljYWwtYWxpZ246IG1pZGRsZTttYXJnaW4tbGVmdDogNnB4O21hcmdpbi10b3A6IDJweDsgbWF4LXdpZHRoOjZweCAhaW1wb3J0YW50OyI-PC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9InBhZGRpbmctYm90dG9tOjhweDtwYWRkaW5nLXJpZ2h0OiA3cHg7IiBhbGlnbj0icmlnaHQiIGNvbHNwYW49IjQiPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTpibG9jazsgbWF4LXdpZHRoOiAxNzBweDtoZWlnaHQ6YXV0bzsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkOGMiPjxpbWcgYWx0PSJhaV9pbl9uZXdzX2Jhbm5lciIgc3R5bGU9Im1heC13aWR0aDogMTAwJTtoZWlnaHQ6YXV0bzsiIHNyYz0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3Bob3RvLzEyNTg2MzQ2Ni5jbXMiPjwvYT48L3RkPg0KICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9IndpZHRoOjdweDtsaW5lLWhlaWdodDowIj4mbmJzcDs8L3RkPg0KICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBzdHlsZT0iYm9yZGVyOiAwLjY1cHggc29saWQgI2RkZGRkZDsgYm9yZGVyLXJhZGl1czogMTAuMzRweDsgb3ZlcmZsb3c6IGhpZGRlbjsgd2lkdGg6MzMlOyBtaW4td2lkdGg6IDk4cHg7Ij4NCiAgICAgICAgICAgICAgICAgICA8dGFibGUgYm9yZGVyPSIwIiBjZWxsc3BhY2luZz0iMCIgY2VsbHBhZGRpbmc9IjAiIHdpZHRoPSIxMDAlIj4NCiAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgICAgIDx0ZCB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6MDtsaW5lLWhlaWdodDowIj48aW1nIGFsdD0iYWlfaW5fbmV3c19iYW5uZXIiIHN0eWxlPSJtYXgtd2lkdGg6IDEwMCU7aGVpZ2h0OmF1dG87IiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjU5MzIzNzUuY21zIj48L3RkPg0KICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIHN0eWxlPSJmb250LWZhbWlseTogJ01vbnRzZXJyYXQnLCBzYW5zLXNlcmlmOyBmb250LXdlaWdodDogNjAwOyBmb250LXNpemU6IDEwcHg7IGxpbmUtaGVpZ2h0OiAxLjI7IGxldHRlci1zcGFjaW5nOiAwOyB2ZXJ0aWNhbC1hbGlnbjogdG9wOyBjb2xvcjojZTkyMTIxO3BhZGRpbmc6OHB4IDEzcHggMDsgaGVpZ2h0OjMwcHg7IiBjbGFzcz0iYWlNYWludGl0bGUiPkZvciBMZWFkZXJzPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBzdHlsZT0iZm9udC1mYW1pbHk6ICdNb250c2VycmF0Jywgc2Fucy1zZXJpZjsgZm9udC13ZWlnaHQ6IDYwMDsgZm9udC1zaXplOiAxMnB4OyBsaW5lLWhlaWdodDogMS4yOyBsZXR0ZXItc3BhY2luZzogMDsgY29sb3I6IzFlMWUxZTtwYWRkaW5nOjBweCAxM3B4OyBoZWlnaHQ6NzBweDsiIGNsYXNzPSJhaVN1YnRpdGxlIj5BSS1Qb3dlcmXigItkIERlY2lzaW9uIE1ha2luZzwvdGQ-DQogICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgICAgIDx0ZCBzdHlsZT0iZm9udC1mYW1pbHk6ICdNb250c2VycmF0Jywgc2Fucy1zZXJpZjsgZm9udC13ZWlnaHQ6IDYwMDsgZm9udC1zaXplOiAxMHB4OyBsaW5lLWhlaWdodDogMS4yOyBsZXR0ZXItc3BhY2luZzogMDsgY29sb3I6I2U5MjEyMTtwYWRkaW5nOjEwcHggMTNweCAxMnB4OyIgY2xhc3M9ImlpdHByb2dhTWFpbiI-PGEgdGFyZ2V0PSJfYmxhbmsiIHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtZmFtaWx5OiAnTW9udHNlcnJhdCcsIHNhbnMtc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMTBweDsgbGluZS1oZWlnaHQ6IDEuMjsgbGV0dGVyLXNwYWNpbmc6IDA7IGJvcmRlcjowLjY1cHggc29saWQgI2U5MjEyMTsgcGFkZGluZzo2cHggMTBweDsgY29sb3I6ICNlOTIxMjE7IGJvcmRlci1yYWRpdXM6IDUuMTdweDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyIgY2xhc3M9ImlpdHByb2dhdGFnIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MzA0NDRiNDAwNDkwOGM5NTMxNmNkIj48c3BhbiBzdHlsZT0idmVydGljYWwtYWxpZ246IG1pZGRsZTsiPktub3cgbW9yZTwvc3Bhbj48aW1nIGFsdD0iS25vd01vcmVJY29uIiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjU5MTQ4OTQuY21zIiBzdHlsZT0idmVydGljYWwtYWxpZ246IG1pZGRsZTttYXJnaW4tbGVmdDogM3B4OyAgICBtYXJnaW4tdG9wOiAycHg7IG1heC13aWR0aDoxMHB4ICFpbXBvcnRhbnQ7Ij48L2E-PC90ZD4NCiAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgPC90YWJsZT48L3RkPg0KICAgICAgICAgICAgICAgICAgPHRkIHN0eWxlPSJ3aWR0aDo3cHg7bGluZS1oZWlnaHQ6MCI-Jm5ic3A7PC90ZD4NCiAgICAgICAgICAgICAgICAgIDx0ZCBzdHlsZT0id2lkdGg6N3B4O2xpbmUtaGVpZ2h0OjAiPiZuYnNwOzwvdGQ-DQogICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIHN0eWxlPSJib3JkZXI6IDAuNjVweCBzb2xpZCAjZGRkZGRkOyBib3JkZXItcmFkaXVzOiAxMC4zNHB4OyBvdmVyZmxvdzogaGlkZGVuOyB3aWR0aDozMyU7IG1pbi13aWR0aDogOThweDsiPg0KICAgICAgICAgICAgICAgICAgIDx0YWJsZSBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgd2lkdGg9IjEwMCUiPg0KICAgICAgICAgICAgICAgICAgICA8dGJvZHk-DQogICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBzdHlsZT0icGFkZGluZzowO2xpbmUtaGVpZ2h0OjAiPjxpbWcgYWx0PSJhaV9pbl9uZXdzX2Jhbm5lciIgc3R5bGU9Im1heC13aWR0aDogMTAwJTtoZWlnaHQ6YXV0bzsiIHNyYz0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3Bob3RvLzEyNTkzMjMwOC5jbXMiPjwvdGQ-DQogICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgICAgIDx0ZCB2YWxpZ249InRvcCIgc3R5bGU9ImZvbnQtZmFtaWx5OiAnTW9udHNlcnJhdCcsIHNhbnMtc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMTBweDsgbGluZS1oZWlnaHQ6IDEuMjsgbGV0dGVyLXNwYWNpbmc6IDA7IHZlcnRpY2FsLWFsaWduOiB0b3A7IGNvbG9yOiNlOTIxMjE7cGFkZGluZzo4cHggMTNweCAwOyBoZWlnaHQ6MzBweDsiIGNsYXNzPSJhaU1haW50aXRsZSI-Rm9yIExlYWRlcnM8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIHN0eWxlPSJmb250LWZhbWlseTogJ01vbnRzZXJyYXQnLCBzYW5zLXNlcmlmOyBmb250LXdlaWdodDogNjAwOyBmb250LXNpemU6IDEycHg7IGxpbmUtaGVpZ2h0OiAxLjI7IGxldHRlci1zcGFjaW5nOiAwOyBjb2xvcjojMWUxZTFlO3BhZGRpbmc6MHB4IDEzcHg7IGhlaWdodDo3MHB4OyIgY2xhc3M9ImFpU3VidGl0bGUiPkdlbmVyYXRpdmUgQUkgQXBwbGljYXRpb24gZm9yIExlYWRlcnM8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9ImZvbnQtZmFtaWx5OiAnTW9udHNlcnJhdCcsIHNhbnMtc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMTBweDsgbGluZS1oZWlnaHQ6IDEuMjsgbGV0dGVyLXNwYWNpbmc6IDA7IGNvbG9yOiNlOTIxMjE7cGFkZGluZzoxMHB4IDEzcHggMTJweDsiIGNsYXNzPSJpaXRwcm9nYU1haW4iPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LWZhbWlseTogJ01vbnRzZXJyYXQnLCBzYW5zLXNlcmlmOyBmb250LXdlaWdodDogNjAwOyBmb250LXNpemU6IDEwcHg7IGxpbmUtaGVpZ2h0OiAxLjI7IGxldHRlci1zcGFjaW5nOiAwOyBib3JkZXI6MC42NXB4IHNvbGlkICNlOTIxMjE7IHBhZGRpbmc6NnB4IDEwcHg7IGNvbG9yOiAjZTkyMTIxOyBib3JkZXItcmFkaXVzOiA1LjE3cHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiIGNsYXNzPSJpaXRwcm9nYXRhZyIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjMwNDQ0YjQwMDQ5MDhjOTUzMTZjZCI-PHNwYW4gc3R5bGU9InZlcnRpY2FsLWFsaWduOiBtaWRkbGU7Ij5Lbm93IG1vcmU8L3NwYW4-PGltZyBhbHQ9Iktub3dNb3JlSWNvbiIgc3JjPSJodHRwczovL2Vjb25vbWljdGltZXMuaW5kaWF0aW1lcy5jb20vcGhvdG8vMTI1OTE0ODk0LmNtcyIgc3R5bGU9InZlcnRpY2FsLWFsaWduOiBtaWRkbGU7bWFyZ2luLWxlZnQ6IDNweDsgICAgbWFyZ2luLXRvcDogMnB4OyBtYXgtd2lkdGg6MTBweCAhaW1wb3J0YW50OyI-PC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgICAgICAgICAgICAgIDx0ZCBzdHlsZT0id2lkdGg6N3B4O2xpbmUtaGVpZ2h0OjAiPiZuYnNwOzwvdGQ-DQogICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9IndpZHRoOjdweDtsaW5lLWhlaWdodDowIj4mbmJzcDs8L3RkPg0KICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBzdHlsZT0iYm9yZGVyOiAwLjY1cHggc29saWQgI2RkZGRkZDsgYm9yZGVyLXJhZGl1czogMTAuMzRweDsgb3ZlcmZsb3c6IGhpZGRlbjsgd2lkdGg6MzMlOyBtaW4td2lkdGg6IDk4cHg7Ij4NCiAgICAgICAgICAgICAgICAgICA8dGFibGUgYm9yZGVyPSIwIiBjZWxsc3BhY2luZz0iMCIgY2VsbHBhZGRpbmc9IjAiIHdpZHRoPSIxMDAlIj4NCiAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgICAgIDx0ZCB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6MDtsaW5lLWhlaWdodDowIj48aW1nIGFsdD0iYWlfaW5fbmV3c19iYW5uZXIiIHN0eWxlPSJtYXgtd2lkdGg6IDEwMCU7aGVpZ2h0OmF1dG87IiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjU5MzIzMDkuY21zIj48L3RkPg0KICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIHN0eWxlPSJmb250LWZhbWlseTogJ01vbnRzZXJyYXQnLCBzYW5zLXNlcmlmOyBmb250LXdlaWdodDogNjAwOyBmb250LXNpemU6IDEwcHg7IGxpbmUtaGVpZ2h0OiAxLjI7IGxldHRlci1zcGFjaW5nOiAwOyB2ZXJ0aWNhbC1hbGlnbjogdG9wOyBjb2xvcjojZTkyMTIxO3BhZGRpbmc6OHB4IDEzcHggMDsgaGVpZ2h0OjMwcHg7IiBjbGFzcz0iYWlNYWludGl0bGUiPkZvciBQcm9kdWN0IGFuZCBCdXNpbmVzcyBNYW5hZ2VyczwvdGQ-DQogICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgICAgIDx0ZCB2YWxpZ249InRvcCIgc3R5bGU9ImZvbnQtZmFtaWx5OiAnTW9udHNlcnJhdCcsIHNhbnMtc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMTJweDsgbGluZS1oZWlnaHQ6IDEuMjsgbGV0dGVyLXNwYWNpbmc6IDA7IGNvbG9yOiMxZTFlMWU7cGFkZGluZzowcHggMTNweDsgaGVpZ2h0OjcwcHg7IiBjbGFzcz0iYWlTdWJ0aXRsZSI-QUktUG93ZXJlZCBQcm9mZXNzaW9uYWwgQ2VydGlmaWNhdGlvbiBpbiBQcm9kdWN0IE1hbmFnZW1lbnQ8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9ImZvbnQtZmFtaWx5OiAnTW9udHNlcnJhdCcsIHNhbnMtc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMTBweDsgbGluZS1oZWlnaHQ6IDEuMjsgbGV0dGVyLXNwYWNpbmc6IDA7IGNvbG9yOiNlOTIxMjE7cGFkZGluZzoxMHB4IDEzcHggMTJweDsiIGNsYXNzPSJpaXRwcm9nYU1haW4iPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LWZhbWlseTogJ01vbnRzZXJyYXQnLCBzYW5zLXNlcmlmOyBmb250LXdlaWdodDogNjAwOyBmb250LXNpemU6IDEwcHg7IGxpbmUtaGVpZ2h0OiAxLjI7IGxldHRlci1zcGFjaW5nOiAwOyBib3JkZXI6MC42NXB4IHNvbGlkICNlOTIxMjE7IHBhZGRpbmc6NnB4IDEwcHg7IGNvbG9yOiAjZTkyMTIxOyBib3JkZXItcmFkaXVzOiA1LjE3cHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiIGNsYXNzPSJpaXRwcm9nYXRhZyIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjMwNDQ0YjQwMDQ5MDhjOTUzMTZjZiI-PHNwYW4gc3R5bGU9InZlcnRpY2FsLWFsaWduOiBtaWRkbGU7Ij5Lbm93IG1vcmU8L3NwYW4-PGltZyBhbHQ9Iktub3dNb3JlSWNvbiIgc3JjPSJodHRwczovL2Vjb25vbWljdGltZXMuaW5kaWF0aW1lcy5jb20vcGhvdG8vMTI1OTE0ODk0LmNtcyIgc3R5bGU9InZlcnRpY2FsLWFsaWduOiBtaWRkbGU7bWFyZ2luLWxlZnQ6IDNweDsgICAgbWFyZ2luLXRvcDogMnB4OyBtYXgtd2lkdGg6MTBweCAhaW1wb3J0YW50OyI-PC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgICAgICAgICAgICAgIDx0ZCBzdHlsZT0id2lkdGg6N3B4O2xpbmUtaGVpZ2h0OjAiPiZuYnNwOzwvdGQ-DQogICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgIDwvdGFibGU-PCEtLS9ldF9haV9leHBsb3JlX2NvdXJzZXMuY21zP3V0bV9zb3VyY2U9YWlfbmV3c2xldHRlcnBvdGltZToxNS0tPjwvdGQ-DQogICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIiBzdHlsZT0iY29sb3I6ICMyODJiMmU7IG1hcmdpbjogMDsgZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7IGZvbnQtd2VpZ2h0OiA0MDA7IGZvbnQtc2l6ZTogMTRweDsgdGV4dC1hbGlnbjogbGVmdDsgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgbGluZS1oZWlnaHQ6IDIwcHg7IHBhZGRpbmc6IDVweCAwIDIwcHg7Ij4NCiAgICAgICAgICAgICAgIDx0YWJsZSBjbGFzcz0iYWluZXdzQm94IiBzdHlsZT0id2lkdGg6IDEwMCU7IGJvcmRlcjogMnB4IHNvbGlkICNmZmU5ZTI7IGJvcmRlci1yYWRpdXM6IDEwcHg7IHBhZGRpbmc6IDI1cHggNTVweDsiPg0KICAgICAgICAgICAgICAgIDx0Ym9keT4NCiAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgPHRkPg0KICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgZm9udC13ZWlnaHQ6IDYwMDsgZm9udC1zaXplOiAyMnB4OyBsaW5lLWhlaWdodDogMTIxJTsgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgbWFyZ2luOiAwIDAgMjBweCAhaW1wb3J0YW50OyIgY2xhc3M9InN0b3J5X3RpdGxlIj48c3BhbiBzdHlsZT0idmVydGljYWwtYWxpZ246IG1pZGRsZTsgbWFyZ2luLXJpZ2h0OiA4cHg7Ij48aW1nIHN0eWxlPSJ3aWR0aDogMjVweDsgaGVpZ2h0OiAyNXB4OyBtYXgtd2lkdGg6IDI1cHg7IGhlaWdodDogYXV0bzsiIGFsdD0iIiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjAzNDM2NTIuY21zIiBjbGFzcz0idGl0bGVfaW1nIj48L3NwYW4-IFBvcHVsYXIgQUkgdG9vbHMgZm9yIHlvdTwvcD48YSB0YXJnZXQ9Il9ibGFuayIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7IGNvbG9yOiMwMDA7bWFyZ2luLWJvdHRvbToxNnB4IiBjbGFzcz0idG9wX2hlYWRpbmdzIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MmY2MTRlZjIwMjYyMGFlMmM1MzNkIiB0aXRsZT0iU3ludGhlc2lhIj48c3BhbiBjbGFzcz0icmVkX3RleHQiPlN5bnRoZXNpYTwvc3Bhbj4gLSBDcmVhdGUgQUkgdmlkZW9zIHdpdGggZGlnaXRhbCBhdmF0YXJzLjwvYT48YSB0YXJnZXQ9Il9ibGFuayIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7IGNvbG9yOiMwMDA7bWFyZ2luLWJvdHRvbToxNnB4IiBjbGFzcz0idG9wX2hlYWRpbmdzIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MmY2MTRlZjIwMjYyMGFlMmM1MzNlIiB0aXRsZT0iVGVhbCI-PHNwYW4gY2xhc3M9InJlZF90ZXh0Ij5UZWFsPC9zcGFuPiAtIEpvYiBzZWFyY2ggY29waWxvdCBwb3dlcmVkIGJ5IEFJLjwvYT48YSB0YXJnZXQ9Il9ibGFuayIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7IGNvbG9yOiMwMDA7bWFyZ2luLWJvdHRvbToxNnB4IiBjbGFzcz0idG9wX2hlYWRpbmdzIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MmY2MTRlZjIwMjYyMGFlMmM1MzNmIiB0aXRsZT0iVGV4dGlvIj48c3BhbiBjbGFzcz0icmVkX3RleHQiPlRleHRpbzwvc3Bhbj4gLSBBdWdtZW50ZWQgd3JpdGluZyBwbGF0Zm9ybSB0byBjcmVhdGUgaW5jbHVzaXZlIGNvbnRlbnQuPC9hPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTpibG9jazsgY29sb3I6IzAwMDttYXJnaW4tYm90dG9tOjE2cHgiIGNsYXNzPSJ0b3BfaGVhZGluZ3MiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYyZjYxNGVmMjAyNjIwYWUyYzUzNDAiIHRpdGxlPSJUaWRpbyBBSSI-PHNwYW4gY2xhc3M9InJlZF90ZXh0Ij5UaWRpbyBBSTwvc3Bhbj4gLSBBSS1wb3dlcmVkIGN1c3RvbWVyIHNlcnZpY2UgY2hhdGJvdHMuPC9hPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTpibG9jazsgY29sb3I6IzAwMDttYXJnaW4tYm90dG9tOjE2cHgiIGNsYXNzPSJ0b3BfaGVhZGluZ3MiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYyZjYxNGVmMjAyNjIwYWUyYzUzNDEiIHRpdGxlPSJ2MCI-PHNwYW4gY2xhc3M9InJlZF90ZXh0Ij52MDwvc3Bhbj4gLSBHZW5lcmF0ZSB3ZWIgVUlzIHdpdGggQUkgZnJvbSBWZXJjZWwuPC9hPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTpibG9jazsgY29sb3I6IzAwMDttYXJnaW4tYm90dG9tOjE2cHgiIGNsYXNzPSJ0b3BfaGVhZGluZ3MiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYyZjYxNGVmMjAyNjIwYWUyYzUzNDIiIHRpdGxlPSJWaXN0YSBTb2NpYWwiPjxzcGFuIGNsYXNzPSJyZWRfdGV4dCI-VmlzdGEgU29jaWFsPC9zcGFuPiAtIEFJLXBvd2VyZWQgc29jaWFsIG1lZGlhIG1hbmFnZW1lbnQgcGxhdGZvcm0uPC9hPjxhIHRhcmdldD0iX2JsYW5rIiBzdHlsZT0iZGlzcGxheTpibG9jazsgY29sb3I6IzAwMDttYXJnaW4tYm90dG9tOjE2cHgiIGNsYXNzPSJ0b3BfaGVhZGluZ3MiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYyZjYxNGVmMjAyNjIwYWUyYzUzNDMiIHRpdGxlPSJXb3JkdHVuZSI-PHNwYW4gY2xhc3M9InJlZF90ZXh0Ij5Xb3JkdHVuZTwvc3Bhbj4gLSBSZXBocmFzZSBhbmQgZW5oYW5jZSB3cml0aW5nIHdpdGggQUkuPC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIGNvbHNwYW49IjIiIHN0eWxlPSIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29sb3I6ICMyODJiMmU7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcmdpbjogMDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbnQtd2VpZ2h0OiA0MDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbnQtc2l6ZTogMTRweDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGV4dC1hbGlnbjogbGVmdDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGluZS1oZWlnaHQ6IDIwcHg7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZGRpbmc6IDVweCAwIDIwcHg7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIj4NCiAgICAgICAgICAgICAgIDx0YWJsZSBjbGFzcz0iYWluZXdzQm94IiBzdHlsZT0id2lkdGg6IDYwMHB4OyBib3JkZXI6IDJweCBzb2xpZCAjZmZlOWUyOyBib3JkZXItcmFkaXVzOiAxMHB4OyBwYWRkaW5nOiAyNXB4IDU1cHg7Ij4NCiAgICAgICAgICAgICAgICA8dGJvZHk-DQogICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgIDx0ZD4NCiAgICAgICAgICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7IGZvbnQtd2VpZ2h0OiA2MDA7IGZvbnQtc2l6ZTogMjJweDsgbGluZS1oZWlnaHQ6IDEyMSU7IHZlcnRpY2FsLWFsaWduOiBtaWRkbGU7IG1hcmdpbjogMCAwIDIwcHggIWltcG9ydGFudDsiIGNsYXNzPSJzdG9yeV90aXRsZSI-PHNwYW4gc3R5bGU9InZlcnRpY2FsLWFsaWduOiBtaWRkbGU7IG1hcmdpbi1yaWdodDogOHB4OyI-PGltZyBzdHlsZT0id2lkdGg6IDI1cHg7aGVpZ2h0OiAyNXB4O21heC13aWR0aDoyNXB4OyBoZWlnaHQ6YXV0bzsiIGFsdD0iIiBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjAzNDM2NDkuY21zIiBjbGFzcz0idGl0bGVfaW1nIj48L3NwYW4-IFNwZWNpYWwgcGlja3Mgb2YgdGhlIGRheTwvcD48YSBzdHlsZT0iZGlzcGxheTpibG9jaztmb250LXNpemU6IDE0cHg7Zm9udC13ZWlnaHQ6IDUwMDt0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtjb2xvcjojMDAwMDAwO21hcmdpbi1ib3R0b206MTdweCIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSJwaWNrX29mX3RoZV9kYXkiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbC9uYXRpdmU_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MmY2MTRlZjIwMjYyMGFlMmM1MzNjIiB0aXRsZT0iTmluZSBJVElzIGluIE9kaXNoYSB0byBnZXQgQUkgbGFiczogQ00gTW9oYW4gQ2hhcmFuIE1hamhpIj5OaW5lIElUSXMgaW4gT2Rpc2hhIHRvIGdldCBBSSBsYWJzOiBDTSBNb2hhbiBDaGFyYW4gTWFqaGk8L2E-PGEgc3R5bGU9ImRpc3BsYXk6YmxvY2s7Zm9udC1zaXplOiAxNHB4O2ZvbnQtd2VpZ2h0OiA1MDA7dGV4dC1kZWNvcmF0aW9uOiB1bmRlcmxpbmU7Y29sb3I6IzAwMDAwMDttYXJnaW4tYm90dG9tOjE3cHgiIHRhcmdldD0iX2JsYW5rIiBjbGFzcz0icGlja19vZl90aGVfZGF5IiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2wvbmF0aXZlP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjJmNjE0ZWYyMDI2MjBhZTJjNTM0NCIgdGl0bGU9IkJyZXcsIHNtZWxsLCBhbmQgc2VydmU6IEFJIHN0ZWFscyB0aGUgc2hvdyBhdCBDRVMgMjAyNiI-QnJldywgc21lbGwsIGFuZCBzZXJ2ZTogQUkgc3RlYWxzIHRoZSBzaG93IGF0IENFUyAyMDI2PC9hPjxhIHN0eWxlPSJkaXNwbGF5OmJsb2NrO2ZvbnQtc2l6ZTogMTRweDtmb250LXdlaWdodDogNTAwO3RleHQtZGVjb3JhdGlvbjogdW5kZXJsaW5lO2NvbG9yOiMwMDAwMDA7bWFyZ2luLWJvdHRvbToxN3B4IiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9InBpY2tfb2ZfdGhlX2RheSIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsL25hdGl2ZT9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYyZjYxNGVmMjAyNjIwYWUyYzUzNDUiIHRpdGxlPSJBSSBnb2JibGluZyB1cCBtZW1vcnkgY2hpcHMgZXNzZW50aWFsIHRvIGdhZGdldCBtYWtlcnMiPkFJIGdvYmJsaW5nIHVwIG1lbW9yeSBjaGlwcyBlc3NlbnRpYWwgdG8gZ2FkZ2V0IG1ha2VyczwvYT48YSBzdHlsZT0iZGlzcGxheTpibG9jaztmb250LXNpemU6IDE0cHg7Zm9udC13ZWlnaHQ6IDUwMDt0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtjb2xvcjojMDAwMDAwO21hcmdpbi1ib3R0b206MTdweCIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSJwaWNrX29mX3RoZV9kYXkiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbC9uYXRpdmU_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MmY2MTRlZjIwMjYyMGFlMmM1MzQ2IiB0aXRsZT0iSW5kb25lc2lhIHRlbXBvcmFyaWx5IGJsb2NrcyBhY2Nlc3MgdG8gR3JvayBvdmVyIHNleHVhbGlzZWQgaW1hZ2VzIj5JbmRvbmVzaWEgdGVtcG9yYXJpbHkgYmxvY2tzIGFjY2VzcyB0byBHcm9rIG92ZXIgc2V4dWFsaXNlZCBpbWFnZXM8L2E-PC90ZD4NCiAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgPC90YWJsZT48L3RkPg0KICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICA8dGQgYWxpZ249ImNlbnRlciIgY29sc3Bhbj0iMiIgc3R5bGU9IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb2xvcjogIzI4MmIyZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFyZ2luOiAwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9udC13ZWlnaHQ6IDQwMDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9udC1zaXplOiAxNHB4OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZXh0LWFsaWduOiBsZWZ0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaW5lLWhlaWdodDogMjBweDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFkZGluZzogNXB4IDAgMjBweDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiPg0KICAgICAgICAgICAgICAgPHRhYmxlIGNsYXNzPSJhaW5ld3NCb3giIHN0eWxlPSJ3aWR0aDogNjAwcHg7IGJvcmRlcjogMnB4IHNvbGlkICNmZmU5ZTI7IGJvcmRlci1yYWRpdXM6IDEwcHg7IHBhZGRpbmc6IDI1cHggNTVweDsiPg0KICAgICAgICAgICAgICAgIDx0Ym9keT4NCiAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgPHRkPg0KICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgZm9udC13ZWlnaHQ6IDYwMDsgZm9udC1zaXplOiAyMnB4OyBsaW5lLWhlaWdodDogMTIxJTsgdmVydGljYWwtYWxpZ246IG1pZGRsZTsgbWFyZ2luOiAwIDAgMjBweCAhaW1wb3J0YW50OyIgY2xhc3M9InN0b3J5X3RpdGxlIj48c3BhbiBzdHlsZT0idmVydGljYWwtYWxpZ246IG1pZGRsZTsgbWFyZ2luLXJpZ2h0OiA4cHg7Ij48aW1nIHN0eWxlPSJ3aWR0aDogMjVweDtoZWlnaHQ6IDI1cHg7bWF4LXdpZHRoOjI1cHg7IGhlaWdodDphdXRvOyIgYWx0PSIiIHNyYz0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3Bob3RvLzEyMDM0MzY0NC5jbXMiIGNsYXNzPSJ0aXRsZV9pbWciPjwvc3Bhbj4gQXJvdW5kIHRoZSB3ZWI8L3A-DQogICAgICAgICAgICAgICAgICAgPHVsIHN0eWxlPSIgbWFyZ2luOiAwOyBwYWRkaW5nOiAwOyBwYWRkaW5nLWxlZnQ6IDIwcHg7Ij4NCiAgICAgICAgICAgICAgICAgICAgPGxpIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IG1hcmdpbi1ib3R0b206IDEwcHg7IiBjbGFzcz0iYXJvdW5kX3RoZV93ZWIiPk9wZW5BSSBpcyByZXBvcnRlZGx5IGFza2luZyBjb250cmFjdG9ycyB0byB1cGxvYWQgcmVhbCB3b3JrIGZyb20gcGFzdCBqb2JzPC9saT4NCiAgICAgICAgICAgICAgICAgICAgPGxpIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IG1hcmdpbi1ib3R0b206IDEwcHg7IiBjbGFzcz0iYXJvdW5kX3RoZV93ZWIiPkluZG9uZXNpYSBibG9ja3MgR3JvayBvdmVyIG5vbi1jb25zZW5zdWFsLCBzZXh1YWxpemVkIGRlZXBmYWtlczwvbGk-DQogICAgICAgICAgICAgICAgICAgIDxsaSBzdHlsZT0iZm9udC1zaXplOiAxNHB4OyBtYXJnaW4tYm90dG9tOiAxMHB4OyIgY2xhc3M9ImFyb3VuZF90aGVfd2ViIj5DRVMgMjAyNjogRXZlcnl0aGluZyByZXZlYWxlZCwgZnJvbSBOdmlkaWHigJlzIGRlYnV0cyB0byBBTUTigJlzIG5ldyBjaGlwcyB0byBSYXplcuKAmXMgQUkgb2RkaXRpZXMmbmJzcDs8L2xpPg0KICAgICAgICAgICAgICAgICAgICA8bGkgc3R5bGU9ImZvbnQtc2l6ZTogMTRweDsgbWFyZ2luLWJvdHRvbTogMTBweDsiIGNsYXNzPSJhcm91bmRfdGhlX3dlYiI-4oCYUGh5c2ljYWwgQUnigJkgSXMgQ29taW5nIGZvciBZb3VyIENhcjwvbGk-DQogICAgICAgICAgICAgICAgICAgIDxsaSBzdHlsZT0iZm9udC1zaXplOiAxNHB4OyBtYXJnaW4tYm90dG9tOiAxMHB4OyIgY2xhc3M9ImFyb3VuZF90aGVfd2ViIj5BSSBEZXZpY2VzIEFyZSBDb21pbmcuIFdpbGwgWW91ciBGYXZvcml0ZSBBcHBzIEJlIEFsb25nIGZvciB0aGUgUmlkZT88L2xpPg0KICAgICAgICAgICAgICAgICAgICA8bGkgc3R5bGU9ImZvbnQtc2l6ZTogMTRweDsgbWFyZ2luLWJvdHRvbTogMTBweDsiIGNsYXNzPSJhcm91bmRfdGhlX3dlYiI-UGVvcGxlIEFyZSBVc2luZyBBSSB0byBGYWxzZWx5IElkZW50aWZ5IHRoZSBGZWRlcmFsIEFnZW50IFdobyBTaG90IFJlbmVlIEdvb2Q8L2xpPg0KICAgICAgICAgICAgICAgICAgIDwvdWw-PC90ZD4NCiAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgPC90YWJsZT48L3RkPg0KICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICA8L3RhYmxlPjwvdGQ-DQogICAgICAgICA8L3RyPg0KICAgICAgICAgPHRyPg0KICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBjb2xzcGFuPSIyIj4NCiAgICAgICAgICAgPHRhYmxlIHN0eWxlPSJ3aWR0aDogNjAwcHg7IGJvcmRlcjogMnB4IHNvbGlkICNmZmU5ZTI7IGJvcmRlci1yYWRpdXM6IDEwcHg7Ij4NCiAgICAgICAgICAgIDx0Ym9keT4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZCBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyOyBwYWRkaW5nOiAyN3B4IDAgMTNweCAwOyI-DQogICAgICAgICAgICAgICA8aDQgc3R5bGU9ImZvbnQtZmFtaWx5OiAnVGltZXMgTmV3IFJvbWFuJywgVGltZXMsIHNlcmlmOyBmb250LXdlaWdodDogNTAwOyBmb250LXNpemU6IDIwcHg7IGxpbmUtaGVpZ2h0OiAzMHB4OyBtYXJnaW46IDA7IHBhZGRpbmc6IDA7Ij5Ib3cgd291bGQgeW91IHJhdGUgdG9kYXkncyBOZXdzbGV0dGVyPzwvaDQ-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkPg0KICAgICAgICAgICAgICAgPHRhYmxlIHN0eWxlPSJtYXJnaW46IGF1dG87IHBhZGRpbmctYm90dG9tOiAxOHB4OyI-DQogICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9InRleHQtYWxpZ246IGNlbnRlcjsgcGFkZGluZy10b3A6IDEwcHg7IHBhZGRpbmctcmlnaHQ6IDE1cHg7Ij48YSB0aXRsZT0iTG92ZSBpdCEhIiB0YXJnZXQ9Il9ibGFuayIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogIzAwMDsgZm9udC13ZWlnaHQ6IGJvbGQ7IiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZDkwIj48aW1nIHNyYz0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3Bob3RvLzEyMDM0MzYzMi5jbXMiIHN0eWxlPSJ3aWR0aDogNzBweDsgZGlzcGxheTogYmxvY2s7IG1hcmdpbjogYXV0bzsgcGFkZGluZy1ib3R0b206IDVweDsiIGFsdD0ibG92ZSBpdCI-PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiAnVGltZXMgTmV3IFJvbWFuJywgVGltZXMsIHNlcmlmOyBmb250LXdlaWdodDogNTAwOyBmb250LXNpemU6IDE1cHg7IGxpbmUtaGVpZ2h0OiAxMjElOyBsZXR0ZXItc3BhY2luZzogMCU7IHZlcnRpY2FsLWFsaWduOiBtaWRkbGU7Ij5Mb3ZlIGl0ISE8L3NwYW4-PC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgICA8dGQgc3R5bGU9InRleHQtYWxpZ246IGNlbnRlcjsgcGFkZGluZy10b3A6IDEwcHg7IHBhZGRpbmctcmlnaHQ6IDE1cHg7Ij48YSB0aXRsZT0iTWVoaCIgdGFyZ2V0PSJfYmxhbmsiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGZvbnQtc2l6ZTogMTRweDsgY29sb3I6ICMwMDA7IGZvbnQtd2VpZ2h0OiBib2xkOyIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjFiMmMzODc3ZGZlNDkzMTI1ZWQ5MSI-PGltZyBzcmM9Imh0dHBzOi8vZWNvbm9taWN0aW1lcy5pbmRpYXRpbWVzLmNvbS9waG90by8xMjAzNDM2MzcuY21zIiBzdHlsZT0id2lkdGg6IDcwcHg7IGRpc3BsYXk6IGJsb2NrOyBtYXJnaW46IGF1dG87IHBhZGRpbmctYm90dG9tOiA1cHg7IiBhbHQ9ImxvdmUgaXQiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogJ1RpbWVzIE5ldyBSb21hbicsIFRpbWVzLCBzZXJpZjsgZm9udC13ZWlnaHQ6IDUwMDsgZm9udC1zaXplOiAxNXB4OyBsaW5lLWhlaWdodDogMTIxJTsgbGV0dGVyLXNwYWNpbmc6IDAlOyB2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOyI-TWVoaDwvc3Bhbj48L2E-PC90ZD4NCiAgICAgICAgICAgICAgICAgIDx0ZCBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyOyBwYWRkaW5nLXRvcDogMTBweDsgcGFkZGluZy1yaWdodDogMTVweDsiPjxhIHRpdGxlPSJIYXRlIGl0IiB0YXJnZXQ9Il9ibGFuayIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogIzAwMDsgZm9udC13ZWlnaHQ6IGJvbGQ7IiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZDkzIj48aW1nIHNyYz0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3Bob3RvLzEyMDM0MzY0MS5jbXMiIHN0eWxlPSJ3aWR0aDogNzBweDsgZGlzcGxheTogYmxvY2s7IG1hcmdpbjogYXV0bzsgcGFkZGluZy1ib3R0b206IDVweDsiIGFsdD0ibG92ZSBpdCI-PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiAnVGltZXMgTmV3IFJvbWFuJywgVGltZXMsIHNlcmlmOyBmb250LXdlaWdodDogNTAwOyBmb250LXNpemU6IDE1cHg7IGxpbmUtaGVpZ2h0OiAxMjElOyBsZXR0ZXItc3BhY2luZzogMCU7IHZlcnRpY2FsLWFsaWduOiBtaWRkbGU7Ij5IYXRlIGl0PC9zcGFuPjwvYT48L3RkPg0KICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICA8L3RhYmxlPjwvdGQ-DQogICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgICAgIDwvdHI-DQogICAgICAgICA8dHI-DQogICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJwYWRkaW5nLXRvcDogMHB4OyI-DQogICAgICAgICAgIDx0YWJsZSByb2xlPSJwcmVzZW50YXRpb24iIHdpZHRoPSI2MDAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0iYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgYmFja2dyb3VuZDogIzAwMDsgY29sb3I6ICNmZmY7IGJvcmRlci1yYWRpdXM6IDBweCAwcHggNXB4IDVweDsgZm9udC1mYW1pbHk6ICdUaW1lcyBOZXcgUm9tYW4nLCBUaW1lcywgc2VyaWY7d2lkdGg6IDYwMHB4OyI-DQogICAgICAgICAgICA8dGJvZHk-DQogICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICA8dGQgYWxpZ249ImNlbnRlciIgc3R5bGU9InBhZGRpbmc6IDIwcHg7Ij4NCiAgICAgICAgICAgICAgIDxwIHN0eWxlPSJtYXJnaW46IDEwcHg7IGZvbnQtc2l6ZTogMThweDsgZm9udC13ZWlnaHQ6IGJvbGQ7Ij5SZWFkIHlvdXIgZGFpbHkgbmV3cyBmcm9tIGFueXdoZXJlLjwvcD4NCiAgICAgICAgICAgICAgIDx0YWJsZSByb2xlPSJwcmVzZW50YXRpb24iIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0iYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsiPg0KICAgICAgICAgICAgICAgIDx0Ym9keT4NCiAgICAgICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJwYWRkaW5nLXJpZ2h0OiAxMHB4OyI-PGEgc3R5bGU9InRleHQtZGVjb3JhdGlvbjpub25lOyIgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkOTUiPjxpbWcgc3JjPSJodHRwczovL2ltZy5ldGltZy5jb20vcGhvdG8vMTE5NDU5Mjk1LmNtcyIgYWx0PSJBcHAgU3RvcmUiIHN0eWxlPSJib3JkZXI6IDA7IG1heC13aWR0aDogMTIwcHg7IHdpZHRoOiAxMDAlOyBoZWlnaHQ6IGF1dG87Ij48L2E-PC90ZD4NCiAgICAgICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIj48YSBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOm5vbmU7IiB0YXJnZXQ9Il9ibGFuayIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjFiMmMzODc3ZGZlNDkzMTI1ZWQ5NyI-PGltZyBzcmM9Imh0dHBzOi8vaW1nLmV0aW1nLmNvbS9waG90by8xMTk0NTkyOTQuY21zIiBhbHQ9Ikdvb2dsZSBQbGF5IiBzdHlsZT0iYm9yZGVyOiAwOyBtYXgtd2lkdGg6IDEyMHB4OyB3aWR0aDogMTAwJTsgaGVpZ2h0OiBhdXRvOyI-PC9hPjwvdGQ-DQogICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxLjU7Ij4NCiAgICAgICAgICAgICAgIDxwIHN0eWxlPSJtYXJnaW46IDA7Ij48c3Ryb25nPlRoYW5rcyBmb3IgcmVhZGluZy48L3N0cm9uZz4gV2UnbGwgYmUgYmFjayB0b21vcnJvdyB3aXRoIG1vcmUgaW50ZXJlc3Rpbmcgc3RvcmllcyBhbmQgdXBkYXRlcy48YnI-DQogICAgICAgICAgICAgICAgIEZvbGxvdyB1cyBvbiA8YSBzdHlsZT0iY29sb3I6IzExNTVDQzsgdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsiIHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZDk4Ij5Ud2l0dGVyPC9hPiwgPGEgc3R5bGU9ImNvbG9yOiMxMTU1Q0M7IHRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7IiB0YXJnZXQ9Il9ibGFuayIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjFiMmMzODc3ZGZlNDkzMTI1ZWQ5OSI-RmFjZWJvb2s8L2E-LCA8YSBzdHlsZT0iY29sb3I6IzExNTVDQzsgdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsiIHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZDlhIj5Zb3VUdWJlPC9hPiwgYW5kIDxhIHN0eWxlPSJjb2xvcjojMTE1NUNDOyB0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOyIgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkOWMiPkxpbmtlZEluPC9hPi48L3A-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJwYWRkaW5nOiAxNXB4OyI-DQogICAgICAgICAgICAgICA8cCBzdHlsZT0ibWFyZ2luOiAwOyBmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxLjQ7Ij5Ccm91Z2h0IHRvIHlvdSBieTwvcD48L3RkPg0KICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgPHRyPg0KICAgICAgICAgICAgICA8dGQgYWxpZ249ImNlbnRlciIgc3R5bGU9InBhZGRpbmctYm90dG9tOiAyMHB4OyI-PGltZyB3aWR0aD0iMjIwIiBoZWlnaHQ9IjI1IiBzcmM9Imh0dHBzOi8vaW1nLmV0aW1nLmNvbS9waG90by8xMTk0NTkyODguY21zIiBzdHlsZT0ibWFyZ2luOiAwOyBwYWRkaW5nOiAwOyBib3JkZXI6IDA7IiBhbHQ9IkVUIExvZ28iPjwvdGQ-DQogICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgIDx0ZCBhbGlnbj0iY2VudGVyIiBzdHlsZT0icGFkZGluZzogMjBweCAwIDVweCAwOyBmb250LXNpemU6IDEycHg7IGxpbmUtaGVpZ2h0OiAxLjU7IGJhY2tncm91bmQ6ICNmZmY7IGNvbG9yOiAjMDAwOyI-VG8gZW5zdXJlIGRlbGl2ZXJ5IGRpcmVjdGx5IHRvIHlvdXIgaW5ib3gsIHBsZWFzZSBhZGQgPGEgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkOWYiIHN0eWxlPSJjb2xvcjogIzAyNGU5NzsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyI-IG5ld3NsZXR0ZXJAZWNvbm9taWN0aW1lc25ld3MuY29tIDwvYT4gdG8geW91ciBhZGRyZXNzIGJvb2sgdG9kYXkuIElmIHlvdSBhcmUgaGF2aW5nIHRyb3VibGUgdmlld2luZyB0aGlzIG5ld3NsZXR0ZXIsIHBsZWFzZSA8YSB0YXJnZXQ9Il9ibGFuayIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjFiMmMzODc3ZGZlNDkzMTI1ZWRhMCIgc3R5bGU9ImNvbG9yOiAjMDI0ZTk3OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7Ij4gY2xpY2sgaGVyZSA8L2E-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJwYWRkaW5nOiA1cHg7IGZvbnQtc2l6ZTogMTJweDsgbGluZS1oZWlnaHQ6IDEuNTsgYmFja2dyb3VuZDogI2ZmZjsgY29sb3I6ICMwMDA7Ij5UbyB1bnN1YnNjcmliZSBvciBlZGl0IHlvdXIgc3Vic2NyaXB0aW9ucyBwbGVhc2UgPGEgdGFyZ2V0PSJfYmxhbmsiIHN0eWxlPSJjb2xvcjogIzAyNGU5NzsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyIgaHJlZj0iaHR0cHM6Ly9lY29ub21pY3RpbWVzLmluZGlhdGltZXMuY29tL3N1YnNjcmlwdGlvbi5jbXM_cHJvY2Vzcz0xP3V0bV9zb3VyY2U9bmV3c2xldHRlciZhbXA7dXRtX21lZGl1bT1lbWFpbCZhbXA7dXRtX2NhbXBhaWduPWFpX25ld3NsZXR0ZXImYW1wO3V0bV9jb250ZW50PXVuc3Vic2NyaWJlJmFtcDtrZXk9ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO25hdXRoPTI3YTQ3NDBlZGZkZTJjMzljMDcyZDg1YmU2ZmY0NWFmNDEwMThhNTI1Nzg2Yzc0ZWE5OTgxZTJmMjZiNmFjMGJlMjEzMTM5NDAxZDIzYmEwZjdlYmE3YWFkMGNmNzkyMzZmOTBkYzdjOTdiNGU5ZGU1OGZkNTMzNWU0N2VkMjljNTliOTY4NDRmNzg4MzIwOWRhNWE4NzRlZmNlN2ZjNjllYTFmOWQ4OWY5YTJlYzE2JmFtcDtzaWQ9NjdkZDk1MDJmM2M1ZTNhODUyZmI4ZGEyIj4gY2xpY2sgaGVyZSA8L2E-PC90ZD4NCiAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJwYWRkaW5nOiAyMHB4OyBmb250LXNpemU6IDEycHg7IGxpbmUtaGVpZ2h0OiAxLjU7IGJhY2tncm91bmQ6ICNmZmY7Ij4NCiAgICAgICAgICAgICAgIDxwIHN0eWxlPSJtYXJnaW46IDA7IGNvbG9yOiAjMDAwOyI-wqkgMjAyNSA8c3BhbiBjbGFzcz0iaWwiPlRpbWVzPC9zcGFuPiBJbnRlcm5ldCBMaW1pdGVkPC9wPg0KICAgICAgICAgICAgICAgPHAgc3R5bGU9Im1hcmdpbjogNXB4IDAgMCAwOyBjb2xvcjogI2ZmZjsiPjxhIHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZGExIiBzdHlsZT0iZm9udC1zaXplOiAxMnB4OyBjb2xvcjogIzAyNGU5NzsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7Ij4gQWJvdXQgdXMgPC9hPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHg7IG1hcmdpbjogMCAycHg7IHBhZGRpbmc6IDAgM3B4OyI-fDwvc3Bhbj48YSB0YXJnZXQ9Il9ibGFuayIgaHJlZj0iaHR0cHM6Ly9ubHRyYWNrLmluZGlhdGltZXMuY29tL3RyYWNraW5nL3RyYWNrL2NsP3BhcmFtPWQzOWRmODYwYTUzNzBlMDlkY2I5MjY5ZjQ4Zjk4NTYyNGE1NDEwYWMzNDZmZWExNTA5MjgyNTg0YmY0YzkzNzI0NGUxMDY4MWE0MWFhMWQyMGQ1NjU4MjUzODFmZDIzZGYzOTQ2MjlhMzg0NmU3NzZjNWY3NWNjNDY5YzM5MDhkZDAxNzc2Y2JhN2FiNmU5NWQ4YTFmNjVkYjRiNzgzZWMxYmU3N2M1NWJjMTBmYWNjJmFtcDtvPTY5NjFiMmMzODc3ZGZlNDkzMTI1ZWRhMSIgc3R5bGU9ImZvbnQtc2l6ZTogMTJweDsgY29sb3I6ICMwMjRlOTc7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgZGlzcGxheTogaW5saW5lLWJsb2NrOyI-IEFkdmVydGlzZSB3aXRoIHVzIDwvYT48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB4OyBtYXJnaW46IDAgMnB4OyBwYWRkaW5nOiAwIDNweDsiPnw8L3NwYW4-PGEgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vbmx0cmFjay5pbmRpYXRpbWVzLmNvbS90cmFja2luZy90cmFjay9jbD9wYXJhbT1kMzlkZjg2MGE1MzcwZTA5ZGNiOTI2OWY0OGY5ODU2MjRhNTQxMGFjMzQ2ZmVhMTUwOTI4MjU4NGJmNGM5MzcyNDRlMTA2ODFhNDFhYTFkMjBkNTY1ODI1MzgxZmQyM2RmMzk0NjI5YTM4NDZlNzc2YzVmNzVjYzQ2OWMzOTA4ZGQwMTc3NmNiYTdhYjZlOTVkOGExZjY1ZGI0Yjc4M2VjMWJlNzdjNTViYzEwZmFjYyZhbXA7bz02OTYxYjJjMzg3N2RmZTQ5MzEyNWVkYTEiIHN0eWxlPSJmb250LXNpemU6IDEycHg7IGNvbG9yOiAjMDI0ZTk3OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGRpc3BsYXk6IGlubGluZS1ibG9jazsiPiBGZWVkYmFjayA8L2E-PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFweDsgbWFyZ2luOiAwIDJweDsgcGFkZGluZzogMCAzcHg7Ij58PC9zcGFuPjxhIHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZGExIiBzdHlsZT0iZm9udC1zaXplOiAxMnB4OyBjb2xvcjogIzAyNGU5NzsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7Ij4gU2l0ZW1hcCA8L2E-PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFweDsgbWFyZ2luOiAwIDJweDsgcGFkZGluZzogMCAzcHg7Ij58PC9zcGFuPjxhIHRhcmdldD0iX2JsYW5rIiBocmVmPSJodHRwczovL25sdHJhY2suaW5kaWF0aW1lcy5jb20vdHJhY2tpbmcvdHJhY2svY2w_cGFyYW09ZDM5ZGY4NjBhNTM3MGUwOWRjYjkyNjlmNDhmOTg1NjI0YTU0MTBhYzM0NmZlYTE1MDkyODI1ODRiZjRjOTM3MjQ0ZTEwNjgxYTQxYWExZDIwZDU2NTgyNTM4MWZkMjNkZjM5NDYyOWEzODQ2ZTc3NmM1Zjc1Y2M0NjljMzkwOGRkMDE3NzZjYmE3YWI2ZTk1ZDhhMWY2NWRiNGI3ODNlYzFiZTc3YzU1YmMxMGZhY2MmYW1wO289Njk2MWIyYzM4NzdkZmU0OTMxMjVlZGExIiBzdHlsZT0iZm9udC1zaXplOiAxMnB4OyBjb2xvcjogIzAyNGU5NzsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7Ij4gQ29kZSBvZiBFdGhpY3MgPC9hPjwvcD48L3RkPg0KICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICA8L3RhYmxlPjwvdGQ-DQogICAgICAgICA8L3RyPg0KICAgICAgICA8L3Rib2R5Pg0KICAgICAgIDwvdGFibGU-PC90ZD4NCiAgICAgPC90cj4NCiAgICA8L3Rib2R5Pg0KICAgPC90YWJsZT4NCiAgPC9kaXY-DQogPC9ib2R5Pg0KPC9odG1sPg=="}}]}]},"sizeEstimate":57257,"historyId":"2853939","internalDate":"1768098015000"}', '2026-01-11T04:56:23.465Z', '19baae07831c9861', '19baae07831c9861', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('b491bf7a566e68a33ad34b9ae555ebe5', '101f04af63cbefc2bf8f0a98b9ae1205', 'Seller Notification <seller-notification@amazon.in>', 'Sold, ship now: 4G-U5TN-DLHL Digital Pocket Weighing Scale - 0.01g High Precision Gold & Jewellery Weight Machine | Portable Gram Scale with Stainless Steel Platform & LCD Display - Gripit GOLD Scale', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        

<!--[if gte mso 15]>
<xml>
	<o:OfficeDocumentSettings>
	<o:AllowPNG/>
	<o:PixelsPerInch>96</o:PixelsPerInch>
	</o:OfficeDocumentSettings>
</xml>
<![endif]-->
<meta charset="UTF-8">
<!--[if !mso]><!-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--<![endif]-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="http://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet" type="text/css">
<style type="text/css">
	
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 300;
    src: local(''Amazon Ember Light''), local(''AmazonEmber-Light''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 300;
    src: local(''Amazon Ember Light Italic''), local(''AmazonEmber-LightItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 400;
    src: local(''Amazon Ember''), local(''AmazonEmber''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 400;
    src: local(''Amazon Ember Italic''), local(''AmazonEmber-Italic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 600;
    src: local(''Amazon Ember Medium''), local(''AmazonEmber-Medium''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 600;
    src: local(''Amazon Ember Medium Italic''), local(''AmazonEmber-MediumItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 700;
    src: local(''Amazon Ember Bold''), local(''AmazonEmber-Bold''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 700;
    src: local(''Amazon Ember Bold Italic''), local(''AmazonEmber-BoldItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff) format(''woff'');
}



	.nbus-survey{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:visited{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:hover{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:focus{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:active{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	
	one-column{border-spacing:0px;background-color:#FFFFFF;border:0px;padding:0px;width:100%;column-count:1;}
	endrImageBlock{padding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrImageBlockInner{padding:0px;}
	endrImageContentContainer{adding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrTextContentContainer{min-width:100%;width:100%;border-collapse:collapse;background-color:#FFFFFF;border:0px;padding:0px;border-spacing:0px;}
	endrTextBlock{min-width:100%;border-collapse:collapse;background-color:#ffffff;width:100%padding:0px;border-spacing:0px;border:0px;}
	preview-text{display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';}
	
	p{
	text-align: left;
	margin-top:10px;
	margin-bottom:10px;
	margin-right:0;
	margin-left:0;
	padding-top:0;
	padding-bottom:0;
	padding-right:0;
	padding-left:0;
	line-height:185%;
	}
	table{
	border-collapse:collapse;
	}
	h1,h2,h3,h4,h5,h6{
	display:block;
	margin:0;
	padding:0;
	}
	img,a img{
	border:0;
	height:auto;
	outline:none;
	text-decoration:none;
	}
	pre{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	font-family:''Amazon Ember'';
	min-width:100%;
	white-space: pre-wrap;       /* Since CSS 2.1 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
	}
	body,#bodyTable,#bodyCell{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	background-color:#e4e3e4;
	color:#999999
	font-family:''Amazon Ember'';
	min-width:100%;
	}
	#outlook a{
	padding:0;
	}
	img{
	-ms-interpolation-mode:bicubic;
	}
	table{
	mso-table-lspace:0pt;
	mso-table-rspace:0pt;
	}
	.ReadMsgBody{
	width:100%;
	}
	.ExternalClass{
	width:100%;
	}
	p,a,li,td,blockquote{
	mso-line-height-rule:exactly;
	}
	a[href^=tel],a[href^=sms]{
	color:inherit;
	cursor:default;
	text-decoration:none;
	}
	p,a,li,td,body,table,blockquote{
	-ms-text-size-adjust:100%;
	-webkit-text-size-adjust:100%;
	}
	.ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{
	line-height:100%;
	}
	a[x-apple-data-detectors]{
	color:inherit !important;
	text-decoration:none !important;
	font-size:inherit !important;
	font-family:inherit !important;
	font-weight:inherit !important;
	line-height:inherit !important;
	}
	.templateContainer{
	max-width:600px !important;
	}
	.endrImage{
	vertical-align:bottom;
	}
	.endrTextContent{
	word-break:break-word;
	padding-top:15px;
	padding-bottom:10px;
	padding-right:18px;
	padding-left:18px;
	text-align: left;
	}
	.endrTextContent img{
	height:auto !important;
	}
	.endrDividerBlock{
	table-layout:fixed !important;
	}
	body { margin:0 !important; }
	div[style*="margin: 16px 0"] { margin:0 !important; }

	body,#bodyTable{
	background-color:#e4e3e4;
	color:#999999;
	font-family: ''Amazon Ember'';
	}
	
	.templateBlocks{
	background-color:#FFFFFF;
	border-top-width:0;
	border-bottom-width:0;
	padding-top:0;
	padding-bottom:0;
	font-size:15px;
	line-height:185%;
	text-align:left;
	background-color:#FFFFFF;
	}
	
	.templateQuoteBlocks{
	background-color:#F04D44;
	}
	
	#bodyCell{
	border-top:0;
	}

	h1{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:30px;
	font-style:normal;
	font-weight:normal;
	line-height:120%;
	letter-spacing:normal;
	padding-top:2px;
	padding-bottom:2px;
	}

	a{
	color:#e74c3c;
	font-weight:normal;
	text-decoration:underline;
	}

	h2{
	color:#848484;
	font-family: ''Amazon Ember'';
	font-size:15px;
	font-style:normal;
	font-weight:normal;
	line-height:145%;
	letter-spacing:1px;
	padding-top:5px;
	padding-bottom:4px;
	}

	h3{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:140%;
	letter-spacing:normal;
	text-align:left;
	padding-top:2px;
	padding-bottom:2px;
	}

	h4{
	color:#666666;
	font-family: ''Amazon Ember'';
	font-size:16px;
	font-style:normal;
	font-weight:normal;
	line-height:125%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-bottom:4px;
	}

	h5{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	h6{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:26px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:right;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	#templatePreheader{
	border-top:0;
	border-bottom:0;
	padding-top:4px;
	padding-bottom:12px;
	}

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templatePreheader .endrTextContent a,#templatePreheader .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}

	#templateHeader{
	background-color:#303942;
	border-top:0px solid #e4e3e4;
	border-bottom:0;
	padding-top:0px;
	padding-bottom:0px;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent h1{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent a,#templateHeader .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:none;
	}

	#templateSeparator{
	padding-top:8px;
	padding-bottom:8px;
	}

	.templateLowerBody{
	background-color:#455C64;
	border-bottom:0;
	padding-top:1px;
	padding-bottom:1px;
	}

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:150%;
	text-align:left;
	}

	.templateLowerBody .endrTextContent a,.templateLowerBody .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:underline;
	}

	.templateLowerBody .endrTextContent h1 {
	color:#ffffff;
	font-weight:700;
	font-size:18px;
	}

	.templateSocial{
	background-color:#e4e3e4;
	padding-top:13px;
	padding-bottom:3px;
	}

	#templateFooter{
	border-top:0;
	border-bottom:0;
	padding-top:5px;
	padding-bottom:5px;
	}

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templateFooter .endrTextContent a,#templateFooter .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}
	
	@media only screen and (min-width:768px){
	.templateContainer{
	width:600px !important;
	}
	}	
	
	@media only screen and (max-width: 480px){
	
	.templateHeader{
		display: none;
	}
		
	.bigimage .endrImageContent{
	padding-top:0px !important;

	}
	.templateContainer{
	width:100% !important;
	max-width:600px;
	}	@media only screen and (max-width: 480px){
	body,table,td,p,a,li,blockquote{
	-webkit-text-size-adjust:none !important;
	}
	}	@media only screen and (max-width: 480px){
	body{
	width:100% !important;
	min-width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	#bodyCell{
	padding-top:10px !important;
	}
	}	@media only screen and (max-width: 480px){
	.columnWrapper{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImage{
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionTopContent,.endrCaptionBottomContent,.endrTextContentContainer,.endrBoxedTextContentContainer,.endrImageGroupContentContainer,.endrCaptionLeftTextContentContainer,.endrCaptionRightTextContentContainer,.endrCaptionLeftImageContentContainer,.endrCaptionRightImageContentContainer,.endrImageCardLeftTextContentContainer,.endrImageCardRightTextContentContainer{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrBoxedTextContentContainer{
	min-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.column{
	width:100% !important;
	max-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.endrImageGroupContent{
	padding:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionLeftContentOuter .endrTextContent,.endrCaptionRightContentOuter .endrTextContent{
	padding-top:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardTopImageContent,.endrCaptionBlockInner .endrCaptionTopContent:last-child .endrTextContent{
	padding-top:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardBottomImageContent{
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockInner{
	padding-top:0 !important;
	padding-bottom:0 !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockOuter{
	padding-top:9px !important;
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrTextContent,.endrBoxedTextContentColumn{
	padding-right:18px !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardLeftImageContent,.endrImageCardRightImageContent{
	padding-right:18px !important;
	padding-bottom:0 !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.mcpreview-image-uploader{
	display:none !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){

	h1{
	font-size:22px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h2{
	font-size:20px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h3{
	font-size:18px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h4{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){
	
	.endrBoxedTextContentContainer .endrTextContent,.endrBoxedTextContentContainer .endrTextContent p{
	font-size:14px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader{
	display:block !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	font-size:16px !important;
	line-height:100% !important;
	text-align:center !important;
	}

	#templateHeader .endrTextContent, #templateHeader .endrTextContent h1{
	font-size:20px !important;
	line-height:100% !important;
	padding-bottom:10px !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateUpperBody .endrTextContent,#templateUpperBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	
	}	@media only screen and (max-width: 480px){

	#templateColumns .columnContainer .endrTextContent,#templateColumns .columnContainer .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	text-align:center !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}
</style>

<!--[if mso]>
<style type="text/css">
body, table, td {font-family: ''Amazon Ember'';}
h1 {font-family: ''Amazon Ember'';}
h2 {font-family: ''Amazon Ember'';}
h3 {font-family: ''Amazon Ember'';}
h4 {font-family: ''Amazon Ember'';}
h5 {font-family: ''Amazon Ember'';}
h6 {font-family: ''Amazon Ember'';}
h7 {font-family: ''Amazon Ember'';}
p {font-family: ''Amazon Ember'';}
</style>
<![endif]-->

<!--[if gt mso 15]>
<style type="text/css" media="all">
/* Outlook 2016 Height Fix */
table, tr, td {border-collapse: collapse;}
tr {border-collapse: collapse; }
body {background-color:#ffffff;}
</style>
<![endif]-->    </head>

    <body>
        <center class="wrapper" style="width:100%;table-layout:fixed;background-color:#e4e3e4;">
  <div class="webkit" style="max-width:600px;margin:0 auto;">
      <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable" style="border-collapse:collapse;height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;width:100%;background-color:#e4e3e4;color:#5a5a5a;font-family:''Lato'', Helvetica, Arial, sans-serif;">
        <tbody><tr>
            <td align="center" valign="top" id="bodyCell" style="height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;width:100%;padding-top:10px;padding-bottom:10px;border-top-width:0;">
<!-- BEGIN TEMPLATE // -->
<!--[if (gte mso 9)|(IE)]>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;border-collapse:collapse;" >
	<tr>
	<td align="center" valign="top" width="600" style="width:600px;" >
		<![endif]-->
		<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-header>
		<tbody><tr>
		<td>
        <div style="display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';">
            Ship by: 13/01/2026, Standard Shipping
        </div>

        <!-- BLOCK Logo Center -->
 <table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" data-space-sc-header>
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
          <td class="templateHeader" valign="top" style="padding: 20px 0; padding-left:40px">
          <img align="center" alt="" src="https://m.media-amazon.com/images/G/01/SPACE/logo-selling_coach.png" width="200" style="max-width:200px;padding-bottom:0;display:inline !important;vertical-align:bottom;border-width:0;height:auto;outline-style:none;text-decoration:none;-ms-interpolation-mode:bicubic;">
          </td>
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
<!-- ENDR Header  -->


</td>
</tr>
</tbody></table>

<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;background-color:#ffffff;" bgcolor="#ffffff">
<tbody><tr>
<td>
        <table class="one-column">
            <tbody><tr valign="top" class="templateBlocks">
                <td valign="top">
                    <table class="endrTextBlock">
                        <tbody class="endrTextBlockOuter">
                            <tr>
                                <td valign="top" class="endrTextBlockInner">
                                    <table align="left" class="endrTextContentContainer">
                                        <tbody>
                                            <tr>
                                                <td valign="top" class="endrTextContent" align="center">
                                                    <p style="text-align:left;margin-top:10px;margin-bottom:10px;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;line-height:185%;">
                                                        











            </p><div style="text-align:left">
                            
    
    
    <p>Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 13/01/2026.</p>

                            
                    <p>Please review your order:</p>
    
                <center>
                    <div style="margin: 20px 0px 20px 10px; padding:10px; display:inline-block; background-color:#006574;">
    <a style="color:#fff; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/ff52e68a-e815-3291-bc04-132b3c4ac548?nt=SOLD_SHIP_NOW&amp;sk=plDQn-c9OtWzZUpSoZeCxz5t5uZWbW-7nEzaHZNibNgA7sFpU3nD52ZbN521cpSVKJhJPb0hB9s_WLRAshceAw&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9vcmRlcnMtdjMvb3JkZXIvNDA0LTc2NzI4MDAtNDQyMTE2OD9yZWZfPXh4X2VtYWlsX2JvZHlfc2hpcA">
        View Order
    </a>
</div>

                            <div style="margin: 20px 0px 20px 20px; padding:10px; display:inline-block; background-color:#e3eced;">
    <a style="color:#002f36; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/c1e815b1-5094-3475-8579-9be022ae89de?nt=SOLD_SHIP_NOW&amp;sk=ZV9xP8xKMuBipn5oQthaztbYLRJF4RPcsI1YfInCNWd0x39ts7gqKoP2ghmF9-9RZMmlaTndy3jrshWjs7iZjg&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9oZWxwL2h1Yi9yZWZlcmVuY2UvRzIwMTM4MzM0MD9yZWZfPXh4X2VtYWlsX2JvZHlfaGVscA">
        Get Help Shipping Your Order
    </a>
</div>
    </center>
    <h3>Order Details</h3>
                                <b>Order ID:</b> 404-7672800-4421168
    <br>
                <b>Order date:</b> 11/01/2026
    <br>
                                        <b>Please ship this order using:</b> Standard Shipping
        <br>
                                        <br>
                                        
                                                    <b>Ship by:</b> 13/01/2026
            <br>
                                        <b>Item:</b> Digital Pocket Weighing Scale - 0.01g High Precision Gold &amp; Jewellery Weight Machine | Portable Gram Scale with Stainless Steel Platform &amp; LCD Display - Gripit GOLD Scale
        <br>
                                                                    <b>Condition:</b> New
                    <br>
                                                                            <b>SKU:</b> 4G-U5TN-DLHL
        <br>
                                <b>Quantity:</b> 1
        <br>
                                            <b>Price:</b> INR 666.10
    <br>
                                                            <b>Tax:</b> INR 119.90
        <br>
                                                                                                                                                                                                                                                                                                                                                                                    <b>Amazon fees:</b> -INR 165.33
    <br>
                                                                                                                                                                                                                    <b>Your earnings:</b> INR 620.67
    <br>
            
    
    
</div>
                                                    <p></p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody></table>


                

					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-footer data-space-sc-footer>
					<tbody><tr>
					<td>
				
					<!-- BLOCK Footer About Us -->
					<table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" dir="auto">
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<center style="margin-top: 20px;">
                        	<a style="padding: 7px 24px; text-decoration: none; background: #fff; border: 1px solid #EC937C; border-radius: 5px; color: #7F1809; font-family: ''Amazon Ember''; font-size: 13px; font-weight: 600;display: inline-block; margin-bottom: 10px" href="https://sellercentral.amazon.in/notifications/feedback?deliveryId=246292221102447&amp;communicationName=SOLD_SHIP_NOW&amp;deliveryChannel=EMAIL">
                    <img src="https://m.media-amazon.com/images/G/01/space/icon.png" style="margin-right: 10px;vertical-align: middle;" width="20" height="20">Report an issue with this email
                  </a>
                        </center><p style="text-align:center !important;margin-top:10px;margin-bottom:10px;margin-right:10px;margin-left:15px;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;color:#ffffff;font-family:''Amazon Ember'';font-size:13px;line-height:150%;">If you have any questions visit: <a href="https://sellercentral.amazon.in/nms/sellermobile/redirect/04b4511b-4a10-3ce8-9d46-a4b902930c5c?nt=SOLD_SHIP_NOW&amp;sk=wta3xpK8Fojlrul2KTJ9uSW59twRclJ0pxpV6eD4PCAWbjrvTCMTz3gmGG1WK5GtgggwN1IMnd4Vx8Xed18ILw&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbg" metric="help" style="text-decoration: none; color: #ffffff;">Seller Central</a><br><br>
											    To change your email preferences visit: <a href="https://sellercentral.amazon.in/nms/redirect/abc9cbdb-0a1f-3ca6-b1af-0242a14dff1b?nt=SOLD_SHIP_NOW&amp;sk=3Wf9kRPYv0vdBeQ6euZGyoWo_u30xEZf08Oenw9bytbZWB0_aKcY1PzyPSW2cgm5QvbkrTxfALXE6NgJmcWVcA&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL3JlZj1pZF9ub3RpZnByZWZfZG5hdl94eF8" metric="optout" style="text-decoration: none; color: #ffffff;">Notification Preferences</a><br><br>
																		We hope you found this message to be useful. However, if you''d rather not receive future e-mails of this sort from Amazon.com, please opt-out <a href="https://sellercentral.amazon.in/nms/redirect/1956c70b-da40-3640-937b-23d19a8442e8?nt=SOLD_SHIP_NOW&amp;sk=aadEz5oBGrvXnPZVuA4HDbOtwnKHvj67R7glo2yr5EOaQK_t4VTkK-yH7ZoH68nU6VmUbg5aIRyThXjnidfcww&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL29wdG91dD9vcHRvdXRJZD0xZWQzN2EzNC01NTEwLTQ1ZjgtYTQwYS00NWFmOGIyMDRkYjQ" metric="optout" style="text-decoration: none; color: #ffffff;">here.</a><br><br>
												Copyright  2026 Amazon, Inc, or its affiliates. All rights reserved.<br> 
												Amazon Seller Services Private Limited, 8th floor, Brigade Gateway, 26/1 Dr. Rajkumar Road, Bangalore 560055 (Karnataka)<br></p><table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
                        
                        
                        
											
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
					<!-- BLOCK Footer About Us -->
					</td>
					</tr>
					</tbody></table>
					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;">
					<tbody><tr>
					<td>
				
					</td>
					</tr>
					</tbody></table>
					<!--[if (gte mso 9)|(IE)]>
				</td>
				</tr>
			</table>
			<![endif]-->
			<!-- // END TEMPLATE -->
			</td>
		</tr>
		</tbody></table>    

</td></tr></tbody></table></div></center><img src="https://sellercentral.amazon.in/nms/img/41695213-f215-3feb-92f1-2ed528f8e2b3?sk=dyklFGTh_EZlmJdbbHJhYe6D1Ef-3QF8KiBE8OZLAKKMvKBtin_kAWHveZD9jtE-LNIYLQB-MlbHP455aFei4Q&amp;n=1">
<div id="spc-watermark">
  <p style="font-size: 10px !important;padding-bottom: 10px !important;display: table !important;margin: 5px auto 10px !important;text-align: center !important;color: #a2a2a2 !important;font-family: ''Amazon Ember'' !important;font-weight: 400 !important;">SPC-EUAmazon-246292221102447</p>
</div></body></html>', '2026-01-11T01:03:47.000Z', '{"id":"19baa94aadcca5ec","threadId":"19ba0d41bdcfc90f","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"Ship by: 13/01/2026, Standard Shipping Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 13/01/2026. Please review your order: View Order Get Help Shipping","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2512813pxc;        Sat, 10 Jan 2026 17:03:48 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IH7Il6BPaTlg5YrdRF/roVZDopMyhHhl3SSflJ30qJnK/zzl9hov3luARde9nIYLdHS8yyL"},{"name":"X-Received","value":"by 2002:a05:6000:26cf:b0:432:59d4:f54a with SMTP id ffacd0b85a97d-432bcfe4b76mr22380177f8f.30.1768093428490;        Sat, 10 Jan 2026 17:03:48 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768093428; cv=none;        d=google.com; s=arc-20240605;        b=SpqX3RPIwKJCuQ1js79L0cxmeIfXks/rB/pR7vupsUMtQLNR1VMlzzZkg+6XmuG388         phe2vOre9tCsioT0NTW9xfe4KHncjfcxCnyfQjbD1iaPdja9r9Ki/7pT25Tx2gcPdlOL         7gWCe2XYo1Ej/N3Gfy859RemV+nPLVgrfCD6iLFWfnbjszg2pMEmvjRsYRFEoVdRSYC2         fbHY1zqk2K8jj9OOHDZMd97nKtBT+dXieBg7/zLwtbj0lnwn8uFlwReIrbOvzcCRWEtM         SQqN+hfLl21TMmNrw3Nv2fuj5EZNKg1vazWvz0aNpa2+7EU2GeZirlJ8XA5yy5o+Xvfp         coBA=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=feedback-id:list-unsubscribe-post:list-unsubscribe:bounces-to         :mime-version:subject:message-id:to:reply-to:from:date         :dkim-signature:dkim-signature;        bh=cH4y9LoO8mcFYNiSGls83zVW1bhEbvIXRxApEJL1tjU=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=cUqgeYPwUEOlL7NLRD39I0HQUcqKsm2l0sfSAzMGW8n2nSNHAjdtLGcset9hNe0Huv         uHpoZyX+JOMawWJ1vXQIHKCPeEXVCQACT5Xb6uRZIXPhbLDsoc2Pwod5E3wJ9r3A0e8E         yFv4tac7+hYeYPIm6lnUgdKqfDJZmbElHtw+rZornVg9K4CDZf3bw25nyqOWWY36ij5l         pvTKl7g9ZqSY2oGs2IJ/TJ08emS2jWuk76VpjFQC34NvtaSl99X2IH5yBt1ocWGv9N8+         z3MhJWpGLm06Q8NT1wmYco3noGSvhj/lA6tIdSsQc8O+lAvhcQkhGpmO+ILd2cKmkWIH         EKgg==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=qm6P6A4s;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=JOpYNOmb;       spf=pass (google.com: domain of 0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com designates 76.223.149.184 as permitted sender) smtp.mailfrom=0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"Return-Path","value":"<0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com>"},{"name":"Received","value":"from c149-184.smtp-out.eu-west-1.amazonses.com (c149-184.smtp-out.eu-west-1.amazonses.com. [76.223.149.184])        by mx.google.com with ESMTPS id ffacd0b85a97d-432bd6193ffsi22414756f8f.414.2026.01.10.17.03.48        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Sat, 10 Jan 2026 17:03:48 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of 0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com designates 76.223.149.184 as permitted sender) client-ip=76.223.149.184;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=qm6P6A4s;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=JOpYNOmb;       spf=pass (google.com: domain of 0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com designates 76.223.149.184 as permitted sender) smtp.mailfrom=0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=oispgif7zht3cwr3nad5jndkl43aztnu; d=amazon.in; t=1768093427; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post; bh=iFdGrMT40fzdJQPcx5krH8vkNxAkLA5CdZTRxayCrRo=; b=qm6P6A4sWhEKLBk0aDrfbd9uxScRmOndtxF8KjeLG3N8ieBNtmAr/xv6VkGQM17c qknVyyU5qe3GDxgo8MvzfT8Efk/9FU3+cfeDsoGHtYITDRNCy4a7iTxrk/3OHilumJZ F3u+6eOdpq3KooKOyBPhWXTCwJ7KcQmm80isx/TSz9lqjNCIUB6qYdHcS/OZIjh50wp CzBcT0JciHHN+PPofC43xX4q5rpgAPd9vPQ688Cd7NTjQnKBLP6QI6jt/OPW3WhJfp1 MgsmbEGPev1x5zpyfgRuu8VnI6tkl69cazx5E0ByXeNOwRFiHFWcDf7wqQCGWnFESqq IPfunYN4Cw=="},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768093427; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post:Feedback-ID; bh=iFdGrMT40fzdJQPcx5krH8vkNxAkLA5CdZTRxayCrRo=; b=JOpYNOmbZz9uLmTYI3vX6JYkf+htdMCg69KXkh5MHm9ANrmFpG2sLGK7p8Jmyi/P /cf9cUMhQcjNTqt6OzR0FUWb98r5/+bM66kFJY5KTqX017OFkQevUZOSo7pUWz8FsoD YIU08Z8b9XMJgjOUNl3VvOjoHNuQXk2FKaXjwqL0="},{"name":"Date","value":"Sun, 11 Jan 2026 01:03:47 +0000"},{"name":"From","value":"Seller Notification <seller-notification@amazon.in>"},{"name":"Reply-To","value":"seller-notification@amazon.in"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Message-ID","value":"<0102019baa94a88c-e8a01945-9232-48e4-8766-716f5b0926eb-000000@eu-west-1.amazonses.com>"},{"name":"Subject","value":"Sold, ship now: 4G-U5TN-DLHL Digital Pocket Weighing Scale - 0.01g High Precision Gold & Jewellery Weight Machine | Portable Gram Scale with Stainless Steel Platform & LCD Display - Gripit GOLD Scale"},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/alternative; boundary=\"----=_Part_1524813_2067320981.1768093427844\""},{"name":"Bounces-to","value":"RTE+NE-null-b1cb1A04521873UG9PNAEXWBCS@sellernotifications.amazon.com"},{"name":"X-Space-Message-ID","value":"246292221102447"},{"name":"X-Marketplace-ID","value":"A21TJRUUN4KGV"},{"name":"List-Unsubscribe","value":"<https://sellercentral.amazon.in/notifications/preferences/optout/header-one-click?optoutId=1ed37a34-5510-45f8-a40a-45af8b204db4>"},{"name":"List-Unsubscribe-Post","value":"List-Unsubscribe=One-Click"},{"name":"Feedback-ID","value":"::1.eu-west-1.QXQDwfZxBksRk8Fey1ctk1ELdO+bec9bLwquzardhBQ=:AmazonSES"},{"name":"X-SES-Outgoing","value":"2026.01.11-76.223.149.184"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"7bit"}],"body":{"size":31080,"data":"PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg0KPGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zOnY9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206dm1sIiB4bWxuczpvPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTpvZmZpY2UiPg0KDQogICAgPGhlYWQ-DQogICAgICAgIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4NCiAgICAgICAgDQoNCjwhLS1baWYgZ3RlIG1zbyAxNV0-DQo8eG1sPg0KCTxvOk9mZmljZURvY3VtZW50U2V0dGluZ3M-DQoJPG86QWxsb3dQTkcvPg0KCTxvOlBpeGVsc1BlckluY2g-OTY8L286UGl4ZWxzUGVySW5jaD4NCgk8L286T2ZmaWNlRG9jdW1lbnRTZXR0aW5ncz4NCjwveG1sPg0KPCFbZW5kaWZdLS0-DQo8bWV0YSBjaGFyc2V0PSJVVEYtOCI-DQo8IS0tW2lmICFtc29dPjwhLS0-DQoJCTxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSI-DQoJPCEtLTwhW2VuZGlmXS0tPg0KPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIj4NCjx0aXRsZT48L3RpdGxlPg0KPGxpbmsgaHJlZj0iaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TGF0bzo0MDAsNzAwIiByZWw9InN0eWxlc2hlZXQiIHR5cGU9InRleHQvY3NzIj4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQoJDQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogbm9ybWFsOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0JyksIGxvY2FsKCdBbWF6b25FbWJlci1MaWdodCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9sdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0IEl0YWxpYycpLCBsb2NhbCgnQW1hem9uRW1iZXItTGlnaHRJdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbHRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0aXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXInKSwgbG9jYWwoJ0FtYXpvbkVtYmVyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnX2Jhc2Uud29mZjIpIGZvcm1hdCgnd29mZjInKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBpdGFsaWM7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDYwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgTWVkaXVtJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW0nKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9tZF9iYXNlLndvZmYpIGZvcm1hdCgnd29mZicpOw0KfQ0KQGZvbnQtZmFjZSB7DQogICAgZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KICAgIGZvbnQtc3R5bGU6IGl0YWxpYzsNCiAgICBmb250LXdlaWdodDogNjAwOw0KICAgIHNyYzogbG9jYWwoJ0FtYXpvbiBFbWJlciBNZWRpdW0gSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX21kaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDcwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgQm9sZCcpLCBsb2NhbCgnQW1hem9uRW1iZXItQm9sZCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkX2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiA3MDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIEJvbGQgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1Cb2xkSXRhbGljJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkaXRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZGl0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQoNCg0KDQoJLm5idXMtc3VydmV5e2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJLm5idXMtc3VydmV5OnZpc2l0ZWR7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6aG92ZXJ7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6Zm9jdXN7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6YWN0aXZle2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJDQoJb25lLWNvbHVtbntib3JkZXItc3BhY2luZzowcHg7YmFja2dyb3VuZC1jb2xvcjojRkZGRkZGO2JvcmRlcjowcHg7cGFkZGluZzowcHg7d2lkdGg6MTAwJTtjb2x1bW4tY291bnQ6MTt9DQoJZW5kckltYWdlQmxvY2t7cGFkZGluZzowcHg7Ym9yZGVyLXNwYWNpbmc6MHB4O21pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTt3aWR0aDoxMDAlO2JvcmRlcjowcHg7fQ0KCWVuZHJJbWFnZUJsb2NrSW5uZXJ7cGFkZGluZzowcHg7fQ0KCWVuZHJJbWFnZUNvbnRlbnRDb250YWluZXJ7YWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7bWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO3dpZHRoOjEwMCU7Ym9yZGVyOjBweDt9DQoJZW5kclRleHRDb250ZW50Q29udGFpbmVye21pbi13aWR0aDoxMDAlO3dpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO2JhY2tncm91bmQtY29sb3I6I0ZGRkZGRjtib3JkZXI6MHB4O3BhZGRpbmc6MHB4O2JvcmRlci1zcGFjaW5nOjBweDt9DQoJZW5kclRleHRCbG9ja3ttaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO3dpZHRoOjEwMCVwYWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7Ym9yZGVyOjBweDt9DQoJcHJldmlldy10ZXh0e2Rpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQoJDQoJcHsNCgl0ZXh0LWFsaWduOiBsZWZ0Ow0KCW1hcmdpbi10b3A6MTBweDsNCgltYXJnaW4tYm90dG9tOjEwcHg7DQoJbWFyZ2luLXJpZ2h0OjA7DQoJbWFyZ2luLWxlZnQ6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJcGFkZGluZy1yaWdodDowOw0KCXBhZGRpbmctbGVmdDowOw0KCWxpbmUtaGVpZ2h0OjE4NSU7DQoJfQ0KCXRhYmxlew0KCWJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsNCgl9DQoJaDEsaDIsaDMsaDQsaDUsaDZ7DQoJZGlzcGxheTpibG9jazsNCgltYXJnaW46MDsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZyxhIGltZ3sNCglib3JkZXI6MDsNCgloZWlnaHQ6YXV0bzsNCglvdXRsaW5lOm5vbmU7DQoJdGV4dC1kZWNvcmF0aW9uOm5vbmU7DQoJfQ0KCXByZXsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJZm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7DQoJbWluLXdpZHRoOjEwMCU7DQoJd2hpdGUtc3BhY2U6IHByZS13cmFwOyAgICAgICAvKiBTaW5jZSBDU1MgMi4xICovDQogICAgd2hpdGUtc3BhY2U6IC1tb3otcHJlLXdyYXA7ICAvKiBNb3ppbGxhLCBzaW5jZSAxOTk5ICovDQogICAgd2hpdGUtc3BhY2U6IC1wcmUtd3JhcDsgICAgICAvKiBPcGVyYSA0LTYgKi8NCiAgICB3aGl0ZS1zcGFjZTogLW8tcHJlLXdyYXA7ICAgIC8qIE9wZXJhIDcgKi8NCiAgICB3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7ICAgICAgIC8qIEludGVybmV0IEV4cGxvcmVyIDUuNSsgKi8NCgl9DQoJYm9keSwjYm9keVRhYmxlLCNib2R5Q2VsbHsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCWNvbG9yOiM5OTk5OTkNCglmb250LWZhbWlseTonQW1hem9uIEVtYmVyJzsNCgltaW4td2lkdGg6MTAwJTsNCgl9DQoJI291dGxvb2sgYXsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZ3sNCgktbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7DQoJfQ0KCXRhYmxlew0KCW1zby10YWJsZS1sc3BhY2U6MHB0Ow0KCW1zby10YWJsZS1yc3BhY2U6MHB0Ow0KCX0NCgkuUmVhZE1zZ0JvZHl7DQoJd2lkdGg6MTAwJTsNCgl9DQoJLkV4dGVybmFsQ2xhc3N7DQoJd2lkdGg6MTAwJTsNCgl9DQoJcCxhLGxpLHRkLGJsb2NrcXVvdGV7DQoJbXNvLWxpbmUtaGVpZ2h0LXJ1bGU6ZXhhY3RseTsNCgl9DQoJYVtocmVmXj10ZWxdLGFbaHJlZl49c21zXXsNCgljb2xvcjppbmhlcml0Ow0KCWN1cnNvcjpkZWZhdWx0Ow0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCglwLGEsbGksdGQsYm9keSx0YWJsZSxibG9ja3F1b3Rlew0KCS1tcy10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJfQ0KCS5FeHRlcm5hbENsYXNzLC5FeHRlcm5hbENsYXNzIHAsLkV4dGVybmFsQ2xhc3MgdGQsLkV4dGVybmFsQ2xhc3MgZGl2LC5FeHRlcm5hbENsYXNzIHNwYW4sLkV4dGVybmFsQ2xhc3MgZm9udHsNCglsaW5lLWhlaWdodDoxMDAlOw0KCX0NCglhW3gtYXBwbGUtZGF0YS1kZXRlY3RvcnNdew0KCWNvbG9yOmluaGVyaXQgIWltcG9ydGFudDsNCgl0ZXh0LWRlY29yYXRpb246bm9uZSAhaW1wb3J0YW50Ow0KCWZvbnQtc2l6ZTppbmhlcml0ICFpbXBvcnRhbnQ7DQoJZm9udC1mYW1pbHk6aW5oZXJpdCAhaW1wb3J0YW50Ow0KCWZvbnQtd2VpZ2h0OmluaGVyaXQgIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDppbmhlcml0ICFpbXBvcnRhbnQ7DQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgltYXgtd2lkdGg6NjAwcHggIWltcG9ydGFudDsNCgl9DQoJLmVuZHJJbWFnZXsNCgl2ZXJ0aWNhbC1hbGlnbjpib3R0b207DQoJfQ0KCS5lbmRyVGV4dENvbnRlbnR7DQoJd29yZC1icmVhazpicmVhay13b3JkOw0KCXBhZGRpbmctdG9wOjE1cHg7DQoJcGFkZGluZy1ib3R0b206MTBweDsNCglwYWRkaW5nLXJpZ2h0OjE4cHg7DQoJcGFkZGluZy1sZWZ0OjE4cHg7DQoJdGV4dC1hbGlnbjogbGVmdDsNCgl9DQoJLmVuZHJUZXh0Q29udGVudCBpbWd7DQoJaGVpZ2h0OmF1dG8gIWltcG9ydGFudDsNCgl9DQoJLmVuZHJEaXZpZGVyQmxvY2t7DQoJdGFibGUtbGF5b3V0OmZpeGVkICFpbXBvcnRhbnQ7DQoJfQ0KCWJvZHkgeyBtYXJnaW46MCAhaW1wb3J0YW50OyB9DQoJZGl2W3N0eWxlKj0ibWFyZ2luOiAxNnB4IDAiXSB7IG1hcmdpbjowICFpbXBvcnRhbnQ7IH0NCg0KCWJvZHksI2JvZHlUYWJsZXsNCgliYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7DQoJY29sb3I6Izk5OTk5OTsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJfQ0KCQ0KCS50ZW1wbGF0ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGRkZGRkY7DQoJYm9yZGVyLXRvcC13aWR0aDowOw0KCWJvcmRlci1ib3R0b20td2lkdGg6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJZm9udC1zaXplOjE1cHg7DQoJbGluZS1oZWlnaHQ6MTg1JTsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJYmFja2dyb3VuZC1jb2xvcjojRkZGRkZGOw0KCX0NCgkNCgkudGVtcGxhdGVRdW90ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGMDRENDQ7DQoJfQ0KCQ0KCSNib2R5Q2VsbHsNCglib3JkZXItdG9wOjA7DQoJfQ0KDQoJaDF7DQoJY29sb3I6IzQ1NWM2NDsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjMwcHg7DQoJZm9udC1zdHlsZTpub3JtYWw7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCWxpbmUtaGVpZ2h0OjEyMCU7DQoJbGV0dGVyLXNwYWNpbmc6bm9ybWFsOw0KCXBhZGRpbmctdG9wOjJweDsNCglwYWRkaW5nLWJvdHRvbToycHg7DQoJfQ0KDQoJYXsNCgljb2xvcjojZTc0YzNjOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCWgyew0KCWNvbG9yOiM4NDg0ODQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxNXB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDUlOw0KCWxldHRlci1zcGFjaW5nOjFweDsNCglwYWRkaW5nLXRvcDo1cHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWgzew0KCWNvbG9yOiM0NTVjNjQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDAlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MnB4Ow0KCXBhZGRpbmctYm90dG9tOjJweDsNCgl9DQoNCgloNHsNCgljb2xvcjojNjY2NjY2Ow0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTZweDsNCglmb250LXN0eWxlOm5vcm1hbDsNCglmb250LXdlaWdodDpub3JtYWw7DQoJbGluZS1oZWlnaHQ6MTI1JTsNCglsZXR0ZXItc3BhY2luZzpub3JtYWw7DQoJdGV4dC1hbGlnbjpsZWZ0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWg1ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MTFweDsNCglwYWRkaW5nLXJpZ2h0OjIwcHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCXBhZGRpbmctbGVmdDoyMHB4Ow0KCX0NCg0KCWg2ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyNnB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1yaWdodDoyMHB4Ow0KCXBhZGRpbmctYm90dG9tOjhweDsNCglwYWRkaW5nLWxlZnQ6MjBweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXJ7DQoJYm9yZGVyLXRvcDowOw0KCWJvcmRlci1ib3R0b206MDsNCglwYWRkaW5nLXRvcDo0cHg7DQoJcGFkZGluZy1ib3R0b206MTJweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxMnB4Ow0KCWxpbmUtaGVpZ2h0OjE1MCU7DQoJdGV4dC1hbGlnbjpjZW50ZXI7DQoJfQ0KDQoJI3RlbXBsYXRlUHJlaGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgYSwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwIGF7DQoJY29sb3I6I2ZiZmJmYjsNCglmb250LXdlaWdodDpub3JtYWw7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsNCgl9DQoNCgkjdGVtcGxhdGVIZWFkZXJ7DQoJYmFja2dyb3VuZC1jb2xvcjojMzAzOTQyOw0KCWJvcmRlci10b3A6MHB4IHNvbGlkICNlNGUzZTQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjBweDsNCglwYWRkaW5nLWJvdHRvbTowcHg7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxMDAlOw0KCXRleHQtYWxpZ246cmlnaHQ7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgaDF7DQoJY29sb3I6I2ZmZmZmZjsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjIwcHg7DQoJbGluZS1oZWlnaHQ6MTAwJTsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCg0KCSN0ZW1wbGF0ZVNlcGFyYXRvcnsNCglwYWRkaW5nLXRvcDo4cHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keXsNCgliYWNrZ3JvdW5kLWNvbG9yOiM0NTVDNjQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjFweDsNCglwYWRkaW5nLWJvdHRvbToxcHg7DQoJfQ0KDQoJLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQsLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246bGVmdDsNCgl9DQoNCgkudGVtcGxhdGVMb3dlckJvZHkgLmVuZHJUZXh0Q29udGVudCBhLC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHAgYXsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IGgxIHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0OjcwMDsNCglmb250LXNpemU6MThweDsNCgl9DQoNCgkudGVtcGxhdGVTb2NpYWx7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCXBhZGRpbmctdG9wOjEzcHg7DQoJcGFkZGluZy1ib3R0b206M3B4Ow0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlcnsNCglib3JkZXItdG9wOjA7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjVweDsNCglwYWRkaW5nLWJvdHRvbTo1cHg7DQoJfQ0KDQoJI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmJmYmZiOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTJweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246Y2VudGVyOw0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7DQoJfQ0KCQ0KCUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDo3NjhweCl7DQoJLnRlbXBsYXRlQ29udGFpbmVyew0KCXdpZHRoOjYwMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JDQoJDQoJQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLnRlbXBsYXRlSGVhZGVyew0KCQlkaXNwbGF5OiBub25lOw0KCX0NCgkJDQoJLmJpZ2ltYWdlIC5lbmRySW1hZ2VDb250ZW50ew0KCXBhZGRpbmctdG9wOjBweCAhaW1wb3J0YW50Ow0KDQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgl3aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJbWF4LXdpZHRoOjYwMHB4Ow0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJYm9keSx0YWJsZSx0ZCxwLGEsbGksYmxvY2txdW90ZXsNCgktd2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6bm9uZSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCWJvZHl7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCW1pbi13aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJI2JvZHlDZWxsew0KCXBhZGRpbmctdG9wOjEwcHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uV3JhcHBlcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25Ub3BDb250ZW50LC5lbmRyQ2FwdGlvbkJvdHRvbUNvbnRlbnQsLmVuZHJUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJJbWFnZUdyb3VwQ29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0VGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJDYXB0aW9uUmlnaHRUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRyQ2FwdGlvblJpZ2h0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkTGVmdFRleHRDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkUmlnaHRUZXh0Q29udGVudENvbnRhaW5lcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXJ7DQoJbWluLXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfSBAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9IEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VHcm91cENvbnRlbnR7DQoJcGFkZGluZzo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25MZWZ0Q29udGVudE91dGVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJDYXB0aW9uUmlnaHRDb250ZW50T3V0ZXIgLmVuZHJUZXh0Q29udGVudHsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZFRvcEltYWdlQ29udGVudCwuZW5kckNhcHRpb25CbG9ja0lubmVyIC5lbmRyQ2FwdGlvblRvcENvbnRlbnQ6bGFzdC1jaGlsZCAuZW5kclRleHRDb250ZW50ew0KCXBhZGRpbmctdG9wOjE4cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZEJvdHRvbUltYWdlQ29udGVudHsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlR3JvdXBCbG9ja0lubmVyew0KCXBhZGRpbmctdG9wOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTowICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJLmVuZHJJbWFnZUdyb3VwQmxvY2tPdXRlcnsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kclRleHRDb250ZW50LC5lbmRyQm94ZWRUZXh0Q29udGVudENvbHVtbnsNCglwYWRkaW5nLXJpZ2h0OjE4cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VDYXJkTGVmdEltYWdlQ29udGVudCwuZW5kckltYWdlQ2FyZFJpZ2h0SW1hZ2VDb250ZW50ew0KCXBhZGRpbmctcmlnaHQ6MThweCAhaW1wb3J0YW50Ow0KCXBhZGRpbmctYm90dG9tOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5tY3ByZXZpZXctaW1hZ2UtdXBsb2FkZXJ7DQoJZGlzcGxheTpub25lICFpbXBvcnRhbnQ7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDF7DQoJZm9udC1zaXplOjIycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxMjUlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgloMnsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEyNSUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCWgzew0KCWZvbnQtc2l6ZToxOHB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTI1JSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDR7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTRweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZVByZWhlYWRlcnsNCglkaXNwbGF5OmJsb2NrICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxMnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCgl0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50LCAjdGVtcGxhdGVIZWFkZXIgLmVuZHJUZXh0Q29udGVudCBoMXsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbToxMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxNnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgkNCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50LC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJdGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50LCN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjEycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0NCjwvc3R5bGU-DQoNCjwhLS1baWYgbXNvXT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQpib2R5LCB0YWJsZSwgdGQge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoMSB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmgyIHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDMge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNCB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmg1IHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDYge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNyB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCnAge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQo8L3N0eWxlPg0KPCFbZW5kaWZdLS0-DQoNCjwhLS1baWYgZ3QgbXNvIDE1XT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgbWVkaWE9ImFsbCI-DQovKiBPdXRsb29rIDIwMTYgSGVpZ2h0IEZpeCAqLw0KdGFibGUsIHRyLCB0ZCB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTt9DQp0ciB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgfQ0KYm9keSB7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO30NCjwvc3R5bGU-DQo8IVtlbmRpZl0tLT4gICAgPC9oZWFkPg0KDQogICAgPGJvZHk-DQogICAgICAgIDxjZW50ZXIgY2xhc3M9IndyYXBwZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO3RhYmxlLWxheW91dDpmaXhlZDtiYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7Ij4NCiAgPGRpdiBjbGFzcz0id2Via2l0IiBzdHlsZT0ibWF4LXdpZHRoOjYwMHB4O21hcmdpbjowIGF1dG87Ij4NCiAgICAgIDx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgaGVpZ2h0PSIxMDAlIiB3aWR0aD0iMTAwJSIgaWQ9ImJvZHlUYWJsZSIgc3R5bGU9ImJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTtoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDt3aWR0aDoxMDAlO2JhY2tncm91bmQtY29sb3I6I2U0ZTNlNDtjb2xvcjojNWE1YTVhO2ZvbnQtZmFtaWx5OidMYXRvJywgSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsiPg0KICAgICAgICA8dGJvZHk-PHRyPg0KICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiBpZD0iYm9keUNlbGwiIHN0eWxlPSJoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7d2lkdGg6MTAwJTtwYWRkaW5nLXRvcDoxMHB4O3BhZGRpbmctYm90dG9tOjEwcHg7Ym9yZGVyLXRvcC13aWR0aDowOyI-DQo8IS0tIEJFR0lOIFRFTVBMQVRFIC8vIC0tPg0KPCEtLVtpZiAoZ3RlIG1zbyA5KXwoSUUpXT4NCjx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgd2lkdGg9IjYwMCIgc3R5bGU9IndpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiID4NCgk8dHI-DQoJPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiB3aWR0aD0iNjAwIiBzdHlsZT0id2lkdGg6NjAwcHg7IiA-DQoJCTwhW2VuZGlmXS0tPg0KCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGRhdGEtc3BhY2UtaGVhZGVyPg0KCQk8dGJvZHk-PHRyPg0KCQk8dGQ-DQogICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsiPg0KICAgICAgICAgICAgU2hpcCBieTogMTMvMDEvMjAyNiwgU3RhbmRhcmQgU2hpcHBpbmcNCiAgICAgICAgPC9kaXY-DQoNCiAgICAgICAgPCEtLSBCTE9DSyBMb2dvIENlbnRlciAtLT4NCiA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjA7IiBkYXRhLXNwYWNlLXNjLWhlYWRlcj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICA8dGQgY2xhc3M9InRlbXBsYXRlSGVhZGVyIiB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6IDIwcHggMDsgcGFkZGluZy1sZWZ0OjQwcHgiPg0KICAgICAgICAgIDxpbWcgYWxpZ249ImNlbnRlciIgYWx0PSIiIHNyYz0iaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvU1BBQ0UvbG9nby1zZWxsaW5nX2NvYWNoLnBuZyIgd2lkdGg9IjIwMCIgc3R5bGU9Im1heC13aWR0aDoyMDBweDtwYWRkaW5nLWJvdHRvbTowO2Rpc3BsYXk6aW5saW5lICFpbXBvcnRhbnQ7dmVydGljYWwtYWxpZ246Ym90dG9tO2JvcmRlci13aWR0aDowO2hlaWdodDphdXRvO291dGxpbmUtc3R5bGU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTstbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7Ij4NCiAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCjwhLS0gRU5EUiBIZWFkZXIgIC0tPg0KDQoNCjwvdGQ-DQo8L3RyPg0KPC90Ym9keT48L3RhYmxlPg0KDQo8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmOyIgYmdjb2xvcj0iI2ZmZmZmZiI-DQo8dGJvZHk-PHRyPg0KPHRkPg0KICAgICAgICA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iPg0KICAgICAgICAgICAgPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlQmxvY2tzIj4NCiAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiPg0KICAgICAgICAgICAgICAgICAgICA8dGFibGUgY2xhc3M9ImVuZHJUZXh0QmxvY2siPg0KICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5IGNsYXNzPSJlbmRyVGV4dEJsb2NrT3V0ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0iZW5kclRleHRCbG9ja0lubmVyIj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0YWJsZSBhbGlnbj0ibGVmdCIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnQiIGFsaWduPSJjZW50ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7bWFyZ2luLXRvcDoxMHB4O21hcmdpbi1ib3R0b206MTBweDttYXJnaW4tcmlnaHQ6MDttYXJnaW4tbGVmdDowO3BhZGRpbmctdG9wOjA7cGFkZGluZy1ib3R0b206MDtwYWRkaW5nLXJpZ2h0OjA7cGFkZGluZy1sZWZ0OjA7bGluZS1oZWlnaHQ6MTg1JTsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQogICAgICAgICAgICA8L3A-PGRpdiBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0Ij4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICANCiAgICANCiAgICA8cD5Db25ncmF0dWxhdGlvbnMsIHlvdSBoYXZlIGEgbmV3IG9yZGVyIG9uIEFtYXpvbiEgWW91ciBjdXN0b21lciBpcyBleHBlY3RpbmcgdGhpcyB0byBzaGlwIGJ5IDEzLzAxLzIwMjYuPC9wPg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgIDxwPlBsZWFzZSByZXZpZXcgeW91ciBvcmRlcjo8L3A-DQogICAgDQogICAgICAgICAgICAgICAgPGNlbnRlcj4NCiAgICAgICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luOiAyMHB4IDBweCAyMHB4IDEwcHg7IHBhZGRpbmc6MTBweDsgZGlzcGxheTppbmxpbmUtYmxvY2s7IGJhY2tncm91bmQtY29sb3I6IzAwNjU3NDsiPg0KICAgIDxhIHN0eWxlPSJjb2xvcjojZmZmOyB0ZXh0LWRlY29yYXRpb246bm9uZTsiIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC9mZjUyZTY4YS1lODE1LTMyOTEtYmMwNC0xMzJiM2M0YWM1NDg_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9cGxEUW4tYzlPdFd6WlVwU29aZUN4ejV0NXVaV2JXLTduRXphSFpOaWJOZ0E3c0ZwVTNuRDUyWmJONTIxY3BTVktKaEpQYjBoQjlzX1dMUkFzaGNlQXcmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5dmNtUmxjbk10ZGpNdmIzSmtaWEl2TkRBMExUYzJOekk0TURBdE5EUXlNVEUyT0Q5eVpXWmZQWGg0WDJWdFlXbHNYMkp2WkhsZmMyaHBjQSI-DQogICAgICAgIFZpZXcgT3JkZXINCiAgICA8L2E-DQo8L2Rpdj4NCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxkaXYgc3R5bGU9Im1hcmdpbjogMjBweCAwcHggMjBweCAyMHB4OyBwYWRkaW5nOjEwcHg7IGRpc3BsYXk6aW5saW5lLWJsb2NrOyBiYWNrZ3JvdW5kLWNvbG9yOiNlM2VjZWQ7Ij4NCiAgICA8YSBzdHlsZT0iY29sb3I6IzAwMmYzNjsgdGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9zZWxsZXJtb2JpbGUvcmVkaXJlY3QvYzFlODE1YjEtNTA5NC0zNDc1LTg1NzktOWJlMDIyYWU4OWRlP250PVNPTERfU0hJUF9OT1cmYW1wO3NrPVpWOXhQOHhLTXVCaXBuNW9RdGhhenRiWUxSSkY0UlBjc0kxWWZJbkNOV2QweDM5dHM3Z3FLb1AyZ2htRjktOVJaTW1sYVRuZHkzanJzaFdqczdpWmpnJmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJpOW9aV3h3TDJoMVlpOXlaV1psY21WdVkyVXZSekl3TVRNNE16TTBNRDl5WldaZlBYaDRYMlZ0WVdsc1gySnZaSGxmYUdWc2NBIj4NCiAgICAgICAgR2V0IEhlbHAgU2hpcHBpbmcgWW91ciBPcmRlcg0KICAgIDwvYT4NCjwvZGl2Pg0KICAgIDwvY2VudGVyPg0KICAgIDxoMz5PcmRlciBEZXRhaWxzPC9oMz4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-T3JkZXIgSUQ6PC9iPiA0MDQtNzY3MjgwMC00NDIxMTY4DQogICAgPGJyPg0KICAgICAgICAgICAgICAgIDxiPk9yZGVyIGRhdGU6PC9iPiAxMS8wMS8yMDI2DQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlBsZWFzZSBzaGlwIHRoaXMgb3JkZXIgdXNpbmc6PC9iPiBTdGFuZGFyZCBTaGlwcGluZw0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNoaXAgYnk6PC9iPiAxMy8wMS8yMDI2DQogICAgICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-SXRlbTo8L2I-IERpZ2l0YWwgUG9ja2V0IFdlaWdoaW5nIFNjYWxlIC0gMC4wMWcgSGlnaCBQcmVjaXNpb24gR29sZCAmYW1wOyBKZXdlbGxlcnkgV2VpZ2h0IE1hY2hpbmUgfCBQb3J0YWJsZSBHcmFtIFNjYWxlIHdpdGggU3RhaW5sZXNzIFN0ZWVsIFBsYXRmb3JtICZhbXA7IExDRCBEaXNwbGF5IC0gR3JpcGl0IEdPTEQgU2NhbGUNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db25kaXRpb246PC9iPiBOZXcNCiAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNLVTo8L2I-IDRHLVU1VE4tRExITA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlF1YW50aXR5OjwvYj4gMQ0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlByaWNlOjwvYj4gSU5SIDY2Ni4xMA0KICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlRheDo8L2I-IElOUiAxMTkuOTANCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-QW1hem9uIGZlZXM6PC9iPiAtSU5SIDE2NS4zMw0KICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-WW91ciBlYXJuaW5nczo8L2I-IElOUiA2MjAuNjcNCiAgICA8YnI-DQogICAgICAgICAgICANCiAgICANCiAgICANCjwvZGl2Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwPjwvcD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGQ-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGFibGU-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGQ-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgIDwvdGFibGU-DQogICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgIDwvdHI-DQogICAgICAgIDwvdGJvZHk-PC90YWJsZT4NCg0KDQogICAgICAgICAgICAgICAgDQoNCgkJCQkJDQoJCQkJCTx0YWJsZSBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgY2xhc3M9InRlbXBsYXRlQ29udGFpbmVyIiB3aWR0aD0iMTAwJSIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGRhdGEtc3BhY2UtZm9vdGVyIGRhdGEtc3BhY2Utc2MtZm9vdGVyPg0KCQkJCQk8dGJvZHk-PHRyPg0KCQkJCQk8dGQ-DQoJCQkJDQoJCQkJCTwhLS0gQkxPQ0sgRm9vdGVyIEFib3V0IFVzIC0tPg0KCQkJCQk8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjA7IiBkaXI9ImF1dG8iPg0KCQkJCQk8dGJvZHk-PHRyIHZhbGlnbj0idG9wIiBzdHlsZT0iYm9yZGVyLXRvcC13aWR0aDowO2JvcmRlci1ib3R0b20td2lkdGg6MDtmb250LXNpemU6MTRweDtsaW5lLWhlaWdodDoxODUlO3RleHQtYWxpZ246bGVmdDsiPg0KCQkJCQkJPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0idGVtcGxhdGVMb3dlckJvZHkiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiMyYTMyM2E7Ij4NCiAgICAgICAgICAgICAgICAgICAgICAgIAk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHdpZHRoPSIxMDAlIiBjbGFzcz0iZW5kclRleHRCbG9jayIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTtiYWNrZ3JvdW5kLWNvbG9yOiMyYTMyM2E7IiBiZ2NvbG9yPSIjMmEzMjNhIj4NCgkJCQkJCQkJPHRib2R5IGNsYXNzPSJlbmRyVGV4dEJsb2NrT3V0ZXIiPg0KCQkJCQkJCQkJPHRyPg0KCQkJCQkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9ImVuZHJUZXh0QmxvY2tJbm5lciI-DQoJCQkJCQkJCQkJCTxjZW50ZXIgc3R5bGU9Im1hcmdpbi10b3A6IDIwcHg7Ij4NCiAgICAgICAgICAgICAgICAgICAgICAgIAk8YSBzdHlsZT0icGFkZGluZzogN3B4IDI0cHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgYmFja2dyb3VuZDogI2ZmZjsgYm9yZGVyOiAxcHggc29saWQgI0VDOTM3QzsgYm9yZGVyLXJhZGl1czogNXB4OyBjb2xvcjogIzdGMTgwOTsgZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOyBmb250LXNpemU6IDEzcHg7IGZvbnQtd2VpZ2h0OiA2MDA7ZGlzcGxheTogaW5saW5lLWJsb2NrOyBtYXJnaW4tYm90dG9tOiAxMHB4IiBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25vdGlmaWNhdGlvbnMvZmVlZGJhY2s_ZGVsaXZlcnlJZD0yNDYyOTIyMjExMDI0NDcmYW1wO2NvbW11bmljYXRpb25OYW1lPVNPTERfU0hJUF9OT1cmYW1wO2RlbGl2ZXJ5Q2hhbm5lbD1FTUFJTCI-DQogICAgICAgICAgICAgICAgICAgIDxpbWcgc3JjPSJodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9zcGFjZS9pY29uLnBuZyIgc3R5bGU9Im1hcmdpbi1yaWdodDogMTBweDt2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOyIgd2lkdGg9IjIwIiBoZWlnaHQ9IjIwIj5SZXBvcnQgYW4gaXNzdWUgd2l0aCB0aGlzIGVtYWlsDQogICAgICAgICAgICAgICAgICA8L2E-DQogICAgICAgICAgICAgICAgICAgICAgICA8L2NlbnRlcj48cCBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDttYXJnaW4tdG9wOjEwcHg7bWFyZ2luLWJvdHRvbToxMHB4O21hcmdpbi1yaWdodDoxMHB4O21hcmdpbi1sZWZ0OjE1cHg7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDtjb2xvcjojZmZmZmZmO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7Ij5JZiB5b3UgaGF2ZSBhbnkgcXVlc3Rpb25zIHZpc2l0OiA8YSBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9zZWxsZXJtb2JpbGUvcmVkaXJlY3QvMDRiNDUxMWItNGExMC0zY2U4LTlkNDYtYTRiOTAyOTMwYzVjP250PVNPTERfU0hJUF9OT1cmYW1wO3NrPXd0YTN4cEs4Rm9qbHJ1bDJLVEo5dVNXNTl0d1JjbEowcHhwVjZlRDRQQ0FXYmpydlRDTVR6M2dtR0cxV0s1R3RnZ2d3TjFJTW5kNFZ4OFhlZDE4SUx3JmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJnIiBtZXRyaWM9ImhlbHAiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjZmZmZmZmOyI-U2VsbGVyIENlbnRyYWw8L2E-PGJyPjxicj4NCgkJCQkJCQkJCQkJICAgIFRvIGNoYW5nZSB5b3VyIGVtYWlsIHByZWZlcmVuY2VzIHZpc2l0OiA8YSBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9yZWRpcmVjdC9hYmM5Y2JkYi0wYTFmLTNjYTYtYjFhZi0wMjQyYTE0ZGZmMWI_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9M1dmOWtSUFl2MHZkQmVRNmV1Wkd5b1dvX3UzMHhFWmYwOE9lbnc5Ynl0YlpXQjBfYUtjWTFQenlQU1cyY2dtNVF2YmtyVHhmQUxYRTZOZ0ptY1dWY0EmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5dWIzUnBabWxqWVhScGIyNXpMM0J5WldabGNtVnVZMlZ6TDNKbFpqMXBaRjl1YjNScFpuQnlaV1pmWkc1aGRsOTRlRjgiIG1ldHJpYz0ib3B0b3V0IiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOiBub25lOyBjb2xvcjogI2ZmZmZmZjsiPk5vdGlmaWNhdGlvbiBQcmVmZXJlbmNlczwvYT48YnI-PGJyPg0KCQkJCQkJCQkJCQkJCQkJCQkJV2UgaG9wZSB5b3UgZm91bmQgdGhpcyBtZXNzYWdlIHRvIGJlIHVzZWZ1bC4gSG93ZXZlciwgaWYgeW91J2QgcmF0aGVyIG5vdCByZWNlaXZlIGZ1dHVyZSBlLW1haWxzIG9mIHRoaXMgc29ydCBmcm9tIEFtYXpvbi5jb20sIHBsZWFzZSBvcHQtb3V0IDxhIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3JlZGlyZWN0LzE5NTZjNzBiLWRhNDAtMzY0MC05MzdiLTIzZDE5YTg0NDJlOD9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1hYWRFejVvQkdydlhuUFpWdUE0SERiT3R3bktIdmo2N1I3Z2xvMnlyNUVPYVFLX3Q0VlRrSy15SDdab0g2OG5VNlZtVWJnNWFJUnlUaFhqbmlkZmN3dyZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl1YjNScFptbGpZWFJwYjI1ekwzQnlaV1psY21WdVkyVnpMMjl3ZEc5MWREOXZjSFJ2ZFhSSlpEMHhaV1F6TjJFek5DMDFOVEV3TFRRMVpqZ3RZVFF3WVMwME5XRm1PR0l5TURSa1lqUSIgbWV0cmljPSJvcHRvdXQiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjZmZmZmZmOyI-aGVyZS48L2E-PGJyPjxicj4NCgkJCQkJCQkJCQkJCUNvcHlyaWdodCAgMjAyNiBBbWF6b24sIEluYywgb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuPGJyPiANCgkJCQkJCQkJCQkJCUFtYXpvbiBTZWxsZXIgU2VydmljZXMgUHJpdmF0ZSBMaW1pdGVkLCA4dGggZmxvb3IsIEJyaWdhZGUgR2F0ZXdheSwgMjYvMSBEci4gUmFqa3VtYXIgUm9hZCwgQmFuZ2Fsb3JlIDU2MDA1NSAoS2FybmF0YWthKTxicj48L3A-PHRhYmxlIGFsaWduPSJsZWZ0IiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgd2lkdGg9IjEwMCUiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnRDb250YWluZXIiIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7IiBiZ2NvbG9yPSIjMmEzMjNhIj4NCgkJCQkJCQkJCQkJPHRib2R5Pg0KCQkJCQkJCQkJCQk8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgDQoJCQkJCQkJCQkJCQ0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCgkJCQkJPCEtLSBCTE9DSyBGb290ZXIgQWJvdXQgVXMgLS0-DQoJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCgkJCQkJDQoJCQkJCTx0YWJsZSBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgY2xhc3M9InRlbXBsYXRlQ29udGFpbmVyIiBzdHlsZT0id2lkdGg6MTAwJTttYXgtd2lkdGg6NjAwcHg7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlOyI-DQoJCQkJCTx0Ym9keT48dHI-DQoJCQkJCTx0ZD4NCgkJCQkNCgkJCQkJPC90ZD4NCgkJCQkJPC90cj4NCgkJCQkJPC90Ym9keT48L3RhYmxlPg0KCQkJCQk8IS0tW2lmIChndGUgbXNvIDkpfChJRSldPg0KCQkJCTwvdGQ-DQoJCQkJPC90cj4NCgkJCTwvdGFibGU-DQoJCQk8IVtlbmRpZl0tLT4NCgkJCTwhLS0gLy8gRU5EIFRFTVBMQVRFIC0tPg0KCQkJPC90ZD4NCgkJPC90cj4NCgkJPC90Ym9keT48L3RhYmxlPiAgICANCg0KPC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2Rpdj48L2NlbnRlcj48aW1nIHNyYz0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvaW1nLzQxNjk1MjEzLWYyMTUtM2ZlYi05MmYxLTJlZDUyOGY4ZTJiMz9zaz1keWtsRkdUaF9FWmxtSmRiYkhKaFllNkQxRWYtM1FGOEtpQkU4T1pMQUtLTXZLQnRpbl9rQVdIdmVaRDlqdEUtTE5JWUxRQi1NbGJIUDQ1NWFGZWk0USZhbXA7bj0xIj4NCjxkaXYgaWQ9InNwYy13YXRlcm1hcmsiPg0KICA8cCBzdHlsZT0iZm9udC1zaXplOiAxMHB4ICFpbXBvcnRhbnQ7cGFkZGluZy1ib3R0b206IDEwcHggIWltcG9ydGFudDtkaXNwbGF5OiB0YWJsZSAhaW1wb3J0YW50O21hcmdpbjogNXB4IGF1dG8gMTBweCAhaW1wb3J0YW50O3RleHQtYWxpZ246IGNlbnRlciAhaW1wb3J0YW50O2NvbG9yOiAjYTJhMmEyICFpbXBvcnRhbnQ7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInICFpbXBvcnRhbnQ7Zm9udC13ZWlnaHQ6IDQwMCAhaW1wb3J0YW50OyI-U1BDLUVVQW1hem9uLTI0NjI5MjIyMTEwMjQ0NzwvcD4NCjwvZGl2PjwvYm9keT48L2h0bWw-"}}]},"sizeEstimate":37116,"historyId":"2853928","internalDate":"1768093427000"}', '2026-01-11T04:56:56.918Z', '19baa94aadcca5ec', '19ba0d41bdcfc90f', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('6e8237454abf9a18bc090bd9ea36a6af', '101f04af63cbefc2bf8f0a98b9ae1205', 'Seller Notification <seller-notification@amazon.in>', 'Sold, ship now: Atom-999 Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem & Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop & Professional Use', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        

<!--[if gte mso 15]>
<xml>
	<o:OfficeDocumentSettings>
	<o:AllowPNG/>
	<o:PixelsPerInch>96</o:PixelsPerInch>
	</o:OfficeDocumentSettings>
</xml>
<![endif]-->
<meta charset="UTF-8">
<!--[if !mso]><!-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--<![endif]-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="http://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet" type="text/css">
<style type="text/css">
	
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 300;
    src: local(''Amazon Ember Light''), local(''AmazonEmber-Light''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 300;
    src: local(''Amazon Ember Light Italic''), local(''AmazonEmber-LightItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 400;
    src: local(''Amazon Ember''), local(''AmazonEmber''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 400;
    src: local(''Amazon Ember Italic''), local(''AmazonEmber-Italic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 600;
    src: local(''Amazon Ember Medium''), local(''AmazonEmber-Medium''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 600;
    src: local(''Amazon Ember Medium Italic''), local(''AmazonEmber-MediumItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 700;
    src: local(''Amazon Ember Bold''), local(''AmazonEmber-Bold''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 700;
    src: local(''Amazon Ember Bold Italic''), local(''AmazonEmber-BoldItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff) format(''woff'');
}



	.nbus-survey{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:visited{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:hover{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:focus{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:active{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	
	one-column{border-spacing:0px;background-color:#FFFFFF;border:0px;padding:0px;width:100%;column-count:1;}
	endrImageBlock{padding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrImageBlockInner{padding:0px;}
	endrImageContentContainer{adding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrTextContentContainer{min-width:100%;width:100%;border-collapse:collapse;background-color:#FFFFFF;border:0px;padding:0px;border-spacing:0px;}
	endrTextBlock{min-width:100%;border-collapse:collapse;background-color:#ffffff;width:100%padding:0px;border-spacing:0px;border:0px;}
	preview-text{display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';}
	
	p{
	text-align: left;
	margin-top:10px;
	margin-bottom:10px;
	margin-right:0;
	margin-left:0;
	padding-top:0;
	padding-bottom:0;
	padding-right:0;
	padding-left:0;
	line-height:185%;
	}
	table{
	border-collapse:collapse;
	}
	h1,h2,h3,h4,h5,h6{
	display:block;
	margin:0;
	padding:0;
	}
	img,a img{
	border:0;
	height:auto;
	outline:none;
	text-decoration:none;
	}
	pre{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	font-family:''Amazon Ember'';
	min-width:100%;
	white-space: pre-wrap;       /* Since CSS 2.1 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
	}
	body,#bodyTable,#bodyCell{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	background-color:#e4e3e4;
	color:#999999
	font-family:''Amazon Ember'';
	min-width:100%;
	}
	#outlook a{
	padding:0;
	}
	img{
	-ms-interpolation-mode:bicubic;
	}
	table{
	mso-table-lspace:0pt;
	mso-table-rspace:0pt;
	}
	.ReadMsgBody{
	width:100%;
	}
	.ExternalClass{
	width:100%;
	}
	p,a,li,td,blockquote{
	mso-line-height-rule:exactly;
	}
	a[href^=tel],a[href^=sms]{
	color:inherit;
	cursor:default;
	text-decoration:none;
	}
	p,a,li,td,body,table,blockquote{
	-ms-text-size-adjust:100%;
	-webkit-text-size-adjust:100%;
	}
	.ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{
	line-height:100%;
	}
	a[x-apple-data-detectors]{
	color:inherit !important;
	text-decoration:none !important;
	font-size:inherit !important;
	font-family:inherit !important;
	font-weight:inherit !important;
	line-height:inherit !important;
	}
	.templateContainer{
	max-width:600px !important;
	}
	.endrImage{
	vertical-align:bottom;
	}
	.endrTextContent{
	word-break:break-word;
	padding-top:15px;
	padding-bottom:10px;
	padding-right:18px;
	padding-left:18px;
	text-align: left;
	}
	.endrTextContent img{
	height:auto !important;
	}
	.endrDividerBlock{
	table-layout:fixed !important;
	}
	body { margin:0 !important; }
	div[style*="margin: 16px 0"] { margin:0 !important; }

	body,#bodyTable{
	background-color:#e4e3e4;
	color:#999999;
	font-family: ''Amazon Ember'';
	}
	
	.templateBlocks{
	background-color:#FFFFFF;
	border-top-width:0;
	border-bottom-width:0;
	padding-top:0;
	padding-bottom:0;
	font-size:15px;
	line-height:185%;
	text-align:left;
	background-color:#FFFFFF;
	}
	
	.templateQuoteBlocks{
	background-color:#F04D44;
	}
	
	#bodyCell{
	border-top:0;
	}

	h1{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:30px;
	font-style:normal;
	font-weight:normal;
	line-height:120%;
	letter-spacing:normal;
	padding-top:2px;
	padding-bottom:2px;
	}

	a{
	color:#e74c3c;
	font-weight:normal;
	text-decoration:underline;
	}

	h2{
	color:#848484;
	font-family: ''Amazon Ember'';
	font-size:15px;
	font-style:normal;
	font-weight:normal;
	line-height:145%;
	letter-spacing:1px;
	padding-top:5px;
	padding-bottom:4px;
	}

	h3{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:140%;
	letter-spacing:normal;
	text-align:left;
	padding-top:2px;
	padding-bottom:2px;
	}

	h4{
	color:#666666;
	font-family: ''Amazon Ember'';
	font-size:16px;
	font-style:normal;
	font-weight:normal;
	line-height:125%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-bottom:4px;
	}

	h5{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	h6{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:26px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:right;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	#templatePreheader{
	border-top:0;
	border-bottom:0;
	padding-top:4px;
	padding-bottom:12px;
	}

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templatePreheader .endrTextContent a,#templatePreheader .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}

	#templateHeader{
	background-color:#303942;
	border-top:0px solid #e4e3e4;
	border-bottom:0;
	padding-top:0px;
	padding-bottom:0px;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent h1{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent a,#templateHeader .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:none;
	}

	#templateSeparator{
	padding-top:8px;
	padding-bottom:8px;
	}

	.templateLowerBody{
	background-color:#455C64;
	border-bottom:0;
	padding-top:1px;
	padding-bottom:1px;
	}

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:150%;
	text-align:left;
	}

	.templateLowerBody .endrTextContent a,.templateLowerBody .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:underline;
	}

	.templateLowerBody .endrTextContent h1 {
	color:#ffffff;
	font-weight:700;
	font-size:18px;
	}

	.templateSocial{
	background-color:#e4e3e4;
	padding-top:13px;
	padding-bottom:3px;
	}

	#templateFooter{
	border-top:0;
	border-bottom:0;
	padding-top:5px;
	padding-bottom:5px;
	}

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templateFooter .endrTextContent a,#templateFooter .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}
	
	@media only screen and (min-width:768px){
	.templateContainer{
	width:600px !important;
	}
	}	
	
	@media only screen and (max-width: 480px){
	
	.templateHeader{
		display: none;
	}
		
	.bigimage .endrImageContent{
	padding-top:0px !important;

	}
	.templateContainer{
	width:100% !important;
	max-width:600px;
	}	@media only screen and (max-width: 480px){
	body,table,td,p,a,li,blockquote{
	-webkit-text-size-adjust:none !important;
	}
	}	@media only screen and (max-width: 480px){
	body{
	width:100% !important;
	min-width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	#bodyCell{
	padding-top:10px !important;
	}
	}	@media only screen and (max-width: 480px){
	.columnWrapper{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImage{
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionTopContent,.endrCaptionBottomContent,.endrTextContentContainer,.endrBoxedTextContentContainer,.endrImageGroupContentContainer,.endrCaptionLeftTextContentContainer,.endrCaptionRightTextContentContainer,.endrCaptionLeftImageContentContainer,.endrCaptionRightImageContentContainer,.endrImageCardLeftTextContentContainer,.endrImageCardRightTextContentContainer{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrBoxedTextContentContainer{
	min-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.column{
	width:100% !important;
	max-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.endrImageGroupContent{
	padding:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionLeftContentOuter .endrTextContent,.endrCaptionRightContentOuter .endrTextContent{
	padding-top:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardTopImageContent,.endrCaptionBlockInner .endrCaptionTopContent:last-child .endrTextContent{
	padding-top:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardBottomImageContent{
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockInner{
	padding-top:0 !important;
	padding-bottom:0 !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockOuter{
	padding-top:9px !important;
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrTextContent,.endrBoxedTextContentColumn{
	padding-right:18px !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardLeftImageContent,.endrImageCardRightImageContent{
	padding-right:18px !important;
	padding-bottom:0 !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.mcpreview-image-uploader{
	display:none !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){

	h1{
	font-size:22px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h2{
	font-size:20px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h3{
	font-size:18px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h4{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){
	
	.endrBoxedTextContentContainer .endrTextContent,.endrBoxedTextContentContainer .endrTextContent p{
	font-size:14px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader{
	display:block !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	font-size:16px !important;
	line-height:100% !important;
	text-align:center !important;
	}

	#templateHeader .endrTextContent, #templateHeader .endrTextContent h1{
	font-size:20px !important;
	line-height:100% !important;
	padding-bottom:10px !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateUpperBody .endrTextContent,#templateUpperBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	
	}	@media only screen and (max-width: 480px){

	#templateColumns .columnContainer .endrTextContent,#templateColumns .columnContainer .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	text-align:center !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}
</style>

<!--[if mso]>
<style type="text/css">
body, table, td {font-family: ''Amazon Ember'';}
h1 {font-family: ''Amazon Ember'';}
h2 {font-family: ''Amazon Ember'';}
h3 {font-family: ''Amazon Ember'';}
h4 {font-family: ''Amazon Ember'';}
h5 {font-family: ''Amazon Ember'';}
h6 {font-family: ''Amazon Ember'';}
h7 {font-family: ''Amazon Ember'';}
p {font-family: ''Amazon Ember'';}
</style>
<![endif]-->

<!--[if gt mso 15]>
<style type="text/css" media="all">
/* Outlook 2016 Height Fix */
table, tr, td {border-collapse: collapse;}
tr {border-collapse: collapse; }
body {background-color:#ffffff;}
</style>
<![endif]-->    </head>

    <body>
        <center class="wrapper" style="width:100%;table-layout:fixed;background-color:#e4e3e4;">
  <div class="webkit" style="max-width:600px;margin:0 auto;">
      <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable" style="border-collapse:collapse;height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;width:100%;background-color:#e4e3e4;color:#5a5a5a;font-family:''Lato'', Helvetica, Arial, sans-serif;">
        <tbody><tr>
            <td align="center" valign="top" id="bodyCell" style="height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;width:100%;padding-top:10px;padding-bottom:10px;border-top-width:0;">
<!-- BEGIN TEMPLATE // -->
<!--[if (gte mso 9)|(IE)]>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;border-collapse:collapse;" >
	<tr>
	<td align="center" valign="top" width="600" style="width:600px;" >
		<![endif]-->
		<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-header>
		<tbody><tr>
		<td>
        <div style="display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';">
            Ship by: 12/01/2026, Standard Shipping
        </div>

        <!-- BLOCK Logo Center -->
 <table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" data-space-sc-header>
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
          <td class="templateHeader" valign="top" style="padding: 20px 0; padding-left:40px">
          <img align="center" alt="" src="https://m.media-amazon.com/images/G/01/SPACE/logo-selling_coach.png" width="200" style="max-width:200px;padding-bottom:0;display:inline !important;vertical-align:bottom;border-width:0;height:auto;outline-style:none;text-decoration:none;-ms-interpolation-mode:bicubic;">
          </td>
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
<!-- ENDR Header  -->


</td>
</tr>
</tbody></table>

<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;background-color:#ffffff;" bgcolor="#ffffff">
<tbody><tr>
<td>
        <table class="one-column">
            <tbody><tr valign="top" class="templateBlocks">
                <td valign="top">
                    <table class="endrTextBlock">
                        <tbody class="endrTextBlockOuter">
                            <tr>
                                <td valign="top" class="endrTextBlockInner">
                                    <table align="left" class="endrTextContentContainer">
                                        <tbody>
                                            <tr>
                                                <td valign="top" class="endrTextContent" align="center">
                                                    <p style="text-align:left;margin-top:10px;margin-bottom:10px;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;line-height:185%;">
                                                        

                                









            </p><div style="text-align:left">
                            
    
    
    <p>Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026.</p>

                            
                    <p>Please review your order:</p>
    
                <center>
                    <div style="margin: 20px 0px 20px 10px; padding:10px; display:inline-block; background-color:#006574;">
    <a style="color:#fff; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/f5e2e2d9-432c-3b83-b256-326b7c62e1e8?nt=SOLD_SHIP_NOW&amp;sk=AHOzFrrzs-XxwUBPl7YLOl2i-VwIc_FKcLh92v5n2nzK1v9pUmWzCwpIFrNmflDxVWjBoHH-rf6jahRB3XoOSQ&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9vcmRlcnMtdjMvb3JkZXIvNDA4LTU2MzE1NTQtNDE0NTkyNz9yZWZfPXh4X2VtYWlsX2JvZHlfc2hpcA">
        View Order
    </a>
</div>

                            <div style="margin: 20px 0px 20px 20px; padding:10px; display:inline-block; background-color:#e3eced;">
    <a style="color:#002f36; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/0ea79430-64f0-3e53-85bf-3e483143bc70?nt=SOLD_SHIP_NOW&amp;sk=zW3-wlorsqLRSsijseoDGTZ_aQC0z3XH68-sUXkDaOeHhTD52yiFvJhvHTX6IVjr2OIjy5-eA4HbqN53o2x9YA&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9oZWxwL2h1Yi9yZWZlcmVuY2UvRzIwMTM4MzM0MD9yZWZfPXh4X2VtYWlsX2JvZHlfaGVscA">
        Get Help Shipping Your Order
    </a>
</div>
    </center>
    <h3>Order Details</h3>
                                <b>Order ID:</b> 408-5631554-4145927
    <br>
                <b>Order date:</b> 10/01/2026
    <br>
                                        <b>Please ship this order using:</b> Standard Shipping
        <br>
                            <b>Collect on Delivery prepaid:</b> INR 0.00
        <br>
                            <b>Collect on Delivery amount:</b> INR 747.00
        <br>
        <br>
                                        
                                                    <b>Ship by:</b> 12/01/2026
            <br>
                                        <b>Item:</b> Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem &amp; Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop &amp; Professional Use
        <br>
                                                                    <b>Condition:</b> New
                    <br>
                                                                            <b>SKU:</b> Atom-999
        <br>
                                <b>Quantity:</b> 1
        <br>
                                            <b>Price:</b> INR 627.12
    <br>
                                                            <b>Tax:</b> INR 112.88
        <br>
                                                                                                                                                                                                                                                                                                                                                                                    <b>Amazon fees:</b> -INR 109.98
    <br>
                                                                                                                                                                                    <b>Collect on Delivery fees:</b> INR 5.93
        <br>
                                                
    
    
</div>
                                                    <p></p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody></table>


                

					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-footer data-space-sc-footer>
					<tbody><tr>
					<td>
				
					<!-- BLOCK Footer About Us -->
					<table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" dir="auto">
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<center style="margin-top: 20px;">
                        	<a style="padding: 7px 24px; text-decoration: none; background: #fff; border: 1px solid #EC937C; border-radius: 5px; color: #7F1809; font-family: ''Amazon Ember''; font-size: 13px; font-weight: 600;display: inline-block; margin-bottom: 10px" href="https://sellercentral.amazon.in/notifications/feedback?deliveryId=1125901523212061&amp;communicationName=SOLD_SHIP_NOW&amp;deliveryChannel=EMAIL">
                    <img src="https://m.media-amazon.com/images/G/01/space/icon.png" style="margin-right: 10px;vertical-align: middle;" width="20" height="20">Report an issue with this email
                  </a>
                        </center><p style="text-align:center !important;margin-top:10px;margin-bottom:10px;margin-right:10px;margin-left:15px;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;color:#ffffff;font-family:''Amazon Ember'';font-size:13px;line-height:150%;">If you have any questions visit: <a href="https://sellercentral.amazon.in/nms/sellermobile/redirect/4851d449-5876-3528-8262-c53615d9f28b?nt=SOLD_SHIP_NOW&amp;sk=fKrv1YYr_UHUCcoKdulOihaxRC_I3v8ShKc-6bWmD9HzdDTqguMlEbmTRvm6NsBxZzR52NUM7XjB6u0BvjV7Kg&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbg" metric="help" style="text-decoration: none; color: #ffffff;">Seller Central</a><br><br>
											    To change your email preferences visit: <a href="https://sellercentral.amazon.in/nms/redirect/4eac2fea-636e-3fc1-8119-5db2fd1ca6a7?nt=SOLD_SHIP_NOW&amp;sk=CXJK4dLwZZkSyGjKbXWzENp5WhZYa1vDxfe7yp1ZoAMDWBV2rBk11zj6M4HH21bDFleHrsxXymTKvqsA6KAtJQ&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL3JlZj1pZF9ub3RpZnByZWZfZG5hdl94eF8" metric="optout" style="text-decoration: none; color: #ffffff;">Notification Preferences</a><br><br>
																		We hope you found this message to be useful. However, if you''d rather not receive future e-mails of this sort from Amazon.com, please opt-out <a href="https://sellercentral.amazon.in/nms/redirect/bc82f548-5a52-3fd6-87f3-7e435c59635c?nt=SOLD_SHIP_NOW&amp;sk=QpaS4QUIfHxzDCfy0HZpXBAPSGwtnziB-sLoRMR2OYyQwjhPu-2M-3QVZ2zlbcU0wF33GDl2yZz2piQdjusudw&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL29wdG91dD9vcHRvdXRJZD04NzU1YThkOC1lYTc5LTRhMTctOGMxZS1kYmRlNGE0OGU1OGQ" metric="optout" style="text-decoration: none; color: #ffffff;">here.</a><br><br>
												Copyright  2026 Amazon, Inc, or its affiliates. All rights reserved.<br> 
												Amazon Seller Services Private Limited, 8th floor, Brigade Gateway, 26/1 Dr. Rajkumar Road, Bangalore 560055 (Karnataka)<br></p><table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
                        
                        
                        
											
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
					<!-- BLOCK Footer About Us -->
					</td>
					</tr>
					</tbody></table>
					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;">
					<tbody><tr>
					<td>
				
					</td>
					</tr>
					</tbody></table>
					<!--[if (gte mso 9)|(IE)]>
				</td>
				</tr>
			</table>
			<![endif]-->
			<!-- // END TEMPLATE -->
			</td>
		</tr>
		</tbody></table>    

</td></tr></tbody></table></div></center><img src="https://sellercentral.amazon.in/nms/img/41617c02-ffba-3753-b153-78883503d0fd?sk=eMDjsfVOKVEb4hTW-GDEeKc_-NEdgaXNShTxS2Vp1oKVEPOTlakbpabzQ3EsYkzkU8oZAQZ0tzDgt65BpqVyYA&amp;n=1">
<div id="spc-watermark">
  <p style="font-size: 10px !important;padding-bottom: 10px !important;display: table !important;margin: 5px auto 10px !important;text-align: center !important;color: #a2a2a2 !important;font-family: ''Amazon Ember'' !important;font-weight: 400 !important;">SPC-EUAmazon-1125901523212061</p>
</div></body></html>', '2026-01-10T19:18:25.000Z', '{"id":"19ba95877ddac2d8","threadId":"19ba74365c56df1b","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"Ship by: 12/01/2026, Standard Shipping Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026. Please review your order: View Order Get Help Shipping","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2413414pxc;        Sat, 10 Jan 2026 11:18:25 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IEKBI8HY3T2oa9IHjHvnJniP7UnZeVZ2DRrgQ/E8kjqnAFkSvGbfVjb0ryXYRmycTYw6r0w"},{"name":"X-Received","value":"by 2002:a05:6000:3106:b0:3ea:6680:8fb9 with SMTP id ffacd0b85a97d-432c362bf54mr16457341f8f.3.1768072705687;        Sat, 10 Jan 2026 11:18:25 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768072705; cv=none;        d=google.com; s=arc-20240605;        b=PkjvU5zyIE69Xdn9//f1xIKPvh/Yj/mm1xOCPkvW3dY/zBPNUTsQlsJ0oK83bcIleF         TRE6eRxzt0wi6W+DMAlz9flJj+XIEfNO6H//fCtfSrCcK+m3m1upMaIxc4gumb4bgDi/         g52tb5+ky6TRAdu5h0OdDuhi2sLbOiVRYsJfXJgNa1VAV60howWh7eoWvBgD+tyJ7Ev6         Y1A8N7CtzG7TPtxHKH5qDhp/lWaPq2YQeNaW56OaGxIlj2OAWksHDuCnEzC+CetqzSjh         bPLYLW8vprVf9XJ4g+n7DiebB/M4x8fTOW5jsr2YKQnbIW4xh3RkC70Nvua+bdagDgkd         McXA=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=feedback-id:list-unsubscribe-post:list-unsubscribe:bounces-to         :mime-version:subject:message-id:to:reply-to:from:date         :dkim-signature:dkim-signature;        bh=kJR4LZYlJNZ5aLbl8pCoEMfnJTtRzof0nHjcHN5fOls=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=D910QRF/Cwv54ozQEbWE+YW6FUp08CYhNHtbG8gmsydoFY2YqhK1RhJRo4DbIXQMjY         fFEuq5QxBTrxUnViP1eEhr5anMfVVE5q3rUl0F9gMDrqB3nP64KJMionSBMBlT21KyEX         cGNNsei/zppKEZDkcj7wzp+BsxSrE94mwtiHKXnb0eFH2XDnaIoTZY7t7IUK+riwctDC         bbu2ZWxtgbjgxGpf0IC6LyfZ9uSMNRJNg7rN1fryNXty4GX/PWQH5xy4TdIiarTpViYs         abMkL9wVnS4RWSK4y/hFF8l81yPAE83n0X/8jHrfW6bcbZgewVxsC2t8gi9DFH3OTzqD         tN5A==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=S6Ezk3Ha;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=RPeGv5k+;       spf=pass (google.com: domain of 0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com designates 76.223.149.205 as permitted sender) smtp.mailfrom=0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"Return-Path","value":"<0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com>"},{"name":"Received","value":"from c149-205.smtp-out.eu-west-1.amazonses.com (c149-205.smtp-out.eu-west-1.amazonses.com. [76.223.149.205])        by mx.google.com with ESMTPS id ffacd0b85a97d-432dd2a79e2si6466441f8f.582.2026.01.10.11.18.25        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Sat, 10 Jan 2026 11:18:25 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of 0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com designates 76.223.149.205 as permitted sender) client-ip=76.223.149.205;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=S6Ezk3Ha;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=RPeGv5k+;       spf=pass (google.com: domain of 0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com designates 76.223.149.205 as permitted sender) smtp.mailfrom=0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=oispgif7zht3cwr3nad5jndkl43aztnu; d=amazon.in; t=1768072705; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post; bh=OwHMSgiQf3cqUmwXqnJec8tkkKKo6tH5lXV/K8j9xw8=; b=S6Ezk3Ha0RoSBPv4kUy4pqc+Mnh1m8q4eL5itS9iUXYqXzCPRcSDy+CLhtDy1Jzh KlNJFMUkiYqnGcZffe5XiK7qsn+uCG86Hp+cVgtw+mxRGvb07isMl2TLCwlpX1pXutZ BZT4AZxuqEiyPmL/AwikUuY9TdANNlt8NrpYhxUjzbUN3yIvEzqe3SzdzwV++2CQfBQ VP7KDDjQVU0ycsskAekXnrCnfoK7yHCkI24yQL9fLGKHsFc9f9BOuWHLcnC/CYrzk3c V0BvKk6OwodO0XnLmtZtAz8sOJNC7AF4bRcpV3AMIzfZA4KW+dHF9YedjvRpizsqSoG FuvCbti5hQ=="},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768072705; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post:Feedback-ID; bh=OwHMSgiQf3cqUmwXqnJec8tkkKKo6tH5lXV/K8j9xw8=; b=RPeGv5k+D7BqYQO98Zfvmrz6eAHG4U5JsFV61hrXJUJiTIPOZsLugvWihM5uzVYK wOvmRAgniykiGHQB5FIoaBRT9ipEzF53ShrCTawcfH0NIFndymNkCyeR43m/QbhMdwn SvZEbXip+oGkTdBaN6VdJ+HVgM7RzIEdlO/bXekI="},{"name":"Date","value":"Sat, 10 Jan 2026 19:18:25 +0000"},{"name":"From","value":"Seller Notification <seller-notification@amazon.in>"},{"name":"Reply-To","value":"seller-notification@amazon.in"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Message-ID","value":"<0102019ba95874cc-c8b8d462-7733-471e-ae28-805b3a842bf9-000000@eu-west-1.amazonses.com>"},{"name":"Subject","value":"Sold, ship now: Atom-999 Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem & Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop & Professional Use"},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/alternative; boundary=\"----=_Part_1263744_1434303297.1768072705223\""},{"name":"Bounces-to","value":"RTE+NE-null-b1cb1A00063791Y393PU84LM3Q@sellernotifications.amazon.com"},{"name":"X-Space-Message-ID","value":"1125901523212061"},{"name":"X-Marketplace-ID","value":"A21TJRUUN4KGV"},{"name":"List-Unsubscribe","value":"<https://sellercentral.amazon.in/notifications/preferences/optout/header-one-click?optoutId=8755a8d8-ea79-4a17-8c1e-dbde4a48e58d>"},{"name":"List-Unsubscribe-Post","value":"List-Unsubscribe=One-Click"},{"name":"Feedback-ID","value":"::1.eu-west-1.QXQDwfZxBksRk8Fey1ctk1ELdO+bec9bLwquzardhBQ=:AmazonSES"},{"name":"X-SES-Outgoing","value":"2026.01.10-76.223.149.205"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"7bit"}],"body":{"size":31284,"data":"PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg0KPGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zOnY9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206dm1sIiB4bWxuczpvPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTpvZmZpY2UiPg0KDQogICAgPGhlYWQ-DQogICAgICAgIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4NCiAgICAgICAgDQoNCjwhLS1baWYgZ3RlIG1zbyAxNV0-DQo8eG1sPg0KCTxvOk9mZmljZURvY3VtZW50U2V0dGluZ3M-DQoJPG86QWxsb3dQTkcvPg0KCTxvOlBpeGVsc1BlckluY2g-OTY8L286UGl4ZWxzUGVySW5jaD4NCgk8L286T2ZmaWNlRG9jdW1lbnRTZXR0aW5ncz4NCjwveG1sPg0KPCFbZW5kaWZdLS0-DQo8bWV0YSBjaGFyc2V0PSJVVEYtOCI-DQo8IS0tW2lmICFtc29dPjwhLS0-DQoJCTxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSI-DQoJPCEtLTwhW2VuZGlmXS0tPg0KPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIj4NCjx0aXRsZT48L3RpdGxlPg0KPGxpbmsgaHJlZj0iaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TGF0bzo0MDAsNzAwIiByZWw9InN0eWxlc2hlZXQiIHR5cGU9InRleHQvY3NzIj4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQoJDQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogbm9ybWFsOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0JyksIGxvY2FsKCdBbWF6b25FbWJlci1MaWdodCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9sdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0IEl0YWxpYycpLCBsb2NhbCgnQW1hem9uRW1iZXItTGlnaHRJdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbHRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0aXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXInKSwgbG9jYWwoJ0FtYXpvbkVtYmVyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnX2Jhc2Uud29mZjIpIGZvcm1hdCgnd29mZjInKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBpdGFsaWM7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDYwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgTWVkaXVtJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW0nKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9tZF9iYXNlLndvZmYpIGZvcm1hdCgnd29mZicpOw0KfQ0KQGZvbnQtZmFjZSB7DQogICAgZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KICAgIGZvbnQtc3R5bGU6IGl0YWxpYzsNCiAgICBmb250LXdlaWdodDogNjAwOw0KICAgIHNyYzogbG9jYWwoJ0FtYXpvbiBFbWJlciBNZWRpdW0gSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX21kaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDcwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgQm9sZCcpLCBsb2NhbCgnQW1hem9uRW1iZXItQm9sZCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkX2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiA3MDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIEJvbGQgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1Cb2xkSXRhbGljJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkaXRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZGl0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQoNCg0KDQoJLm5idXMtc3VydmV5e2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJLm5idXMtc3VydmV5OnZpc2l0ZWR7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6aG92ZXJ7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6Zm9jdXN7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6YWN0aXZle2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJDQoJb25lLWNvbHVtbntib3JkZXItc3BhY2luZzowcHg7YmFja2dyb3VuZC1jb2xvcjojRkZGRkZGO2JvcmRlcjowcHg7cGFkZGluZzowcHg7d2lkdGg6MTAwJTtjb2x1bW4tY291bnQ6MTt9DQoJZW5kckltYWdlQmxvY2t7cGFkZGluZzowcHg7Ym9yZGVyLXNwYWNpbmc6MHB4O21pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTt3aWR0aDoxMDAlO2JvcmRlcjowcHg7fQ0KCWVuZHJJbWFnZUJsb2NrSW5uZXJ7cGFkZGluZzowcHg7fQ0KCWVuZHJJbWFnZUNvbnRlbnRDb250YWluZXJ7YWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7bWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO3dpZHRoOjEwMCU7Ym9yZGVyOjBweDt9DQoJZW5kclRleHRDb250ZW50Q29udGFpbmVye21pbi13aWR0aDoxMDAlO3dpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO2JhY2tncm91bmQtY29sb3I6I0ZGRkZGRjtib3JkZXI6MHB4O3BhZGRpbmc6MHB4O2JvcmRlci1zcGFjaW5nOjBweDt9DQoJZW5kclRleHRCbG9ja3ttaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO3dpZHRoOjEwMCVwYWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7Ym9yZGVyOjBweDt9DQoJcHJldmlldy10ZXh0e2Rpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQoJDQoJcHsNCgl0ZXh0LWFsaWduOiBsZWZ0Ow0KCW1hcmdpbi10b3A6MTBweDsNCgltYXJnaW4tYm90dG9tOjEwcHg7DQoJbWFyZ2luLXJpZ2h0OjA7DQoJbWFyZ2luLWxlZnQ6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJcGFkZGluZy1yaWdodDowOw0KCXBhZGRpbmctbGVmdDowOw0KCWxpbmUtaGVpZ2h0OjE4NSU7DQoJfQ0KCXRhYmxlew0KCWJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsNCgl9DQoJaDEsaDIsaDMsaDQsaDUsaDZ7DQoJZGlzcGxheTpibG9jazsNCgltYXJnaW46MDsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZyxhIGltZ3sNCglib3JkZXI6MDsNCgloZWlnaHQ6YXV0bzsNCglvdXRsaW5lOm5vbmU7DQoJdGV4dC1kZWNvcmF0aW9uOm5vbmU7DQoJfQ0KCXByZXsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJZm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7DQoJbWluLXdpZHRoOjEwMCU7DQoJd2hpdGUtc3BhY2U6IHByZS13cmFwOyAgICAgICAvKiBTaW5jZSBDU1MgMi4xICovDQogICAgd2hpdGUtc3BhY2U6IC1tb3otcHJlLXdyYXA7ICAvKiBNb3ppbGxhLCBzaW5jZSAxOTk5ICovDQogICAgd2hpdGUtc3BhY2U6IC1wcmUtd3JhcDsgICAgICAvKiBPcGVyYSA0LTYgKi8NCiAgICB3aGl0ZS1zcGFjZTogLW8tcHJlLXdyYXA7ICAgIC8qIE9wZXJhIDcgKi8NCiAgICB3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7ICAgICAgIC8qIEludGVybmV0IEV4cGxvcmVyIDUuNSsgKi8NCgl9DQoJYm9keSwjYm9keVRhYmxlLCNib2R5Q2VsbHsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCWNvbG9yOiM5OTk5OTkNCglmb250LWZhbWlseTonQW1hem9uIEVtYmVyJzsNCgltaW4td2lkdGg6MTAwJTsNCgl9DQoJI291dGxvb2sgYXsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZ3sNCgktbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7DQoJfQ0KCXRhYmxlew0KCW1zby10YWJsZS1sc3BhY2U6MHB0Ow0KCW1zby10YWJsZS1yc3BhY2U6MHB0Ow0KCX0NCgkuUmVhZE1zZ0JvZHl7DQoJd2lkdGg6MTAwJTsNCgl9DQoJLkV4dGVybmFsQ2xhc3N7DQoJd2lkdGg6MTAwJTsNCgl9DQoJcCxhLGxpLHRkLGJsb2NrcXVvdGV7DQoJbXNvLWxpbmUtaGVpZ2h0LXJ1bGU6ZXhhY3RseTsNCgl9DQoJYVtocmVmXj10ZWxdLGFbaHJlZl49c21zXXsNCgljb2xvcjppbmhlcml0Ow0KCWN1cnNvcjpkZWZhdWx0Ow0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCglwLGEsbGksdGQsYm9keSx0YWJsZSxibG9ja3F1b3Rlew0KCS1tcy10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJfQ0KCS5FeHRlcm5hbENsYXNzLC5FeHRlcm5hbENsYXNzIHAsLkV4dGVybmFsQ2xhc3MgdGQsLkV4dGVybmFsQ2xhc3MgZGl2LC5FeHRlcm5hbENsYXNzIHNwYW4sLkV4dGVybmFsQ2xhc3MgZm9udHsNCglsaW5lLWhlaWdodDoxMDAlOw0KCX0NCglhW3gtYXBwbGUtZGF0YS1kZXRlY3RvcnNdew0KCWNvbG9yOmluaGVyaXQgIWltcG9ydGFudDsNCgl0ZXh0LWRlY29yYXRpb246bm9uZSAhaW1wb3J0YW50Ow0KCWZvbnQtc2l6ZTppbmhlcml0ICFpbXBvcnRhbnQ7DQoJZm9udC1mYW1pbHk6aW5oZXJpdCAhaW1wb3J0YW50Ow0KCWZvbnQtd2VpZ2h0OmluaGVyaXQgIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDppbmhlcml0ICFpbXBvcnRhbnQ7DQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgltYXgtd2lkdGg6NjAwcHggIWltcG9ydGFudDsNCgl9DQoJLmVuZHJJbWFnZXsNCgl2ZXJ0aWNhbC1hbGlnbjpib3R0b207DQoJfQ0KCS5lbmRyVGV4dENvbnRlbnR7DQoJd29yZC1icmVhazpicmVhay13b3JkOw0KCXBhZGRpbmctdG9wOjE1cHg7DQoJcGFkZGluZy1ib3R0b206MTBweDsNCglwYWRkaW5nLXJpZ2h0OjE4cHg7DQoJcGFkZGluZy1sZWZ0OjE4cHg7DQoJdGV4dC1hbGlnbjogbGVmdDsNCgl9DQoJLmVuZHJUZXh0Q29udGVudCBpbWd7DQoJaGVpZ2h0OmF1dG8gIWltcG9ydGFudDsNCgl9DQoJLmVuZHJEaXZpZGVyQmxvY2t7DQoJdGFibGUtbGF5b3V0OmZpeGVkICFpbXBvcnRhbnQ7DQoJfQ0KCWJvZHkgeyBtYXJnaW46MCAhaW1wb3J0YW50OyB9DQoJZGl2W3N0eWxlKj0ibWFyZ2luOiAxNnB4IDAiXSB7IG1hcmdpbjowICFpbXBvcnRhbnQ7IH0NCg0KCWJvZHksI2JvZHlUYWJsZXsNCgliYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7DQoJY29sb3I6Izk5OTk5OTsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJfQ0KCQ0KCS50ZW1wbGF0ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGRkZGRkY7DQoJYm9yZGVyLXRvcC13aWR0aDowOw0KCWJvcmRlci1ib3R0b20td2lkdGg6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJZm9udC1zaXplOjE1cHg7DQoJbGluZS1oZWlnaHQ6MTg1JTsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJYmFja2dyb3VuZC1jb2xvcjojRkZGRkZGOw0KCX0NCgkNCgkudGVtcGxhdGVRdW90ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGMDRENDQ7DQoJfQ0KCQ0KCSNib2R5Q2VsbHsNCglib3JkZXItdG9wOjA7DQoJfQ0KDQoJaDF7DQoJY29sb3I6IzQ1NWM2NDsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjMwcHg7DQoJZm9udC1zdHlsZTpub3JtYWw7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCWxpbmUtaGVpZ2h0OjEyMCU7DQoJbGV0dGVyLXNwYWNpbmc6bm9ybWFsOw0KCXBhZGRpbmctdG9wOjJweDsNCglwYWRkaW5nLWJvdHRvbToycHg7DQoJfQ0KDQoJYXsNCgljb2xvcjojZTc0YzNjOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCWgyew0KCWNvbG9yOiM4NDg0ODQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxNXB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDUlOw0KCWxldHRlci1zcGFjaW5nOjFweDsNCglwYWRkaW5nLXRvcDo1cHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWgzew0KCWNvbG9yOiM0NTVjNjQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDAlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MnB4Ow0KCXBhZGRpbmctYm90dG9tOjJweDsNCgl9DQoNCgloNHsNCgljb2xvcjojNjY2NjY2Ow0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTZweDsNCglmb250LXN0eWxlOm5vcm1hbDsNCglmb250LXdlaWdodDpub3JtYWw7DQoJbGluZS1oZWlnaHQ6MTI1JTsNCglsZXR0ZXItc3BhY2luZzpub3JtYWw7DQoJdGV4dC1hbGlnbjpsZWZ0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWg1ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MTFweDsNCglwYWRkaW5nLXJpZ2h0OjIwcHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCXBhZGRpbmctbGVmdDoyMHB4Ow0KCX0NCg0KCWg2ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyNnB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1yaWdodDoyMHB4Ow0KCXBhZGRpbmctYm90dG9tOjhweDsNCglwYWRkaW5nLWxlZnQ6MjBweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXJ7DQoJYm9yZGVyLXRvcDowOw0KCWJvcmRlci1ib3R0b206MDsNCglwYWRkaW5nLXRvcDo0cHg7DQoJcGFkZGluZy1ib3R0b206MTJweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxMnB4Ow0KCWxpbmUtaGVpZ2h0OjE1MCU7DQoJdGV4dC1hbGlnbjpjZW50ZXI7DQoJfQ0KDQoJI3RlbXBsYXRlUHJlaGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgYSwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwIGF7DQoJY29sb3I6I2ZiZmJmYjsNCglmb250LXdlaWdodDpub3JtYWw7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsNCgl9DQoNCgkjdGVtcGxhdGVIZWFkZXJ7DQoJYmFja2dyb3VuZC1jb2xvcjojMzAzOTQyOw0KCWJvcmRlci10b3A6MHB4IHNvbGlkICNlNGUzZTQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjBweDsNCglwYWRkaW5nLWJvdHRvbTowcHg7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxMDAlOw0KCXRleHQtYWxpZ246cmlnaHQ7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgaDF7DQoJY29sb3I6I2ZmZmZmZjsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjIwcHg7DQoJbGluZS1oZWlnaHQ6MTAwJTsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCg0KCSN0ZW1wbGF0ZVNlcGFyYXRvcnsNCglwYWRkaW5nLXRvcDo4cHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keXsNCgliYWNrZ3JvdW5kLWNvbG9yOiM0NTVDNjQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjFweDsNCglwYWRkaW5nLWJvdHRvbToxcHg7DQoJfQ0KDQoJLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQsLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246bGVmdDsNCgl9DQoNCgkudGVtcGxhdGVMb3dlckJvZHkgLmVuZHJUZXh0Q29udGVudCBhLC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHAgYXsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IGgxIHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0OjcwMDsNCglmb250LXNpemU6MThweDsNCgl9DQoNCgkudGVtcGxhdGVTb2NpYWx7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCXBhZGRpbmctdG9wOjEzcHg7DQoJcGFkZGluZy1ib3R0b206M3B4Ow0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlcnsNCglib3JkZXItdG9wOjA7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjVweDsNCglwYWRkaW5nLWJvdHRvbTo1cHg7DQoJfQ0KDQoJI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmJmYmZiOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTJweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246Y2VudGVyOw0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7DQoJfQ0KCQ0KCUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDo3NjhweCl7DQoJLnRlbXBsYXRlQ29udGFpbmVyew0KCXdpZHRoOjYwMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JDQoJDQoJQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLnRlbXBsYXRlSGVhZGVyew0KCQlkaXNwbGF5OiBub25lOw0KCX0NCgkJDQoJLmJpZ2ltYWdlIC5lbmRySW1hZ2VDb250ZW50ew0KCXBhZGRpbmctdG9wOjBweCAhaW1wb3J0YW50Ow0KDQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgl3aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJbWF4LXdpZHRoOjYwMHB4Ow0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJYm9keSx0YWJsZSx0ZCxwLGEsbGksYmxvY2txdW90ZXsNCgktd2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6bm9uZSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCWJvZHl7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCW1pbi13aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJI2JvZHlDZWxsew0KCXBhZGRpbmctdG9wOjEwcHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uV3JhcHBlcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25Ub3BDb250ZW50LC5lbmRyQ2FwdGlvbkJvdHRvbUNvbnRlbnQsLmVuZHJUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJJbWFnZUdyb3VwQ29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0VGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJDYXB0aW9uUmlnaHRUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRyQ2FwdGlvblJpZ2h0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkTGVmdFRleHRDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkUmlnaHRUZXh0Q29udGVudENvbnRhaW5lcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXJ7DQoJbWluLXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfSBAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9IEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VHcm91cENvbnRlbnR7DQoJcGFkZGluZzo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25MZWZ0Q29udGVudE91dGVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJDYXB0aW9uUmlnaHRDb250ZW50T3V0ZXIgLmVuZHJUZXh0Q29udGVudHsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZFRvcEltYWdlQ29udGVudCwuZW5kckNhcHRpb25CbG9ja0lubmVyIC5lbmRyQ2FwdGlvblRvcENvbnRlbnQ6bGFzdC1jaGlsZCAuZW5kclRleHRDb250ZW50ew0KCXBhZGRpbmctdG9wOjE4cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZEJvdHRvbUltYWdlQ29udGVudHsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlR3JvdXBCbG9ja0lubmVyew0KCXBhZGRpbmctdG9wOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTowICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJLmVuZHJJbWFnZUdyb3VwQmxvY2tPdXRlcnsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kclRleHRDb250ZW50LC5lbmRyQm94ZWRUZXh0Q29udGVudENvbHVtbnsNCglwYWRkaW5nLXJpZ2h0OjE4cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VDYXJkTGVmdEltYWdlQ29udGVudCwuZW5kckltYWdlQ2FyZFJpZ2h0SW1hZ2VDb250ZW50ew0KCXBhZGRpbmctcmlnaHQ6MThweCAhaW1wb3J0YW50Ow0KCXBhZGRpbmctYm90dG9tOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5tY3ByZXZpZXctaW1hZ2UtdXBsb2FkZXJ7DQoJZGlzcGxheTpub25lICFpbXBvcnRhbnQ7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDF7DQoJZm9udC1zaXplOjIycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxMjUlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgloMnsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEyNSUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCWgzew0KCWZvbnQtc2l6ZToxOHB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTI1JSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDR7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTRweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZVByZWhlYWRlcnsNCglkaXNwbGF5OmJsb2NrICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxMnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCgl0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50LCAjdGVtcGxhdGVIZWFkZXIgLmVuZHJUZXh0Q29udGVudCBoMXsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbToxMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxNnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgkNCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50LC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJdGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50LCN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjEycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0NCjwvc3R5bGU-DQoNCjwhLS1baWYgbXNvXT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQpib2R5LCB0YWJsZSwgdGQge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoMSB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmgyIHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDMge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNCB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmg1IHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDYge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNyB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCnAge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQo8L3N0eWxlPg0KPCFbZW5kaWZdLS0-DQoNCjwhLS1baWYgZ3QgbXNvIDE1XT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgbWVkaWE9ImFsbCI-DQovKiBPdXRsb29rIDIwMTYgSGVpZ2h0IEZpeCAqLw0KdGFibGUsIHRyLCB0ZCB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTt9DQp0ciB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgfQ0KYm9keSB7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO30NCjwvc3R5bGU-DQo8IVtlbmRpZl0tLT4gICAgPC9oZWFkPg0KDQogICAgPGJvZHk-DQogICAgICAgIDxjZW50ZXIgY2xhc3M9IndyYXBwZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO3RhYmxlLWxheW91dDpmaXhlZDtiYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7Ij4NCiAgPGRpdiBjbGFzcz0id2Via2l0IiBzdHlsZT0ibWF4LXdpZHRoOjYwMHB4O21hcmdpbjowIGF1dG87Ij4NCiAgICAgIDx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgaGVpZ2h0PSIxMDAlIiB3aWR0aD0iMTAwJSIgaWQ9ImJvZHlUYWJsZSIgc3R5bGU9ImJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTtoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDt3aWR0aDoxMDAlO2JhY2tncm91bmQtY29sb3I6I2U0ZTNlNDtjb2xvcjojNWE1YTVhO2ZvbnQtZmFtaWx5OidMYXRvJywgSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsiPg0KICAgICAgICA8dGJvZHk-PHRyPg0KICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiBpZD0iYm9keUNlbGwiIHN0eWxlPSJoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7d2lkdGg6MTAwJTtwYWRkaW5nLXRvcDoxMHB4O3BhZGRpbmctYm90dG9tOjEwcHg7Ym9yZGVyLXRvcC13aWR0aDowOyI-DQo8IS0tIEJFR0lOIFRFTVBMQVRFIC8vIC0tPg0KPCEtLVtpZiAoZ3RlIG1zbyA5KXwoSUUpXT4NCjx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgd2lkdGg9IjYwMCIgc3R5bGU9IndpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiID4NCgk8dHI-DQoJPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiB3aWR0aD0iNjAwIiBzdHlsZT0id2lkdGg6NjAwcHg7IiA-DQoJCTwhW2VuZGlmXS0tPg0KCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGRhdGEtc3BhY2UtaGVhZGVyPg0KCQk8dGJvZHk-PHRyPg0KCQk8dGQ-DQogICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsiPg0KICAgICAgICAgICAgU2hpcCBieTogMTIvMDEvMjAyNiwgU3RhbmRhcmQgU2hpcHBpbmcNCiAgICAgICAgPC9kaXY-DQoNCiAgICAgICAgPCEtLSBCTE9DSyBMb2dvIENlbnRlciAtLT4NCiA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjA7IiBkYXRhLXNwYWNlLXNjLWhlYWRlcj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICA8dGQgY2xhc3M9InRlbXBsYXRlSGVhZGVyIiB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6IDIwcHggMDsgcGFkZGluZy1sZWZ0OjQwcHgiPg0KICAgICAgICAgIDxpbWcgYWxpZ249ImNlbnRlciIgYWx0PSIiIHNyYz0iaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvU1BBQ0UvbG9nby1zZWxsaW5nX2NvYWNoLnBuZyIgd2lkdGg9IjIwMCIgc3R5bGU9Im1heC13aWR0aDoyMDBweDtwYWRkaW5nLWJvdHRvbTowO2Rpc3BsYXk6aW5saW5lICFpbXBvcnRhbnQ7dmVydGljYWwtYWxpZ246Ym90dG9tO2JvcmRlci13aWR0aDowO2hlaWdodDphdXRvO291dGxpbmUtc3R5bGU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTstbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7Ij4NCiAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCjwhLS0gRU5EUiBIZWFkZXIgIC0tPg0KDQoNCjwvdGQ-DQo8L3RyPg0KPC90Ym9keT48L3RhYmxlPg0KDQo8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmOyIgYmdjb2xvcj0iI2ZmZmZmZiI-DQo8dGJvZHk-PHRyPg0KPHRkPg0KICAgICAgICA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iPg0KICAgICAgICAgICAgPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlQmxvY2tzIj4NCiAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiPg0KICAgICAgICAgICAgICAgICAgICA8dGFibGUgY2xhc3M9ImVuZHJUZXh0QmxvY2siPg0KICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5IGNsYXNzPSJlbmRyVGV4dEJsb2NrT3V0ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0iZW5kclRleHRCbG9ja0lubmVyIj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0YWJsZSBhbGlnbj0ibGVmdCIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnQiIGFsaWduPSJjZW50ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7bWFyZ2luLXRvcDoxMHB4O21hcmdpbi1ib3R0b206MTBweDttYXJnaW4tcmlnaHQ6MDttYXJnaW4tbGVmdDowO3BhZGRpbmctdG9wOjA7cGFkZGluZy1ib3R0b206MDtwYWRkaW5nLXJpZ2h0OjA7cGFkZGluZy1sZWZ0OjA7bGluZS1oZWlnaHQ6MTg1JTsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KDQoNCg0KDQoNCg0KDQoNCiAgICAgICAgICAgIDwvcD48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgIA0KICAgIA0KICAgIDxwPkNvbmdyYXR1bGF0aW9ucywgeW91IGhhdmUgYSBuZXcgb3JkZXIgb24gQW1hem9uISBZb3VyIGN1c3RvbWVyIGlzIGV4cGVjdGluZyB0aGlzIHRvIHNoaXAgYnkgMTIvMDEvMjAyNi48L3A-DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgPHA-UGxlYXNlIHJldmlldyB5b3VyIG9yZGVyOjwvcD4NCiAgICANCiAgICAgICAgICAgICAgICA8Y2VudGVyPg0KICAgICAgICAgICAgICAgICAgICA8ZGl2IHN0eWxlPSJtYXJnaW46IDIwcHggMHB4IDIwcHggMTBweDsgcGFkZGluZzoxMHB4OyBkaXNwbGF5OmlubGluZS1ibG9jazsgYmFja2dyb3VuZC1jb2xvcjojMDA2NTc0OyI-DQogICAgPGEgc3R5bGU9ImNvbG9yOiNmZmY7IHRleHQtZGVjb3JhdGlvbjpub25lOyIgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvc2VsbGVybW9iaWxlL3JlZGlyZWN0L2Y1ZTJlMmQ5LTQzMmMtM2I4My1iMjU2LTMyNmI3YzYyZTFlOD9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1BSE96RnJyenMtWHh3VUJQbDdZTE9sMmktVndJY19GS2NMaDkydjVuMm56SzF2OXBVbVd6Q3dwSUZyTm1mbER4VldqQm9ISC1yZjZqYWhSQjNYb09TUSZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl2Y21SbGNuTXRkak12YjNKa1pYSXZOREE0TFRVMk16RTFOVFF0TkRFME5Ua3lOejl5WldaZlBYaDRYMlZ0WVdsc1gySnZaSGxmYzJocGNBIj4NCiAgICAgICAgVmlldyBPcmRlcg0KICAgIDwvYT4NCjwvZGl2Pg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luOiAyMHB4IDBweCAyMHB4IDIwcHg7IHBhZGRpbmc6MTBweDsgZGlzcGxheTppbmxpbmUtYmxvY2s7IGJhY2tncm91bmQtY29sb3I6I2UzZWNlZDsiPg0KICAgIDxhIHN0eWxlPSJjb2xvcjojMDAyZjM2OyB0ZXh0LWRlY29yYXRpb246bm9uZTsiIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC8wZWE3OTQzMC02NGYwLTNlNTMtODViZi0zZTQ4MzE0M2JjNzA_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9elczLXdsb3JzcUxSU3NpanNlb0RHVFpfYVFDMHozWEg2OC1zVVhrRGFPZUhoVEQ1MnlpRnZKaHZIVFg2SVZqcjJPSWp5NS1lQTRIYnFONTNvMng5WUEmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5b1pXeHdMMmgxWWk5eVpXWmxjbVZ1WTJVdlJ6SXdNVE00TXpNME1EOXlaV1pmUFhoNFgyVnRZV2xzWDJKdlpIbGZhR1ZzY0EiPg0KICAgICAgICBHZXQgSGVscCBTaGlwcGluZyBZb3VyIE9yZGVyDQogICAgPC9hPg0KPC9kaXY-DQogICAgPC9jZW50ZXI-DQogICAgPGgzPk9yZGVyIERldGFpbHM8L2gzPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5PcmRlciBJRDo8L2I-IDQwOC01NjMxNTU0LTQxNDU5MjcNCiAgICA8YnI-DQogICAgICAgICAgICAgICAgPGI-T3JkZXIgZGF0ZTo8L2I-IDEwLzAxLzIwMjYNCiAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UGxlYXNlIHNoaXAgdGhpcyBvcmRlciB1c2luZzo8L2I-IFN0YW5kYXJkIFNoaXBwaW5nDQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db2xsZWN0IG9uIERlbGl2ZXJ5IHByZXBhaWQ6PC9iPiBJTlIgMC4wMA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-Q29sbGVjdCBvbiBEZWxpdmVyeSBhbW91bnQ6PC9iPiBJTlIgNzQ3LjAwDQogICAgICAgIDxicj4NCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNoaXAgYnk6PC9iPiAxMi8wMS8yMDI2DQogICAgICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-SXRlbTo8L2I-IEdyaXBpdCBEaWdpdGFsIEpld2VsbGVyeSBXZWlnaGluZyBTY2FsZSAxMDAwZyB4IDAuMDFnIC0gUG9ydGFibGUgR29sZCwgU2lsdmVyLCBHZW0gJmFtcDsgQ29pbiBXZWlnaGluZyBNYWNoaW5lIHdpdGggTENEIERpc3BsYXkgLSBQcmVjaXNpb24gV2VpZ2h0IFNjYWxlIGZvciBIb21lLCBTaG9wICZhbXA7IFByb2Zlc3Npb25hbCBVc2UNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db25kaXRpb246PC9iPiBOZXcNCiAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNLVTo8L2I-IEF0b20tOTk5DQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UXVhbnRpdHk6PC9iPiAxDQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UHJpY2U6PC9iPiBJTlIgNjI3LjEyDQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-VGF4OjwvYj4gSU5SIDExMi44OA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5BbWF6b24gZmVlczo8L2I-IC1JTlIgMTA5Ljk4DQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-Q29sbGVjdCBvbiBEZWxpdmVyeSBmZWVzOjwvYj4gSU5SIDUuOTMNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgDQogICAgDQo8L2Rpdj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cD48L3A-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgIDwvdGQ-DQogICAgICAgICAgICA8L3RyPg0KICAgICAgICA8L3Rib2R5PjwvdGFibGU-DQoNCg0KICAgICAgICAgICAgICAgIA0KDQoJCQkJCQ0KCQkJCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7IiBkYXRhLXNwYWNlLWZvb3RlciBkYXRhLXNwYWNlLXNjLWZvb3Rlcj4NCgkJCQkJPHRib2R5Pjx0cj4NCgkJCQkJPHRkPg0KCQkJCQ0KCQkJCQk8IS0tIEJMT0NLIEZvb3RlciBBYm91dCBVcyAtLT4NCgkJCQkJPHRhYmxlIGNsYXNzPSJvbmUtY29sdW1uIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3JkZXItc3BhY2luZzowOyIgZGlyPSJhdXRvIj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8Y2VudGVyIHN0eWxlPSJtYXJnaW4tdG9wOiAyMHB4OyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPGEgc3R5bGU9InBhZGRpbmc6IDdweCAyNHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGJhY2tncm91bmQ6ICNmZmY7IGJvcmRlcjogMXB4IHNvbGlkICNFQzkzN0M7IGJvcmRlci1yYWRpdXM6IDVweDsgY29sb3I6ICM3RjE4MDk7IGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsgZm9udC1zaXplOiAxM3B4OyBmb250LXdlaWdodDogNjAwO2Rpc3BsYXk6IGlubGluZS1ibG9jazsgbWFyZ2luLWJvdHRvbTogMTBweCIgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL2ZlZWRiYWNrP2RlbGl2ZXJ5SWQ9MTEyNTkwMTUyMzIxMjA2MSZhbXA7Y29tbXVuaWNhdGlvbk5hbWU9U09MRF9TSElQX05PVyZhbXA7ZGVsaXZlcnlDaGFubmVsPUVNQUlMIj4NCiAgICAgICAgICAgICAgICAgICAgPGltZyBzcmM9Imh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL3NwYWNlL2ljb24ucG5nIiBzdHlsZT0ibWFyZ2luLXJpZ2h0OiAxMHB4O3ZlcnRpY2FsLWFsaWduOiBtaWRkbGU7IiB3aWR0aD0iMjAiIGhlaWdodD0iMjAiPlJlcG9ydCBhbiBpc3N1ZSB3aXRoIHRoaXMgZW1haWwNCiAgICAgICAgICAgICAgICAgIDwvYT4NCiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2VudGVyPjxwIHN0eWxlPSJ0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50O21hcmdpbi10b3A6MTBweDttYXJnaW4tYm90dG9tOjEwcHg7bWFyZ2luLXJpZ2h0OjEwcHg7bWFyZ2luLWxlZnQ6MTVweDtwYWRkaW5nLXRvcDowO3BhZGRpbmctYm90dG9tOjA7cGFkZGluZy1yaWdodDowO3BhZGRpbmctbGVmdDowO2NvbG9yOiNmZmZmZmY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTsiPklmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMgdmlzaXQ6IDxhIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC80ODUxZDQ0OS01ODc2LTM1MjgtODI2Mi1jNTM2MTVkOWYyOGI_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9ZktydjFZWXJfVUhVQ2NvS2R1bE9paGF4UkNfSTN2OFNoS2MtNmJXbUQ5SHpkRFRxZ3VNbEVibVRSdm02TnNCeFp6UjUyTlVNN1hqQjZ1MEJ2alY3S2cmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmciIG1ldHJpYz0iaGVscCIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgY29sb3I6ICNmZmZmZmY7Ij5TZWxsZXIgQ2VudHJhbDwvYT48YnI-PGJyPg0KCQkJCQkJCQkJCQkgICAgVG8gY2hhbmdlIHlvdXIgZW1haWwgcHJlZmVyZW5jZXMgdmlzaXQ6IDxhIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3JlZGlyZWN0LzRlYWMyZmVhLTYzNmUtM2ZjMS04MTE5LTVkYjJmZDFjYTZhNz9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1DWEpLNGRMd1paa1N5R2pLYlhXekVOcDVXaFpZYTF2RHhmZTd5cDFab0FNRFdCVjJyQmsxMXpqNk00SEgyMWJERmxlSHJzeFh5bVRLdnFzQTZLQXRKUSZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl1YjNScFptbGpZWFJwYjI1ekwzQnlaV1psY21WdVkyVnpMM0psWmoxcFpGOXViM1JwWm5CeVpXWmZaRzVoZGw5NGVGOCIgbWV0cmljPSJvcHRvdXQiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjZmZmZmZmOyI-Tm90aWZpY2F0aW9uIFByZWZlcmVuY2VzPC9hPjxicj48YnI-DQoJCQkJCQkJCQkJCQkJCQkJCQlXZSBob3BlIHlvdSBmb3VuZCB0aGlzIG1lc3NhZ2UgdG8gYmUgdXNlZnVsLiBIb3dldmVyLCBpZiB5b3UnZCByYXRoZXIgbm90IHJlY2VpdmUgZnV0dXJlIGUtbWFpbHMgb2YgdGhpcyBzb3J0IGZyb20gQW1hem9uLmNvbSwgcGxlYXNlIG9wdC1vdXQgPGEgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvcmVkaXJlY3QvYmM4MmY1NDgtNWE1Mi0zZmQ2LTg3ZjMtN2U0MzVjNTk2MzVjP250PVNPTERfU0hJUF9OT1cmYW1wO3NrPVFwYVM0UVVJZkh4ekRDZnkwSFpwWEJBUFNHd3RuemlCLXNMb1JNUjJPWXlRd2poUHUtMk0tM1FWWjJ6bGJjVTB3RjMzR0RsMnlaejJwaVFkanVzdWR3JmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJpOXViM1JwWm1sallYUnBiMjV6TDNCeVpXWmxjbVZ1WTJWekwyOXdkRzkxZEQ5dmNIUnZkWFJKWkQwNE56VTFZVGhrT0MxbFlUYzVMVFJoTVRjdE9HTXhaUzFrWW1SbE5HRTBPR1UxT0dRIiBtZXRyaWM9Im9wdG91dCIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgY29sb3I6ICNmZmZmZmY7Ij5oZXJlLjwvYT48YnI-PGJyPg0KCQkJCQkJCQkJCQkJQ29weXJpZ2h0ICAyMDI2IEFtYXpvbiwgSW5jLCBvciBpdHMgYWZmaWxpYXRlcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC48YnI-IA0KCQkJCQkJCQkJCQkJQW1hem9uIFNlbGxlciBTZXJ2aWNlcyBQcml2YXRlIExpbWl0ZWQsIDh0aCBmbG9vciwgQnJpZ2FkZSBHYXRld2F5LCAyNi8xIERyLiBSYWprdW1hciBSb2FkLCBCYW5nYWxvcmUgNTYwMDU1IChLYXJuYXRha2EpPGJyPjwvcD48dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICANCgkJCQkJCQkJCQkJDQogICAgICAgICAgICAgICAgICAgICAgICAJCQkJCTwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGFibGU-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KCQkJCQkJPC90ZD4NCgkJCQkJPC90cj4NCgkJCQkJPC90Ym9keT48L3RhYmxlPg0KCQkJCQk8IS0tIEJMT0NLIEZvb3RlciBBYm91dCBVcyAtLT4NCgkJCQkJPC90ZD4NCgkJCQkJPC90cj4NCgkJCQkJPC90Ym9keT48L3RhYmxlPg0KCQkJCQkNCgkJCQkJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBjbGFzcz0idGVtcGxhdGVDb250YWluZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7Ij4NCgkJCQkJPHRib2R5Pjx0cj4NCgkJCQkJPHRkPg0KCQkJCQ0KCQkJCQk8L3RkPg0KCQkJCQk8L3RyPg0KCQkJCQk8L3Rib2R5PjwvdGFibGU-DQoJCQkJCTwhLS1baWYgKGd0ZSBtc28gOSl8KElFKV0-DQoJCQkJPC90ZD4NCgkJCQk8L3RyPg0KCQkJPC90YWJsZT4NCgkJCTwhW2VuZGlmXS0tPg0KCQkJPCEtLSAvLyBFTkQgVEVNUExBVEUgLS0-DQoJCQk8L3RkPg0KCQk8L3RyPg0KCQk8L3Rib2R5PjwvdGFibGU-ICAgIA0KDQo8L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvZGl2PjwvY2VudGVyPjxpbWcgc3JjPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9pbWcvNDE2MTdjMDItZmZiYS0zNzUzLWIxNTMtNzg4ODM1MDNkMGZkP3NrPWVNRGpzZlZPS1ZFYjRoVFctR0RFZUtjXy1ORWRnYVhOU2hUeFMyVnAxb0tWRVBPVGxha2JwYWJ6UTNFc1lremtVOG9aQVFaMHR6RGd0NjVCcHFWeVlBJmFtcDtuPTEiPg0KPGRpdiBpZD0ic3BjLXdhdGVybWFyayI-DQogIDxwIHN0eWxlPSJmb250LXNpemU6IDEwcHggIWltcG9ydGFudDtwYWRkaW5nLWJvdHRvbTogMTBweCAhaW1wb3J0YW50O2Rpc3BsYXk6IHRhYmxlICFpbXBvcnRhbnQ7bWFyZ2luOiA1cHggYXV0byAxMHB4ICFpbXBvcnRhbnQ7dGV4dC1hbGlnbjogY2VudGVyICFpbXBvcnRhbnQ7Y29sb3I6ICNhMmEyYTIgIWltcG9ydGFudDtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcicgIWltcG9ydGFudDtmb250LXdlaWdodDogNDAwICFpbXBvcnRhbnQ7Ij5TUEMtRVVBbWF6b24tMTEyNTkwMTUyMzIxMjA2MTwvcD4NCjwvZGl2PjwvYm9keT48L2h0bWw-"}}]},"sizeEstimate":37327,"historyId":"2853594","internalDate":"1768072705000"}', '2026-01-11T04:56:57.149Z', '19ba95877ddac2d8', '19ba74365c56df1b', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('5bf4b6f3393277d9f2fb9302655da86a', '101f04af63cbefc2bf8f0a98b9ae1205', 'Seller Notification <seller-notification@amazon.in>', 'Sold, ship now: Atom-999 Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem & Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop & Professional Use', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        

<!--[if gte mso 15]>
<xml>
	<o:OfficeDocumentSettings>
	<o:AllowPNG/>
	<o:PixelsPerInch>96</o:PixelsPerInch>
	</o:OfficeDocumentSettings>
</xml>
<![endif]-->
<meta charset="UTF-8">
<!--[if !mso]><!-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--<![endif]-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="http://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet" type="text/css">
<style type="text/css">
	
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 300;
    src: local(''Amazon Ember Light''), local(''AmazonEmber-Light''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 300;
    src: local(''Amazon Ember Light Italic''), local(''AmazonEmber-LightItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 400;
    src: local(''Amazon Ember''), local(''AmazonEmber''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 400;
    src: local(''Amazon Ember Italic''), local(''AmazonEmber-Italic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 600;
    src: local(''Amazon Ember Medium''), local(''AmazonEmber-Medium''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 600;
    src: local(''Amazon Ember Medium Italic''), local(''AmazonEmber-MediumItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 700;
    src: local(''Amazon Ember Bold''), local(''AmazonEmber-Bold''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 700;
    src: local(''Amazon Ember Bold Italic''), local(''AmazonEmber-BoldItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff) format(''woff'');
}



	.nbus-survey{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:visited{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:hover{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:focus{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:active{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	
	one-column{border-spacing:0px;background-color:#FFFFFF;border:0px;padding:0px;width:100%;column-count:1;}
	endrImageBlock{padding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrImageBlockInner{padding:0px;}
	endrImageContentContainer{adding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrTextContentContainer{min-width:100%;width:100%;border-collapse:collapse;background-color:#FFFFFF;border:0px;padding:0px;border-spacing:0px;}
	endrTextBlock{min-width:100%;border-collapse:collapse;background-color:#ffffff;width:100%padding:0px;border-spacing:0px;border:0px;}
	preview-text{display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';}
	
	p{
	text-align: left;
	margin-top:10px;
	margin-bottom:10px;
	margin-right:0;
	margin-left:0;
	padding-top:0;
	padding-bottom:0;
	padding-right:0;
	padding-left:0;
	line-height:185%;
	}
	table{
	border-collapse:collapse;
	}
	h1,h2,h3,h4,h5,h6{
	display:block;
	margin:0;
	padding:0;
	}
	img,a img{
	border:0;
	height:auto;
	outline:none;
	text-decoration:none;
	}
	pre{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	font-family:''Amazon Ember'';
	min-width:100%;
	white-space: pre-wrap;       /* Since CSS 2.1 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
	}
	body,#bodyTable,#bodyCell{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	background-color:#e4e3e4;
	color:#999999
	font-family:''Amazon Ember'';
	min-width:100%;
	}
	#outlook a{
	padding:0;
	}
	img{
	-ms-interpolation-mode:bicubic;
	}
	table{
	mso-table-lspace:0pt;
	mso-table-rspace:0pt;
	}
	.ReadMsgBody{
	width:100%;
	}
	.ExternalClass{
	width:100%;
	}
	p,a,li,td,blockquote{
	mso-line-height-rule:exactly;
	}
	a[href^=tel],a[href^=sms]{
	color:inherit;
	cursor:default;
	text-decoration:none;
	}
	p,a,li,td,body,table,blockquote{
	-ms-text-size-adjust:100%;
	-webkit-text-size-adjust:100%;
	}
	.ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{
	line-height:100%;
	}
	a[x-apple-data-detectors]{
	color:inherit !important;
	text-decoration:none !important;
	font-size:inherit !important;
	font-family:inherit !important;
	font-weight:inherit !important;
	line-height:inherit !important;
	}
	.templateContainer{
	max-width:600px !important;
	}
	.endrImage{
	vertical-align:bottom;
	}
	.endrTextContent{
	word-break:break-word;
	padding-top:15px;
	padding-bottom:10px;
	padding-right:18px;
	padding-left:18px;
	text-align: left;
	}
	.endrTextContent img{
	height:auto !important;
	}
	.endrDividerBlock{
	table-layout:fixed !important;
	}
	body { margin:0 !important; }
	div[style*="margin: 16px 0"] { margin:0 !important; }

	body,#bodyTable{
	background-color:#e4e3e4;
	color:#999999;
	font-family: ''Amazon Ember'';
	}
	
	.templateBlocks{
	background-color:#FFFFFF;
	border-top-width:0;
	border-bottom-width:0;
	padding-top:0;
	padding-bottom:0;
	font-size:15px;
	line-height:185%;
	text-align:left;
	background-color:#FFFFFF;
	}
	
	.templateQuoteBlocks{
	background-color:#F04D44;
	}
	
	#bodyCell{
	border-top:0;
	}

	h1{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:30px;
	font-style:normal;
	font-weight:normal;
	line-height:120%;
	letter-spacing:normal;
	padding-top:2px;
	padding-bottom:2px;
	}

	a{
	color:#e74c3c;
	font-weight:normal;
	text-decoration:underline;
	}

	h2{
	color:#848484;
	font-family: ''Amazon Ember'';
	font-size:15px;
	font-style:normal;
	font-weight:normal;
	line-height:145%;
	letter-spacing:1px;
	padding-top:5px;
	padding-bottom:4px;
	}

	h3{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:140%;
	letter-spacing:normal;
	text-align:left;
	padding-top:2px;
	padding-bottom:2px;
	}

	h4{
	color:#666666;
	font-family: ''Amazon Ember'';
	font-size:16px;
	font-style:normal;
	font-weight:normal;
	line-height:125%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-bottom:4px;
	}

	h5{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	h6{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:26px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:right;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	#templatePreheader{
	border-top:0;
	border-bottom:0;
	padding-top:4px;
	padding-bottom:12px;
	}

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templatePreheader .endrTextContent a,#templatePreheader .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}

	#templateHeader{
	background-color:#303942;
	border-top:0px solid #e4e3e4;
	border-bottom:0;
	padding-top:0px;
	padding-bottom:0px;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent h1{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent a,#templateHeader .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:none;
	}

	#templateSeparator{
	padding-top:8px;
	padding-bottom:8px;
	}

	.templateLowerBody{
	background-color:#455C64;
	border-bottom:0;
	padding-top:1px;
	padding-bottom:1px;
	}

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:150%;
	text-align:left;
	}

	.templateLowerBody .endrTextContent a,.templateLowerBody .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:underline;
	}

	.templateLowerBody .endrTextContent h1 {
	color:#ffffff;
	font-weight:700;
	font-size:18px;
	}

	.templateSocial{
	background-color:#e4e3e4;
	padding-top:13px;
	padding-bottom:3px;
	}

	#templateFooter{
	border-top:0;
	border-bottom:0;
	padding-top:5px;
	padding-bottom:5px;
	}

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templateFooter .endrTextContent a,#templateFooter .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}
	
	@media only screen and (min-width:768px){
	.templateContainer{
	width:600px !important;
	}
	}	
	
	@media only screen and (max-width: 480px){
	
	.templateHeader{
		display: none;
	}
		
	.bigimage .endrImageContent{
	padding-top:0px !important;

	}
	.templateContainer{
	width:100% !important;
	max-width:600px;
	}	@media only screen and (max-width: 480px){
	body,table,td,p,a,li,blockquote{
	-webkit-text-size-adjust:none !important;
	}
	}	@media only screen and (max-width: 480px){
	body{
	width:100% !important;
	min-width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	#bodyCell{
	padding-top:10px !important;
	}
	}	@media only screen and (max-width: 480px){
	.columnWrapper{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImage{
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionTopContent,.endrCaptionBottomContent,.endrTextContentContainer,.endrBoxedTextContentContainer,.endrImageGroupContentContainer,.endrCaptionLeftTextContentContainer,.endrCaptionRightTextContentContainer,.endrCaptionLeftImageContentContainer,.endrCaptionRightImageContentContainer,.endrImageCardLeftTextContentContainer,.endrImageCardRightTextContentContainer{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrBoxedTextContentContainer{
	min-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.column{
	width:100% !important;
	max-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.endrImageGroupContent{
	padding:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionLeftContentOuter .endrTextContent,.endrCaptionRightContentOuter .endrTextContent{
	padding-top:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardTopImageContent,.endrCaptionBlockInner .endrCaptionTopContent:last-child .endrTextContent{
	padding-top:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardBottomImageContent{
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockInner{
	padding-top:0 !important;
	padding-bottom:0 !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockOuter{
	padding-top:9px !important;
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrTextContent,.endrBoxedTextContentColumn{
	padding-right:18px !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardLeftImageContent,.endrImageCardRightImageContent{
	padding-right:18px !important;
	padding-bottom:0 !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.mcpreview-image-uploader{
	display:none !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){

	h1{
	font-size:22px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h2{
	font-size:20px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h3{
	font-size:18px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h4{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){
	
	.endrBoxedTextContentContainer .endrTextContent,.endrBoxedTextContentContainer .endrTextContent p{
	font-size:14px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader{
	display:block !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	font-size:16px !important;
	line-height:100% !important;
	text-align:center !important;
	}

	#templateHeader .endrTextContent, #templateHeader .endrTextContent h1{
	font-size:20px !important;
	line-height:100% !important;
	padding-bottom:10px !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateUpperBody .endrTextContent,#templateUpperBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	
	}	@media only screen and (max-width: 480px){

	#templateColumns .columnContainer .endrTextContent,#templateColumns .columnContainer .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	text-align:center !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}
</style>

<!--[if mso]>
<style type="text/css">
body, table, td {font-family: ''Amazon Ember'';}
h1 {font-family: ''Amazon Ember'';}
h2 {font-family: ''Amazon Ember'';}
h3 {font-family: ''Amazon Ember'';}
h4 {font-family: ''Amazon Ember'';}
h5 {font-family: ''Amazon Ember'';}
h6 {font-family: ''Amazon Ember'';}
h7 {font-family: ''Amazon Ember'';}
p {font-family: ''Amazon Ember'';}
</style>
<![endif]-->

<!--[if gt mso 15]>
<style type="text/css" media="all">
/* Outlook 2016 Height Fix */
table, tr, td {border-collapse: collapse;}
tr {border-collapse: collapse; }
body {background-color:#ffffff;}
</style>
<![endif]-->    </head>

    <body>
        <center class="wrapper" style="width:100%;table-layout:fixed;background-color:#e4e3e4;">
  <div class="webkit" style="max-width:600px;margin:0 auto;">
      <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable" style="border-collapse:collapse;height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;width:100%;background-color:#e4e3e4;color:#5a5a5a;font-family:''Lato'', Helvetica, Arial, sans-serif;">
        <tbody><tr>
            <td align="center" valign="top" id="bodyCell" style="height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;width:100%;padding-top:10px;padding-bottom:10px;border-top-width:0;">
<!-- BEGIN TEMPLATE // -->
<!--[if (gte mso 9)|(IE)]>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;border-collapse:collapse;" >
	<tr>
	<td align="center" valign="top" width="600" style="width:600px;" >
		<![endif]-->
		<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-header>
		<tbody><tr>
		<td>
        <div style="display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';">
            Ship by: 12/01/2026, Standard Shipping
        </div>

        <!-- BLOCK Logo Center -->
 <table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" data-space-sc-header>
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
          <td class="templateHeader" valign="top" style="padding: 20px 0; padding-left:40px">
          <img align="center" alt="" src="https://m.media-amazon.com/images/G/01/SPACE/logo-selling_coach.png" width="200" style="max-width:200px;padding-bottom:0;display:inline !important;vertical-align:bottom;border-width:0;height:auto;outline-style:none;text-decoration:none;-ms-interpolation-mode:bicubic;">
          </td>
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
<!-- ENDR Header  -->


</td>
</tr>
</tbody></table>

<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;background-color:#ffffff;" bgcolor="#ffffff">
<tbody><tr>
<td>
        <table class="one-column">
            <tbody><tr valign="top" class="templateBlocks">
                <td valign="top">
                    <table class="endrTextBlock">
                        <tbody class="endrTextBlockOuter">
                            <tr>
                                <td valign="top" class="endrTextBlockInner">
                                    <table align="left" class="endrTextContentContainer">
                                        <tbody>
                                            <tr>
                                                <td valign="top" class="endrTextContent" align="center">
                                                    <p style="text-align:left;margin-top:10px;margin-bottom:10px;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;line-height:185%;">
                                                        

                                









            </p><div style="text-align:left">
                            
    
    
    <p>Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026.</p>

                            
                    <p>Please review your order:</p>
    
                <center>
                    <div style="margin: 20px 0px 20px 10px; padding:10px; display:inline-block; background-color:#006574;">
    <a style="color:#fff; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/54ce06b7-534f-3c17-a567-1d0db3f2fbb7?nt=SOLD_SHIP_NOW&amp;sk=YbAXM2HjUY3Xo06e9-c5fTWuqnTZOIphGMS8lV0hzRZYJXiirGYemDK1sQTpxPqKj7dNocEgvd6QtPynyYxt1Q&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9vcmRlcnMtdjMvb3JkZXIvNDA0LTE4NzUxMTUtOTk0Mjc0Mj9yZWZfPXh4X2VtYWlsX2JvZHlfc2hpcA">
        View Order
    </a>
</div>

                            <div style="margin: 20px 0px 20px 20px; padding:10px; display:inline-block; background-color:#e3eced;">
    <a style="color:#002f36; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/9766702d-bc36-35e0-be24-8c734f50fa6e?nt=SOLD_SHIP_NOW&amp;sk=BGDC4CMMoQI0jeZIbIKEes5-dAOWVS9geJTbuIKajZdVFMrSkyT8Jt05vNlTDU0vtZIB-4up29NLUvvhP69Z5w&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9oZWxwL2h1Yi9yZWZlcmVuY2UvRzIwMTM4MzM0MD9yZWZfPXh4X2VtYWlsX2JvZHlfaGVscA">
        Get Help Shipping Your Order
    </a>
</div>
    </center>
    <h3>Order Details</h3>
                                <b>Order ID:</b> 404-1875115-9942742
    <br>
                <b>Order date:</b> 10/01/2026
    <br>
                                        <b>Please ship this order using:</b> Standard Shipping
        <br>
                            <b>Collect on Delivery prepaid:</b> INR 0.00
        <br>
                            <b>Collect on Delivery amount:</b> INR 747.00
        <br>
        <br>
                                        
                                                    <b>Ship by:</b> 12/01/2026
            <br>
                                        <b>Item:</b> Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem &amp; Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop &amp; Professional Use
        <br>
                                                                    <b>Condition:</b> New
                    <br>
                                                                            <b>SKU:</b> Atom-999
        <br>
                                <b>Quantity:</b> 1
        <br>
                                            <b>Price:</b> INR 627.12
    <br>
                                                            <b>Tax:</b> INR 112.88
        <br>
                                                                                                                                                                                                                                                                                                                                                                                    <b>Amazon fees:</b> -INR 109.98
    <br>
                                                                                                                                                                                    <b>Collect on Delivery fees:</b> INR 5.93
        <br>
                                                
    
    
</div>
                                                    <p></p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody></table>


                

					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-footer data-space-sc-footer>
					<tbody><tr>
					<td>
				
					<!-- BLOCK Footer About Us -->
					<table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" dir="auto">
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<center style="margin-top: 20px;">
                        	<a style="padding: 7px 24px; text-decoration: none; background: #fff; border: 1px solid #EC937C; border-radius: 5px; color: #7F1809; font-family: ''Amazon Ember''; font-size: 13px; font-weight: 600;display: inline-block; margin-bottom: 10px" href="https://sellercentral.amazon.in/notifications/feedback?deliveryId=633320311163804&amp;communicationName=SOLD_SHIP_NOW&amp;deliveryChannel=EMAIL">
                    <img src="https://m.media-amazon.com/images/G/01/space/icon.png" style="margin-right: 10px;vertical-align: middle;" width="20" height="20">Report an issue with this email
                  </a>
                        </center><p style="text-align:center !important;margin-top:10px;margin-bottom:10px;margin-right:10px;margin-left:15px;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;color:#ffffff;font-family:''Amazon Ember'';font-size:13px;line-height:150%;">If you have any questions visit: <a href="https://sellercentral.amazon.in/nms/sellermobile/redirect/4e65173d-d26e-3749-a313-4f3b084cb1c1?nt=SOLD_SHIP_NOW&amp;sk=OerijoaO9JWpw8YDnbUVa-_u0II-sqxahieI-lh1v8fPOzZp68fChqxd_a3PKq2omCOfuo1_gDTDVE8O6zG5NA&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbg" metric="help" style="text-decoration: none; color: #ffffff;">Seller Central</a><br><br>
											    To change your email preferences visit: <a href="https://sellercentral.amazon.in/nms/redirect/9058cc40-16a6-3694-8b8a-fbcbca3d0649?nt=SOLD_SHIP_NOW&amp;sk=-Mj_k8PRBf9ir2Mp6F4htDFhe7SoNXxz851p7pJ2x6j_-VsAxOoSh3cPz5pNoZvRxfE_K3jmEN4mYEMrKCkeSQ&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL3JlZj1pZF9ub3RpZnByZWZfZG5hdl94eF8" metric="optout" style="text-decoration: none; color: #ffffff;">Notification Preferences</a><br><br>
																		We hope you found this message to be useful. However, if you''d rather not receive future e-mails of this sort from Amazon.com, please opt-out <a href="https://sellercentral.amazon.in/nms/redirect/6b7e512c-e14c-3262-8ad3-6851f4afad24?nt=SOLD_SHIP_NOW&amp;sk=GbfS6X3GIaNSqQFaM5eC5l7aiPnK8a-u02RLYdebm56nAXJdn-S2Ntdi7_NI3pLPQet2ZDq_jmJKzPjsaGsp1w&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL29wdG91dD9vcHRvdXRJZD03ZDFiNmRmYS05ODlmLTQ1ZjEtOWFjYS1hMTMxN2JlN2Y4ZGI" metric="optout" style="text-decoration: none; color: #ffffff;">here.</a><br><br>
												Copyright  2026 Amazon, Inc, or its affiliates. All rights reserved.<br> 
												Amazon Seller Services Private Limited, 8th floor, Brigade Gateway, 26/1 Dr. Rajkumar Road, Bangalore 560055 (Karnataka)<br></p><table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
                        
                        
                        
											
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
					<!-- BLOCK Footer About Us -->
					</td>
					</tr>
					</tbody></table>
					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;">
					<tbody><tr>
					<td>
				
					</td>
					</tr>
					</tbody></table>
					<!--[if (gte mso 9)|(IE)]>
				</td>
				</tr>
			</table>
			<![endif]-->
			<!-- // END TEMPLATE -->
			</td>
		</tr>
		</tbody></table>    

</td></tr></tbody></table></div></center><img src="https://sellercentral.amazon.in/nms/img/4c9d3397-3e7d-37c2-967b-51368a46c4da?sk=sxwDv3X7ohQN6jwGT_kz0ItN5bRVDH80jkL_RpsB1AjkXwEhmWwTt2KSMYJTNwK57vcqHg8SlYHXddiIbQDwLQ&amp;n=1">
<div id="spc-watermark">
  <p style="font-size: 10px !important;padding-bottom: 10px !important;display: table !important;margin: 5px auto 10px !important;text-align: center !important;color: #a2a2a2 !important;font-family: ''Amazon Ember'' !important;font-weight: 400 !important;">SPC-EUAmazon-633320311163804</p>
</div></body></html>', '2026-01-10T19:01:51.000Z', '{"id":"19ba9494df83e742","threadId":"19ba74365c56df1b","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"Ship by: 12/01/2026, Standard Shipping Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026. Please review your order: View Order Get Help Shipping","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2406613pxc;        Sat, 10 Jan 2026 11:01:52 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IGRpfDrGRbl+blyfx+4ikXTmoFhL21EKBdRoqXaFSR+4xdSniGPiYHKwUYwaBOdjgqtlLAn"},{"name":"X-Received","value":"by 2002:a05:600c:3484:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d84b20fd7mr158792345e9.11.1768071711968;        Sat, 10 Jan 2026 11:01:51 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768071711; cv=none;        d=google.com; s=arc-20240605;        b=Mgu6Z2jCAaTUD7oL8qcNiTHRvmCGR4wyLtpEcjG+BLBGud0cyOvyP6J3rToVtAizO0         339fu54X9BrfXlECRgJNKaWVD3e/ju2fenokc2faIKY2RGgdXsCspWBwRvWii3auqEpD         C/tyQLAhE1Lm1w48yLpXAAkvvlUFRDKHouqSfZzC5e6FTtW0rvXbGlNKB62GexTZDTzG         8sAnXR1We2j+tNE46qJKezoh5de4q1CI9KqaGWLrB1nvFfkIVXsLnT8vV9p/zMDRUukC         nMrY6TxfMUqN0OphM72meWJiJLshcPlR2HXV2gWXkrNGS+nnqJbiJCZir5D+Jc7kOkWD         A+3g=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=feedback-id:list-unsubscribe-post:list-unsubscribe:bounces-to         :mime-version:subject:message-id:to:reply-to:from:date         :dkim-signature:dkim-signature;        bh=06usP8Pk++X7zXRmzcwRuK3jURoC6P2tlfVezNiKmTU=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=QY2Q+7nj/mjWUfFo8X/ql2s+UUjvyh08j6nsNFCNrTKzBoQEf+t99XP8S/Q4teYQYg         Wq3vqeDcRZllEN/VLJTVczXgM1+HRiUcD16LfMhSkd9YERVMIyitAdRJdWKEAE5azK0l         aOnlDov54ECRwqhO2orUIvNOMpbsCWejQgxP6Z0uYlRmiCn9mdYXXzvbYLa7rxd1g/wJ         yfKyKqg/2UplxcVTm3bU2wkq9HGfaEisf9/1IFzNQPi7GeecXh+CVYaFg9b/W6f/9tk8         6gBS7n2gxvjdqyu7JKQBKRbifAVzKyA6Zoo33y1JDrMPaElKUW0gqgip3qFwR4DSRgul         bIeA==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=NvgnlzBr;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=g02WifIg;       spf=pass (google.com: domain of 0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com designates 76.223.149.184 as permitted sender) smtp.mailfrom=0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"Return-Path","value":"<0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com>"},{"name":"Received","value":"from c149-184.smtp-out.eu-west-1.amazonses.com (c149-184.smtp-out.eu-west-1.amazonses.com. [76.223.149.184])        by mx.google.com with ESMTPS id ffacd0b85a97d-432bd62e5d4si22034988f8f.505.2026.01.10.11.01.51        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Sat, 10 Jan 2026 11:01:51 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of 0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com designates 76.223.149.184 as permitted sender) client-ip=76.223.149.184;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=NvgnlzBr;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=g02WifIg;       spf=pass (google.com: domain of 0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com designates 76.223.149.184 as permitted sender) smtp.mailfrom=0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=oispgif7zht3cwr3nad5jndkl43aztnu; d=amazon.in; t=1768071711; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post; bh=J/EXFGYAHICAHz/w8XVFPDnqZgNNXC4EV/7sfzHJxcY=; b=NvgnlzBr7r+h7vsQZp8Vz6LkcJyNDurCnv0VnWpY1G3R+nWHmVIUiAJehuxumKJc swKYkDfuUi9iKY6mciZtOoxM3mi/nw60+Uh8HMOYt/3WxvBE14OoSK9SLJ/UElPGYkV 7jdxSH0TD3wq0oaiVgghsYQiwaaLLOB0Y5/SjVFxv6ThSb76M5rJR3aYuSR1lqgtqEA SP67jYOAccjDXP84lR9VPa68RYJrO78amH6L8hjOTWk9ZFIUJdsauQE1aCuC73gYbpb WNYeVxJrtESm5spNt/7k1kOgPMnsDruKdixV5yi0SUQxQ3H+4eQ8KYn8E/u1HVIvnn/ Jz8HimNU3A=="},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768071711; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post:Feedback-ID; bh=J/EXFGYAHICAHz/w8XVFPDnqZgNNXC4EV/7sfzHJxcY=; b=g02WifIgSzOs/t9YZeIJXjrYPHi551wswvWiDpVlUA3b4LYoOjRYieVAzxhHyJTZ uX4X295nPB1O88JwdE0rjxKyUjwZ1aJ2xOe0MNOrqMfr911UR7afExkQ25tS+3oNCRt BedegML5J1XEiBYjczzzvTiYUvb38FgysdhtnmWQ="},{"name":"Date","value":"Sat, 10 Jan 2026 19:01:51 +0000"},{"name":"From","value":"Seller Notification <seller-notification@amazon.in>"},{"name":"Reply-To","value":"seller-notification@amazon.in"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Message-ID","value":"<0102019ba9494afd-e7c7bbea-a6e0-4131-94c6-2da2ca099997-000000@eu-west-1.amazonses.com>"},{"name":"Subject","value":"Sold, ship now: Atom-999 Gripit Digital Jewellery Weighing Scale 1000g x 0.01g - Portable Gold, Silver, Gem & Coin Weighing Machine with LCD Display - Precision Weight Scale for Home, Shop & Professional Use"},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/alternative; boundary=\"----=_Part_1405569_923050400.1768071711479\""},{"name":"Bounces-to","value":"RTE+NE-null-b1cb1A02304881K89QRTLFUGDI@sellernotifications.amazon.com"},{"name":"X-Space-Message-ID","value":"633320311163804"},{"name":"X-Marketplace-ID","value":"A21TJRUUN4KGV"},{"name":"List-Unsubscribe","value":"<https://sellercentral.amazon.in/notifications/preferences/optout/header-one-click?optoutId=7d1b6dfa-989f-45f1-9aca-a1317be7f8db>"},{"name":"List-Unsubscribe-Post","value":"List-Unsubscribe=One-Click"},{"name":"Feedback-ID","value":"::1.eu-west-1.QXQDwfZxBksRk8Fey1ctk1ELdO+bec9bLwquzardhBQ=:AmazonSES"},{"name":"X-SES-Outgoing","value":"2026.01.10-76.223.149.184"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"7bit"}],"body":{"size":31282,"data":"PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg0KPGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zOnY9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206dm1sIiB4bWxuczpvPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTpvZmZpY2UiPg0KDQogICAgPGhlYWQ-DQogICAgICAgIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4NCiAgICAgICAgDQoNCjwhLS1baWYgZ3RlIG1zbyAxNV0-DQo8eG1sPg0KCTxvOk9mZmljZURvY3VtZW50U2V0dGluZ3M-DQoJPG86QWxsb3dQTkcvPg0KCTxvOlBpeGVsc1BlckluY2g-OTY8L286UGl4ZWxzUGVySW5jaD4NCgk8L286T2ZmaWNlRG9jdW1lbnRTZXR0aW5ncz4NCjwveG1sPg0KPCFbZW5kaWZdLS0-DQo8bWV0YSBjaGFyc2V0PSJVVEYtOCI-DQo8IS0tW2lmICFtc29dPjwhLS0-DQoJCTxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSI-DQoJPCEtLTwhW2VuZGlmXS0tPg0KPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIj4NCjx0aXRsZT48L3RpdGxlPg0KPGxpbmsgaHJlZj0iaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TGF0bzo0MDAsNzAwIiByZWw9InN0eWxlc2hlZXQiIHR5cGU9InRleHQvY3NzIj4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQoJDQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogbm9ybWFsOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0JyksIGxvY2FsKCdBbWF6b25FbWJlci1MaWdodCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9sdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0IEl0YWxpYycpLCBsb2NhbCgnQW1hem9uRW1iZXItTGlnaHRJdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbHRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0aXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXInKSwgbG9jYWwoJ0FtYXpvbkVtYmVyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnX2Jhc2Uud29mZjIpIGZvcm1hdCgnd29mZjInKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBpdGFsaWM7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDYwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgTWVkaXVtJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW0nKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9tZF9iYXNlLndvZmYpIGZvcm1hdCgnd29mZicpOw0KfQ0KQGZvbnQtZmFjZSB7DQogICAgZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KICAgIGZvbnQtc3R5bGU6IGl0YWxpYzsNCiAgICBmb250LXdlaWdodDogNjAwOw0KICAgIHNyYzogbG9jYWwoJ0FtYXpvbiBFbWJlciBNZWRpdW0gSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX21kaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDcwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgQm9sZCcpLCBsb2NhbCgnQW1hem9uRW1iZXItQm9sZCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkX2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiA3MDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIEJvbGQgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1Cb2xkSXRhbGljJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkaXRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZGl0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQoNCg0KDQoJLm5idXMtc3VydmV5e2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJLm5idXMtc3VydmV5OnZpc2l0ZWR7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6aG92ZXJ7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6Zm9jdXN7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6YWN0aXZle2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJDQoJb25lLWNvbHVtbntib3JkZXItc3BhY2luZzowcHg7YmFja2dyb3VuZC1jb2xvcjojRkZGRkZGO2JvcmRlcjowcHg7cGFkZGluZzowcHg7d2lkdGg6MTAwJTtjb2x1bW4tY291bnQ6MTt9DQoJZW5kckltYWdlQmxvY2t7cGFkZGluZzowcHg7Ym9yZGVyLXNwYWNpbmc6MHB4O21pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTt3aWR0aDoxMDAlO2JvcmRlcjowcHg7fQ0KCWVuZHJJbWFnZUJsb2NrSW5uZXJ7cGFkZGluZzowcHg7fQ0KCWVuZHJJbWFnZUNvbnRlbnRDb250YWluZXJ7YWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7bWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO3dpZHRoOjEwMCU7Ym9yZGVyOjBweDt9DQoJZW5kclRleHRDb250ZW50Q29udGFpbmVye21pbi13aWR0aDoxMDAlO3dpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO2JhY2tncm91bmQtY29sb3I6I0ZGRkZGRjtib3JkZXI6MHB4O3BhZGRpbmc6MHB4O2JvcmRlci1zcGFjaW5nOjBweDt9DQoJZW5kclRleHRCbG9ja3ttaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO3dpZHRoOjEwMCVwYWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7Ym9yZGVyOjBweDt9DQoJcHJldmlldy10ZXh0e2Rpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQoJDQoJcHsNCgl0ZXh0LWFsaWduOiBsZWZ0Ow0KCW1hcmdpbi10b3A6MTBweDsNCgltYXJnaW4tYm90dG9tOjEwcHg7DQoJbWFyZ2luLXJpZ2h0OjA7DQoJbWFyZ2luLWxlZnQ6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJcGFkZGluZy1yaWdodDowOw0KCXBhZGRpbmctbGVmdDowOw0KCWxpbmUtaGVpZ2h0OjE4NSU7DQoJfQ0KCXRhYmxlew0KCWJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsNCgl9DQoJaDEsaDIsaDMsaDQsaDUsaDZ7DQoJZGlzcGxheTpibG9jazsNCgltYXJnaW46MDsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZyxhIGltZ3sNCglib3JkZXI6MDsNCgloZWlnaHQ6YXV0bzsNCglvdXRsaW5lOm5vbmU7DQoJdGV4dC1kZWNvcmF0aW9uOm5vbmU7DQoJfQ0KCXByZXsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJZm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7DQoJbWluLXdpZHRoOjEwMCU7DQoJd2hpdGUtc3BhY2U6IHByZS13cmFwOyAgICAgICAvKiBTaW5jZSBDU1MgMi4xICovDQogICAgd2hpdGUtc3BhY2U6IC1tb3otcHJlLXdyYXA7ICAvKiBNb3ppbGxhLCBzaW5jZSAxOTk5ICovDQogICAgd2hpdGUtc3BhY2U6IC1wcmUtd3JhcDsgICAgICAvKiBPcGVyYSA0LTYgKi8NCiAgICB3aGl0ZS1zcGFjZTogLW8tcHJlLXdyYXA7ICAgIC8qIE9wZXJhIDcgKi8NCiAgICB3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7ICAgICAgIC8qIEludGVybmV0IEV4cGxvcmVyIDUuNSsgKi8NCgl9DQoJYm9keSwjYm9keVRhYmxlLCNib2R5Q2VsbHsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCWNvbG9yOiM5OTk5OTkNCglmb250LWZhbWlseTonQW1hem9uIEVtYmVyJzsNCgltaW4td2lkdGg6MTAwJTsNCgl9DQoJI291dGxvb2sgYXsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZ3sNCgktbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7DQoJfQ0KCXRhYmxlew0KCW1zby10YWJsZS1sc3BhY2U6MHB0Ow0KCW1zby10YWJsZS1yc3BhY2U6MHB0Ow0KCX0NCgkuUmVhZE1zZ0JvZHl7DQoJd2lkdGg6MTAwJTsNCgl9DQoJLkV4dGVybmFsQ2xhc3N7DQoJd2lkdGg6MTAwJTsNCgl9DQoJcCxhLGxpLHRkLGJsb2NrcXVvdGV7DQoJbXNvLWxpbmUtaGVpZ2h0LXJ1bGU6ZXhhY3RseTsNCgl9DQoJYVtocmVmXj10ZWxdLGFbaHJlZl49c21zXXsNCgljb2xvcjppbmhlcml0Ow0KCWN1cnNvcjpkZWZhdWx0Ow0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCglwLGEsbGksdGQsYm9keSx0YWJsZSxibG9ja3F1b3Rlew0KCS1tcy10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJfQ0KCS5FeHRlcm5hbENsYXNzLC5FeHRlcm5hbENsYXNzIHAsLkV4dGVybmFsQ2xhc3MgdGQsLkV4dGVybmFsQ2xhc3MgZGl2LC5FeHRlcm5hbENsYXNzIHNwYW4sLkV4dGVybmFsQ2xhc3MgZm9udHsNCglsaW5lLWhlaWdodDoxMDAlOw0KCX0NCglhW3gtYXBwbGUtZGF0YS1kZXRlY3RvcnNdew0KCWNvbG9yOmluaGVyaXQgIWltcG9ydGFudDsNCgl0ZXh0LWRlY29yYXRpb246bm9uZSAhaW1wb3J0YW50Ow0KCWZvbnQtc2l6ZTppbmhlcml0ICFpbXBvcnRhbnQ7DQoJZm9udC1mYW1pbHk6aW5oZXJpdCAhaW1wb3J0YW50Ow0KCWZvbnQtd2VpZ2h0OmluaGVyaXQgIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDppbmhlcml0ICFpbXBvcnRhbnQ7DQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgltYXgtd2lkdGg6NjAwcHggIWltcG9ydGFudDsNCgl9DQoJLmVuZHJJbWFnZXsNCgl2ZXJ0aWNhbC1hbGlnbjpib3R0b207DQoJfQ0KCS5lbmRyVGV4dENvbnRlbnR7DQoJd29yZC1icmVhazpicmVhay13b3JkOw0KCXBhZGRpbmctdG9wOjE1cHg7DQoJcGFkZGluZy1ib3R0b206MTBweDsNCglwYWRkaW5nLXJpZ2h0OjE4cHg7DQoJcGFkZGluZy1sZWZ0OjE4cHg7DQoJdGV4dC1hbGlnbjogbGVmdDsNCgl9DQoJLmVuZHJUZXh0Q29udGVudCBpbWd7DQoJaGVpZ2h0OmF1dG8gIWltcG9ydGFudDsNCgl9DQoJLmVuZHJEaXZpZGVyQmxvY2t7DQoJdGFibGUtbGF5b3V0OmZpeGVkICFpbXBvcnRhbnQ7DQoJfQ0KCWJvZHkgeyBtYXJnaW46MCAhaW1wb3J0YW50OyB9DQoJZGl2W3N0eWxlKj0ibWFyZ2luOiAxNnB4IDAiXSB7IG1hcmdpbjowICFpbXBvcnRhbnQ7IH0NCg0KCWJvZHksI2JvZHlUYWJsZXsNCgliYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7DQoJY29sb3I6Izk5OTk5OTsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJfQ0KCQ0KCS50ZW1wbGF0ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGRkZGRkY7DQoJYm9yZGVyLXRvcC13aWR0aDowOw0KCWJvcmRlci1ib3R0b20td2lkdGg6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJZm9udC1zaXplOjE1cHg7DQoJbGluZS1oZWlnaHQ6MTg1JTsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJYmFja2dyb3VuZC1jb2xvcjojRkZGRkZGOw0KCX0NCgkNCgkudGVtcGxhdGVRdW90ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGMDRENDQ7DQoJfQ0KCQ0KCSNib2R5Q2VsbHsNCglib3JkZXItdG9wOjA7DQoJfQ0KDQoJaDF7DQoJY29sb3I6IzQ1NWM2NDsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjMwcHg7DQoJZm9udC1zdHlsZTpub3JtYWw7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCWxpbmUtaGVpZ2h0OjEyMCU7DQoJbGV0dGVyLXNwYWNpbmc6bm9ybWFsOw0KCXBhZGRpbmctdG9wOjJweDsNCglwYWRkaW5nLWJvdHRvbToycHg7DQoJfQ0KDQoJYXsNCgljb2xvcjojZTc0YzNjOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCWgyew0KCWNvbG9yOiM4NDg0ODQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxNXB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDUlOw0KCWxldHRlci1zcGFjaW5nOjFweDsNCglwYWRkaW5nLXRvcDo1cHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWgzew0KCWNvbG9yOiM0NTVjNjQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDAlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MnB4Ow0KCXBhZGRpbmctYm90dG9tOjJweDsNCgl9DQoNCgloNHsNCgljb2xvcjojNjY2NjY2Ow0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTZweDsNCglmb250LXN0eWxlOm5vcm1hbDsNCglmb250LXdlaWdodDpub3JtYWw7DQoJbGluZS1oZWlnaHQ6MTI1JTsNCglsZXR0ZXItc3BhY2luZzpub3JtYWw7DQoJdGV4dC1hbGlnbjpsZWZ0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWg1ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MTFweDsNCglwYWRkaW5nLXJpZ2h0OjIwcHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCXBhZGRpbmctbGVmdDoyMHB4Ow0KCX0NCg0KCWg2ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyNnB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1yaWdodDoyMHB4Ow0KCXBhZGRpbmctYm90dG9tOjhweDsNCglwYWRkaW5nLWxlZnQ6MjBweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXJ7DQoJYm9yZGVyLXRvcDowOw0KCWJvcmRlci1ib3R0b206MDsNCglwYWRkaW5nLXRvcDo0cHg7DQoJcGFkZGluZy1ib3R0b206MTJweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxMnB4Ow0KCWxpbmUtaGVpZ2h0OjE1MCU7DQoJdGV4dC1hbGlnbjpjZW50ZXI7DQoJfQ0KDQoJI3RlbXBsYXRlUHJlaGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgYSwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwIGF7DQoJY29sb3I6I2ZiZmJmYjsNCglmb250LXdlaWdodDpub3JtYWw7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsNCgl9DQoNCgkjdGVtcGxhdGVIZWFkZXJ7DQoJYmFja2dyb3VuZC1jb2xvcjojMzAzOTQyOw0KCWJvcmRlci10b3A6MHB4IHNvbGlkICNlNGUzZTQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjBweDsNCglwYWRkaW5nLWJvdHRvbTowcHg7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxMDAlOw0KCXRleHQtYWxpZ246cmlnaHQ7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgaDF7DQoJY29sb3I6I2ZmZmZmZjsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjIwcHg7DQoJbGluZS1oZWlnaHQ6MTAwJTsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCg0KCSN0ZW1wbGF0ZVNlcGFyYXRvcnsNCglwYWRkaW5nLXRvcDo4cHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keXsNCgliYWNrZ3JvdW5kLWNvbG9yOiM0NTVDNjQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjFweDsNCglwYWRkaW5nLWJvdHRvbToxcHg7DQoJfQ0KDQoJLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQsLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246bGVmdDsNCgl9DQoNCgkudGVtcGxhdGVMb3dlckJvZHkgLmVuZHJUZXh0Q29udGVudCBhLC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHAgYXsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IGgxIHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0OjcwMDsNCglmb250LXNpemU6MThweDsNCgl9DQoNCgkudGVtcGxhdGVTb2NpYWx7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCXBhZGRpbmctdG9wOjEzcHg7DQoJcGFkZGluZy1ib3R0b206M3B4Ow0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlcnsNCglib3JkZXItdG9wOjA7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjVweDsNCglwYWRkaW5nLWJvdHRvbTo1cHg7DQoJfQ0KDQoJI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmJmYmZiOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTJweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246Y2VudGVyOw0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7DQoJfQ0KCQ0KCUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDo3NjhweCl7DQoJLnRlbXBsYXRlQ29udGFpbmVyew0KCXdpZHRoOjYwMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JDQoJDQoJQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLnRlbXBsYXRlSGVhZGVyew0KCQlkaXNwbGF5OiBub25lOw0KCX0NCgkJDQoJLmJpZ2ltYWdlIC5lbmRySW1hZ2VDb250ZW50ew0KCXBhZGRpbmctdG9wOjBweCAhaW1wb3J0YW50Ow0KDQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgl3aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJbWF4LXdpZHRoOjYwMHB4Ow0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJYm9keSx0YWJsZSx0ZCxwLGEsbGksYmxvY2txdW90ZXsNCgktd2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6bm9uZSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCWJvZHl7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCW1pbi13aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJI2JvZHlDZWxsew0KCXBhZGRpbmctdG9wOjEwcHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uV3JhcHBlcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25Ub3BDb250ZW50LC5lbmRyQ2FwdGlvbkJvdHRvbUNvbnRlbnQsLmVuZHJUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJJbWFnZUdyb3VwQ29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0VGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJDYXB0aW9uUmlnaHRUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRyQ2FwdGlvblJpZ2h0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkTGVmdFRleHRDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkUmlnaHRUZXh0Q29udGVudENvbnRhaW5lcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXJ7DQoJbWluLXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfSBAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9IEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VHcm91cENvbnRlbnR7DQoJcGFkZGluZzo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25MZWZ0Q29udGVudE91dGVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJDYXB0aW9uUmlnaHRDb250ZW50T3V0ZXIgLmVuZHJUZXh0Q29udGVudHsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZFRvcEltYWdlQ29udGVudCwuZW5kckNhcHRpb25CbG9ja0lubmVyIC5lbmRyQ2FwdGlvblRvcENvbnRlbnQ6bGFzdC1jaGlsZCAuZW5kclRleHRDb250ZW50ew0KCXBhZGRpbmctdG9wOjE4cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZEJvdHRvbUltYWdlQ29udGVudHsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlR3JvdXBCbG9ja0lubmVyew0KCXBhZGRpbmctdG9wOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTowICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJLmVuZHJJbWFnZUdyb3VwQmxvY2tPdXRlcnsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kclRleHRDb250ZW50LC5lbmRyQm94ZWRUZXh0Q29udGVudENvbHVtbnsNCglwYWRkaW5nLXJpZ2h0OjE4cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VDYXJkTGVmdEltYWdlQ29udGVudCwuZW5kckltYWdlQ2FyZFJpZ2h0SW1hZ2VDb250ZW50ew0KCXBhZGRpbmctcmlnaHQ6MThweCAhaW1wb3J0YW50Ow0KCXBhZGRpbmctYm90dG9tOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5tY3ByZXZpZXctaW1hZ2UtdXBsb2FkZXJ7DQoJZGlzcGxheTpub25lICFpbXBvcnRhbnQ7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDF7DQoJZm9udC1zaXplOjIycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxMjUlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgloMnsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEyNSUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCWgzew0KCWZvbnQtc2l6ZToxOHB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTI1JSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDR7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTRweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZVByZWhlYWRlcnsNCglkaXNwbGF5OmJsb2NrICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxMnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCgl0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50LCAjdGVtcGxhdGVIZWFkZXIgLmVuZHJUZXh0Q29udGVudCBoMXsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbToxMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxNnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgkNCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50LC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJdGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50LCN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjEycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0NCjwvc3R5bGU-DQoNCjwhLS1baWYgbXNvXT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQpib2R5LCB0YWJsZSwgdGQge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoMSB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmgyIHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDMge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNCB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmg1IHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDYge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNyB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCnAge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQo8L3N0eWxlPg0KPCFbZW5kaWZdLS0-DQoNCjwhLS1baWYgZ3QgbXNvIDE1XT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgbWVkaWE9ImFsbCI-DQovKiBPdXRsb29rIDIwMTYgSGVpZ2h0IEZpeCAqLw0KdGFibGUsIHRyLCB0ZCB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTt9DQp0ciB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgfQ0KYm9keSB7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO30NCjwvc3R5bGU-DQo8IVtlbmRpZl0tLT4gICAgPC9oZWFkPg0KDQogICAgPGJvZHk-DQogICAgICAgIDxjZW50ZXIgY2xhc3M9IndyYXBwZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO3RhYmxlLWxheW91dDpmaXhlZDtiYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7Ij4NCiAgPGRpdiBjbGFzcz0id2Via2l0IiBzdHlsZT0ibWF4LXdpZHRoOjYwMHB4O21hcmdpbjowIGF1dG87Ij4NCiAgICAgIDx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgaGVpZ2h0PSIxMDAlIiB3aWR0aD0iMTAwJSIgaWQ9ImJvZHlUYWJsZSIgc3R5bGU9ImJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTtoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDt3aWR0aDoxMDAlO2JhY2tncm91bmQtY29sb3I6I2U0ZTNlNDtjb2xvcjojNWE1YTVhO2ZvbnQtZmFtaWx5OidMYXRvJywgSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsiPg0KICAgICAgICA8dGJvZHk-PHRyPg0KICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiBpZD0iYm9keUNlbGwiIHN0eWxlPSJoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7d2lkdGg6MTAwJTtwYWRkaW5nLXRvcDoxMHB4O3BhZGRpbmctYm90dG9tOjEwcHg7Ym9yZGVyLXRvcC13aWR0aDowOyI-DQo8IS0tIEJFR0lOIFRFTVBMQVRFIC8vIC0tPg0KPCEtLVtpZiAoZ3RlIG1zbyA5KXwoSUUpXT4NCjx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgd2lkdGg9IjYwMCIgc3R5bGU9IndpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiID4NCgk8dHI-DQoJPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiB3aWR0aD0iNjAwIiBzdHlsZT0id2lkdGg6NjAwcHg7IiA-DQoJCTwhW2VuZGlmXS0tPg0KCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGRhdGEtc3BhY2UtaGVhZGVyPg0KCQk8dGJvZHk-PHRyPg0KCQk8dGQ-DQogICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsiPg0KICAgICAgICAgICAgU2hpcCBieTogMTIvMDEvMjAyNiwgU3RhbmRhcmQgU2hpcHBpbmcNCiAgICAgICAgPC9kaXY-DQoNCiAgICAgICAgPCEtLSBCTE9DSyBMb2dvIENlbnRlciAtLT4NCiA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjA7IiBkYXRhLXNwYWNlLXNjLWhlYWRlcj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICA8dGQgY2xhc3M9InRlbXBsYXRlSGVhZGVyIiB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6IDIwcHggMDsgcGFkZGluZy1sZWZ0OjQwcHgiPg0KICAgICAgICAgIDxpbWcgYWxpZ249ImNlbnRlciIgYWx0PSIiIHNyYz0iaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvU1BBQ0UvbG9nby1zZWxsaW5nX2NvYWNoLnBuZyIgd2lkdGg9IjIwMCIgc3R5bGU9Im1heC13aWR0aDoyMDBweDtwYWRkaW5nLWJvdHRvbTowO2Rpc3BsYXk6aW5saW5lICFpbXBvcnRhbnQ7dmVydGljYWwtYWxpZ246Ym90dG9tO2JvcmRlci13aWR0aDowO2hlaWdodDphdXRvO291dGxpbmUtc3R5bGU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTstbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7Ij4NCiAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCjwhLS0gRU5EUiBIZWFkZXIgIC0tPg0KDQoNCjwvdGQ-DQo8L3RyPg0KPC90Ym9keT48L3RhYmxlPg0KDQo8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmOyIgYmdjb2xvcj0iI2ZmZmZmZiI-DQo8dGJvZHk-PHRyPg0KPHRkPg0KICAgICAgICA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iPg0KICAgICAgICAgICAgPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlQmxvY2tzIj4NCiAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiPg0KICAgICAgICAgICAgICAgICAgICA8dGFibGUgY2xhc3M9ImVuZHJUZXh0QmxvY2siPg0KICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5IGNsYXNzPSJlbmRyVGV4dEJsb2NrT3V0ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0iZW5kclRleHRCbG9ja0lubmVyIj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0YWJsZSBhbGlnbj0ibGVmdCIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnQiIGFsaWduPSJjZW50ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7bWFyZ2luLXRvcDoxMHB4O21hcmdpbi1ib3R0b206MTBweDttYXJnaW4tcmlnaHQ6MDttYXJnaW4tbGVmdDowO3BhZGRpbmctdG9wOjA7cGFkZGluZy1ib3R0b206MDtwYWRkaW5nLXJpZ2h0OjA7cGFkZGluZy1sZWZ0OjA7bGluZS1oZWlnaHQ6MTg1JTsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KDQoNCg0KDQoNCg0KDQoNCiAgICAgICAgICAgIDwvcD48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgIA0KICAgIA0KICAgIDxwPkNvbmdyYXR1bGF0aW9ucywgeW91IGhhdmUgYSBuZXcgb3JkZXIgb24gQW1hem9uISBZb3VyIGN1c3RvbWVyIGlzIGV4cGVjdGluZyB0aGlzIHRvIHNoaXAgYnkgMTIvMDEvMjAyNi48L3A-DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgPHA-UGxlYXNlIHJldmlldyB5b3VyIG9yZGVyOjwvcD4NCiAgICANCiAgICAgICAgICAgICAgICA8Y2VudGVyPg0KICAgICAgICAgICAgICAgICAgICA8ZGl2IHN0eWxlPSJtYXJnaW46IDIwcHggMHB4IDIwcHggMTBweDsgcGFkZGluZzoxMHB4OyBkaXNwbGF5OmlubGluZS1ibG9jazsgYmFja2dyb3VuZC1jb2xvcjojMDA2NTc0OyI-DQogICAgPGEgc3R5bGU9ImNvbG9yOiNmZmY7IHRleHQtZGVjb3JhdGlvbjpub25lOyIgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvc2VsbGVybW9iaWxlL3JlZGlyZWN0LzU0Y2UwNmI3LTUzNGYtM2MxNy1hNTY3LTFkMGRiM2YyZmJiNz9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1ZYkFYTTJIalVZM1hvMDZlOS1jNWZUV3VxblRaT0lwaEdNUzhsVjBoelJaWUpYaWlyR1llbURLMXNRVHB4UHFLajdkTm9jRWd2ZDZRdFB5bnlZeHQxUSZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl2Y21SbGNuTXRkak12YjNKa1pYSXZOREEwTFRFNE56VXhNVFV0T1RrME1qYzBNajl5WldaZlBYaDRYMlZ0WVdsc1gySnZaSGxmYzJocGNBIj4NCiAgICAgICAgVmlldyBPcmRlcg0KICAgIDwvYT4NCjwvZGl2Pg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luOiAyMHB4IDBweCAyMHB4IDIwcHg7IHBhZGRpbmc6MTBweDsgZGlzcGxheTppbmxpbmUtYmxvY2s7IGJhY2tncm91bmQtY29sb3I6I2UzZWNlZDsiPg0KICAgIDxhIHN0eWxlPSJjb2xvcjojMDAyZjM2OyB0ZXh0LWRlY29yYXRpb246bm9uZTsiIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC85NzY2NzAyZC1iYzM2LTM1ZTAtYmUyNC04YzczNGY1MGZhNmU_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9QkdEQzRDTU1vUUkwamVaSWJJS0VlczUtZEFPV1ZTOWdlSlRidUlLYWpaZFZGTXJTa3lUOEp0MDV2TmxURFUwdnRaSUItNHVwMjlOTFV2dmhQNjlaNXcmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5b1pXeHdMMmgxWWk5eVpXWmxjbVZ1WTJVdlJ6SXdNVE00TXpNME1EOXlaV1pmUFhoNFgyVnRZV2xzWDJKdlpIbGZhR1ZzY0EiPg0KICAgICAgICBHZXQgSGVscCBTaGlwcGluZyBZb3VyIE9yZGVyDQogICAgPC9hPg0KPC9kaXY-DQogICAgPC9jZW50ZXI-DQogICAgPGgzPk9yZGVyIERldGFpbHM8L2gzPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5PcmRlciBJRDo8L2I-IDQwNC0xODc1MTE1LTk5NDI3NDINCiAgICA8YnI-DQogICAgICAgICAgICAgICAgPGI-T3JkZXIgZGF0ZTo8L2I-IDEwLzAxLzIwMjYNCiAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UGxlYXNlIHNoaXAgdGhpcyBvcmRlciB1c2luZzo8L2I-IFN0YW5kYXJkIFNoaXBwaW5nDQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db2xsZWN0IG9uIERlbGl2ZXJ5IHByZXBhaWQ6PC9iPiBJTlIgMC4wMA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-Q29sbGVjdCBvbiBEZWxpdmVyeSBhbW91bnQ6PC9iPiBJTlIgNzQ3LjAwDQogICAgICAgIDxicj4NCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNoaXAgYnk6PC9iPiAxMi8wMS8yMDI2DQogICAgICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-SXRlbTo8L2I-IEdyaXBpdCBEaWdpdGFsIEpld2VsbGVyeSBXZWlnaGluZyBTY2FsZSAxMDAwZyB4IDAuMDFnIC0gUG9ydGFibGUgR29sZCwgU2lsdmVyLCBHZW0gJmFtcDsgQ29pbiBXZWlnaGluZyBNYWNoaW5lIHdpdGggTENEIERpc3BsYXkgLSBQcmVjaXNpb24gV2VpZ2h0IFNjYWxlIGZvciBIb21lLCBTaG9wICZhbXA7IFByb2Zlc3Npb25hbCBVc2UNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db25kaXRpb246PC9iPiBOZXcNCiAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNLVTo8L2I-IEF0b20tOTk5DQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UXVhbnRpdHk6PC9iPiAxDQogICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-UHJpY2U6PC9iPiBJTlIgNjI3LjEyDQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-VGF4OjwvYj4gSU5SIDExMi44OA0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5BbWF6b24gZmVlczo8L2I-IC1JTlIgMTA5Ljk4DQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-Q29sbGVjdCBvbiBEZWxpdmVyeSBmZWVzOjwvYj4gSU5SIDUuOTMNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgDQogICAgDQo8L2Rpdj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cD48L3A-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgIDwvdGQ-DQogICAgICAgICAgICA8L3RyPg0KICAgICAgICA8L3Rib2R5PjwvdGFibGU-DQoNCg0KICAgICAgICAgICAgICAgIA0KDQoJCQkJCQ0KCQkJCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7IiBkYXRhLXNwYWNlLWZvb3RlciBkYXRhLXNwYWNlLXNjLWZvb3Rlcj4NCgkJCQkJPHRib2R5Pjx0cj4NCgkJCQkJPHRkPg0KCQkJCQ0KCQkJCQk8IS0tIEJMT0NLIEZvb3RlciBBYm91dCBVcyAtLT4NCgkJCQkJPHRhYmxlIGNsYXNzPSJvbmUtY29sdW1uIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgd2lkdGg9IjEwMCUiIHN0eWxlPSJib3JkZXItc3BhY2luZzowOyIgZGlyPSJhdXRvIj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8Y2VudGVyIHN0eWxlPSJtYXJnaW4tdG9wOiAyMHB4OyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPGEgc3R5bGU9InBhZGRpbmc6IDdweCAyNHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGJhY2tncm91bmQ6ICNmZmY7IGJvcmRlcjogMXB4IHNvbGlkICNFQzkzN0M7IGJvcmRlci1yYWRpdXM6IDVweDsgY29sb3I6ICM3RjE4MDk7IGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsgZm9udC1zaXplOiAxM3B4OyBmb250LXdlaWdodDogNjAwO2Rpc3BsYXk6IGlubGluZS1ibG9jazsgbWFyZ2luLWJvdHRvbTogMTBweCIgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL2ZlZWRiYWNrP2RlbGl2ZXJ5SWQ9NjMzMzIwMzExMTYzODA0JmFtcDtjb21tdW5pY2F0aW9uTmFtZT1TT0xEX1NISVBfTk9XJmFtcDtkZWxpdmVyeUNoYW5uZWw9RU1BSUwiPg0KICAgICAgICAgICAgICAgICAgICA8aW1nIHNyYz0iaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvc3BhY2UvaWNvbi5wbmciIHN0eWxlPSJtYXJnaW4tcmlnaHQ6IDEwcHg7dmVydGljYWwtYWxpZ246IG1pZGRsZTsiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCI-UmVwb3J0IGFuIGlzc3VlIHdpdGggdGhpcyBlbWFpbA0KICAgICAgICAgICAgICAgICAgPC9hPg0KICAgICAgICAgICAgICAgICAgICAgICAgPC9jZW50ZXI-PHAgc3R5bGU9InRleHQtYWxpZ246Y2VudGVyICFpbXBvcnRhbnQ7bWFyZ2luLXRvcDoxMHB4O21hcmdpbi1ib3R0b206MTBweDttYXJnaW4tcmlnaHQ6MTBweDttYXJnaW4tbGVmdDoxNXB4O3BhZGRpbmctdG9wOjA7cGFkZGluZy1ib3R0b206MDtwYWRkaW5nLXJpZ2h0OjA7cGFkZGluZy1sZWZ0OjA7Y29sb3I6I2ZmZmZmZjtmb250LWZhbWlseTonQW1hem9uIEVtYmVyJztmb250LXNpemU6MTNweDtsaW5lLWhlaWdodDoxNTAlOyI-SWYgeW91IGhhdmUgYW55IHF1ZXN0aW9ucyB2aXNpdDogPGEgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvc2VsbGVybW9iaWxlL3JlZGlyZWN0LzRlNjUxNzNkLWQyNmUtMzc0OS1hMzEzLTRmM2IwODRjYjFjMT9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz1PZXJpam9hTzlKV3B3OFlEbmJVVmEtX3UwSUktc3F4YWhpZUktbGgxdjhmUE96WnA2OGZDaHF4ZF9hM1BLcTJvbUNPZnVvMV9nRFREVkU4TzZ6RzVOQSZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiZyIgbWV0cmljPSJoZWxwIiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOiBub25lOyBjb2xvcjogI2ZmZmZmZjsiPlNlbGxlciBDZW50cmFsPC9hPjxicj48YnI-DQoJCQkJCQkJCQkJCSAgICBUbyBjaGFuZ2UgeW91ciBlbWFpbCBwcmVmZXJlbmNlcyB2aXNpdDogPGEgaHJlZj0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvcmVkaXJlY3QvOTA1OGNjNDAtMTZhNi0zNjk0LThiOGEtZmJjYmNhM2QwNjQ5P250PVNPTERfU0hJUF9OT1cmYW1wO3NrPS1Nal9rOFBSQmY5aXIyTXA2RjRodERGaGU3U29OWHh6ODUxcDdwSjJ4NmpfLVZzQXhPb1NoM2NQejVwTm9adlJ4ZkVfSzNqbUVONG1ZRU1yS0NrZVNRJmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJpOXViM1JwWm1sallYUnBiMjV6TDNCeVpXWmxjbVZ1WTJWekwzSmxaajFwWkY5dWIzUnBabkJ5WldaZlpHNWhkbDk0ZUY4IiBtZXRyaWM9Im9wdG91dCIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjogbm9uZTsgY29sb3I6ICNmZmZmZmY7Ij5Ob3RpZmljYXRpb24gUHJlZmVyZW5jZXM8L2E-PGJyPjxicj4NCgkJCQkJCQkJCQkJCQkJCQkJCVdlIGhvcGUgeW91IGZvdW5kIHRoaXMgbWVzc2FnZSB0byBiZSB1c2VmdWwuIEhvd2V2ZXIsIGlmIHlvdSdkIHJhdGhlciBub3QgcmVjZWl2ZSBmdXR1cmUgZS1tYWlscyBvZiB0aGlzIHNvcnQgZnJvbSBBbWF6b24uY29tLCBwbGVhc2Ugb3B0LW91dCA8YSBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9yZWRpcmVjdC82YjdlNTEyYy1lMTRjLTMyNjItOGFkMy02ODUxZjRhZmFkMjQ_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9R2JmUzZYM0dJYU5TcVFGYU01ZUM1bDdhaVBuSzhhLXUwMlJMWWRlYm01Nm5BWEpkbi1TMk50ZGk3X05JM3BMUFFldDJaRHFfam1KS3pQanNhR3NwMXcmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5dWIzUnBabWxqWVhScGIyNXpMM0J5WldabGNtVnVZMlZ6TDI5d2RHOTFkRDl2Y0hSdmRYUkpaRDAzWkRGaU5tUm1ZUzA1T0RsbUxUUTFaakV0T1dGallTMWhNVE14TjJKbE4yWTRaR0kiIG1ldHJpYz0ib3B0b3V0IiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOiBub25lOyBjb2xvcjogI2ZmZmZmZjsiPmhlcmUuPC9hPjxicj48YnI-DQoJCQkJCQkJCQkJCQlDb3B5cmlnaHQgIDIwMjYgQW1hem9uLCBJbmMsIG9yIGl0cyBhZmZpbGlhdGVzLiBBbGwgcmlnaHRzIHJlc2VydmVkLjxicj4gDQoJCQkJCQkJCQkJCQlBbWF6b24gU2VsbGVyIFNlcnZpY2VzIFByaXZhdGUgTGltaXRlZCwgOHRoIGZsb29yLCBCcmlnYWRlIEdhdGV3YXksIDI2LzEgRHIuIFJhamt1bWFyIFJvYWQsIEJhbmdhbG9yZSA1NjAwNTUgKEthcm5hdGFrYSk8YnI-PC9wPjx0YWJsZSBhbGlnbj0ibGVmdCIgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHdpZHRoPSIxMDAlIiBjbGFzcz0iZW5kclRleHRDb250ZW50Q29udGFpbmVyIiBzdHlsZT0ibWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCQkJCTx0Ym9keT4NCgkJCQkJCQkJCQkJPHRyPg0KICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIA0KCQkJCQkJCQkJCQkNCiAgICAgICAgICAgICAgICAgICAgICAgIAkJCQkJPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGQ-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGJvZHk-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvdGFibGU-DQoJCQkJCQk8L3RkPg0KCQkJCQk8L3RyPg0KCQkJCQk8L3Rib2R5PjwvdGFibGU-DQoJCQkJCTwhLS0gQkxPQ0sgRm9vdGVyIEFib3V0IFVzIC0tPg0KCQkJCQk8L3RkPg0KCQkJCQk8L3RyPg0KCQkJCQk8L3Rib2R5PjwvdGFibGU-DQoJCQkJCQ0KCQkJCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiPg0KCQkJCQk8dGJvZHk-PHRyPg0KCQkJCQk8dGQ-DQoJCQkJDQoJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCgkJCQkJPCEtLVtpZiAoZ3RlIG1zbyA5KXwoSUUpXT4NCgkJCQk8L3RkPg0KCQkJCTwvdHI-DQoJCQk8L3RhYmxlPg0KCQkJPCFbZW5kaWZdLS0-DQoJCQk8IS0tIC8vIEVORCBURU1QTEFURSAtLT4NCgkJCTwvdGQ-DQoJCTwvdHI-DQoJCTwvdGJvZHk-PC90YWJsZT4gICAgDQoNCjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9kaXY-PC9jZW50ZXI-PGltZyBzcmM9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL2ltZy80YzlkMzM5Ny0zZTdkLTM3YzItOTY3Yi01MTM2OGE0NmM0ZGE_c2s9c3h3RHYzWDdvaFFONmp3R1Rfa3owSXRONWJSVkRIODBqa0xfUnBzQjFBamtYd0VobVd3VHQyS1NNWUpUTndLNTd2Y3FIZzhTbFlIWGRkaUliUUR3TFEmYW1wO249MSI-DQo8ZGl2IGlkPSJzcGMtd2F0ZXJtYXJrIj4NCiAgPHAgc3R5bGU9ImZvbnQtc2l6ZTogMTBweCAhaW1wb3J0YW50O3BhZGRpbmctYm90dG9tOiAxMHB4ICFpbXBvcnRhbnQ7ZGlzcGxheTogdGFibGUgIWltcG9ydGFudDttYXJnaW46IDVweCBhdXRvIDEwcHggIWltcG9ydGFudDt0ZXh0LWFsaWduOiBjZW50ZXIgIWltcG9ydGFudDtjb2xvcjogI2EyYTJhMiAhaW1wb3J0YW50O2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJyAhaW1wb3J0YW50O2ZvbnQtd2VpZ2h0OiA0MDAgIWltcG9ydGFudDsiPlNQQy1FVUFtYXpvbi02MzMzMjAzMTExNjM4MDQ8L3A-DQo8L2Rpdj48L2JvZHk-PC9odG1sPg=="}}]},"sizeEstimate":37323,"historyId":"2853525","internalDate":"1768071711000"}', '2026-01-11T04:56:57.402Z', '19ba9494df83e742', '19ba74365c56df1b', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('7b363d0426f5e912b0411f6327bf10b7', '101f04af63cbefc2bf8f0a98b9ae1205', 'Seller Notification <seller-notification@amazon.in>', 'Sold, ship now: PocketScale - White Digital Pocket Weighing Scale - Precise Jewellery Weight Machine Small, Gripit Portable Gold Weighing Machine for Accurate Measurements with Digital Display, Ideal for Gems, Herbs & More (White).', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        

<!--[if gte mso 15]>
<xml>
	<o:OfficeDocumentSettings>
	<o:AllowPNG/>
	<o:PixelsPerInch>96</o:PixelsPerInch>
	</o:OfficeDocumentSettings>
</xml>
<![endif]-->
<meta charset="UTF-8">
<!--[if !mso]><!-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--<![endif]-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="http://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet" type="text/css">
<style type="text/css">
	
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 300;
    src: local(''Amazon Ember Light''), local(''AmazonEmber-Light''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_lt_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 300;
    src: local(''Amazon Ember Light Italic''), local(''AmazonEmber-LightItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_ltit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 400;
    src: local(''Amazon Ember''), local(''AmazonEmber''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rg_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 400;
    src: local(''Amazon Ember Italic''), local(''AmazonEmber-Italic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_rgit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 600;
    src: local(''Amazon Ember Medium''), local(''AmazonEmber-Medium''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_md_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 600;
    src: local(''Amazon Ember Medium Italic''), local(''AmazonEmber-MediumItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_mdit_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: normal;
    font-weight: 700;
    src: local(''Amazon Ember Bold''), local(''AmazonEmber-Bold''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bd_base.woff) format(''woff'');
}
@font-face {
    font-family: ''Amazon Ember'';
    font-style: italic;
    font-weight: 700;
    src: local(''Amazon Ember Bold Italic''), local(''AmazonEmber-BoldItalic''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff2) format(''woff2''), url(https://m.media-amazon.com/images/G/01/nbus-common/woff/amazonember_bdit_base.woff) format(''woff'');
}



	.nbus-survey{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:visited{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:hover{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:focus{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	.nbus-survey:active{color: #FFF;font-family:''Amazon Ember'';font-size:13px;line-height:150%;text-align:center}
	
	one-column{border-spacing:0px;background-color:#FFFFFF;border:0px;padding:0px;width:100%;column-count:1;}
	endrImageBlock{padding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrImageBlockInner{padding:0px;}
	endrImageContentContainer{adding:0px;border-spacing:0px;min-width:100%;border-collapse:collapse;width:100%;border:0px;}
	endrTextContentContainer{min-width:100%;width:100%;border-collapse:collapse;background-color:#FFFFFF;border:0px;padding:0px;border-spacing:0px;}
	endrTextBlock{min-width:100%;border-collapse:collapse;background-color:#ffffff;width:100%padding:0px;border-spacing:0px;border:0px;}
	preview-text{display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';}
	
	p{
	text-align: left;
	margin-top:10px;
	margin-bottom:10px;
	margin-right:0;
	margin-left:0;
	padding-top:0;
	padding-bottom:0;
	padding-right:0;
	padding-left:0;
	line-height:185%;
	}
	table{
	border-collapse:collapse;
	}
	h1,h2,h3,h4,h5,h6{
	display:block;
	margin:0;
	padding:0;
	}
	img,a img{
	border:0;
	height:auto;
	outline:none;
	text-decoration:none;
	}
	pre{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	font-family:''Amazon Ember'';
	min-width:100%;
	white-space: pre-wrap;       /* Since CSS 2.1 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
	}
	body,#bodyTable,#bodyCell{
	height:100%;
	margin:0px;
	padding:0px;
	width:100%;
	background-color:#e4e3e4;
	color:#999999
	font-family:''Amazon Ember'';
	min-width:100%;
	}
	#outlook a{
	padding:0;
	}
	img{
	-ms-interpolation-mode:bicubic;
	}
	table{
	mso-table-lspace:0pt;
	mso-table-rspace:0pt;
	}
	.ReadMsgBody{
	width:100%;
	}
	.ExternalClass{
	width:100%;
	}
	p,a,li,td,blockquote{
	mso-line-height-rule:exactly;
	}
	a[href^=tel],a[href^=sms]{
	color:inherit;
	cursor:default;
	text-decoration:none;
	}
	p,a,li,td,body,table,blockquote{
	-ms-text-size-adjust:100%;
	-webkit-text-size-adjust:100%;
	}
	.ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{
	line-height:100%;
	}
	a[x-apple-data-detectors]{
	color:inherit !important;
	text-decoration:none !important;
	font-size:inherit !important;
	font-family:inherit !important;
	font-weight:inherit !important;
	line-height:inherit !important;
	}
	.templateContainer{
	max-width:600px !important;
	}
	.endrImage{
	vertical-align:bottom;
	}
	.endrTextContent{
	word-break:break-word;
	padding-top:15px;
	padding-bottom:10px;
	padding-right:18px;
	padding-left:18px;
	text-align: left;
	}
	.endrTextContent img{
	height:auto !important;
	}
	.endrDividerBlock{
	table-layout:fixed !important;
	}
	body { margin:0 !important; }
	div[style*="margin: 16px 0"] { margin:0 !important; }

	body,#bodyTable{
	background-color:#e4e3e4;
	color:#999999;
	font-family: ''Amazon Ember'';
	}
	
	.templateBlocks{
	background-color:#FFFFFF;
	border-top-width:0;
	border-bottom-width:0;
	padding-top:0;
	padding-bottom:0;
	font-size:15px;
	line-height:185%;
	text-align:left;
	background-color:#FFFFFF;
	}
	
	.templateQuoteBlocks{
	background-color:#F04D44;
	}
	
	#bodyCell{
	border-top:0;
	}

	h1{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:30px;
	font-style:normal;
	font-weight:normal;
	line-height:120%;
	letter-spacing:normal;
	padding-top:2px;
	padding-bottom:2px;
	}

	a{
	color:#e74c3c;
	font-weight:normal;
	text-decoration:underline;
	}

	h2{
	color:#848484;
	font-family: ''Amazon Ember'';
	font-size:15px;
	font-style:normal;
	font-weight:normal;
	line-height:145%;
	letter-spacing:1px;
	padding-top:5px;
	padding-bottom:4px;
	}

	h3{
	color:#455c64;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:140%;
	letter-spacing:normal;
	text-align:left;
	padding-top:2px;
	padding-bottom:2px;
	}

	h4{
	color:#666666;
	font-family: ''Amazon Ember'';
	font-size:16px;
	font-style:normal;
	font-weight:normal;
	line-height:125%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-bottom:4px;
	}

	h5{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:left;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	h6{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:26px;
	font-style:normal;
	font-weight:normal;
	line-height:135%;
	letter-spacing:normal;
	text-align:right;
	padding-top:11px;
	padding-right:20px;
	padding-bottom:8px;
	padding-left:20px;
	}

	#templatePreheader{
	border-top:0;
	border-bottom:0;
	padding-top:4px;
	padding-bottom:12px;
	}

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templatePreheader .endrTextContent a,#templatePreheader .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}

	#templateHeader{
	background-color:#303942;
	border-top:0px solid #e4e3e4;
	border-bottom:0;
	padding-top:0px;
	padding-bottom:0px;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent,#templateHeader .endrTextContent h1{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:20px;
	line-height:100%;
	text-align:right;
	}

	#templateHeader .endrTextContent a,#templateHeader .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:none;
	}

	#templateSeparator{
	padding-top:8px;
	padding-bottom:8px;
	}

	.templateLowerBody{
	background-color:#455C64;
	border-bottom:0;
	padding-top:1px;
	padding-bottom:1px;
	}

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	color:#ffffff;
	font-family: ''Amazon Ember'';
	font-size:13px;
	line-height:150%;
	text-align:left;
	}

	.templateLowerBody .endrTextContent a,.templateLowerBody .endrTextContent p a{
	color:#ffffff;
	font-weight:normal;
	text-decoration:underline;
	}

	.templateLowerBody .endrTextContent h1 {
	color:#ffffff;
	font-weight:700;
	font-size:18px;
	}

	.templateSocial{
	background-color:#e4e3e4;
	padding-top:13px;
	padding-bottom:3px;
	}

	#templateFooter{
	border-top:0;
	border-bottom:0;
	padding-top:5px;
	padding-bottom:5px;
	}

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	color:#fbfbfb;
	font-family: ''Amazon Ember'';
	font-size:12px;
	line-height:150%;
	text-align:center;
	}

	#templateFooter .endrTextContent a,#templateFooter .endrTextContent p a{
	color:#fbfbfb;
	font-weight:normal;
	text-decoration:underline;
	}
	
	@media only screen and (min-width:768px){
	.templateContainer{
	width:600px !important;
	}
	}	
	
	@media only screen and (max-width: 480px){
	
	.templateHeader{
		display: none;
	}
		
	.bigimage .endrImageContent{
	padding-top:0px !important;

	}
	.templateContainer{
	width:100% !important;
	max-width:600px;
	}	@media only screen and (max-width: 480px){
	body,table,td,p,a,li,blockquote{
	-webkit-text-size-adjust:none !important;
	}
	}	@media only screen and (max-width: 480px){
	body{
	width:100% !important;
	min-width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	#bodyCell{
	padding-top:10px !important;
	}
	}	@media only screen and (max-width: 480px){
	.columnWrapper{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImage{
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionTopContent,.endrCaptionBottomContent,.endrTextContentContainer,.endrBoxedTextContentContainer,.endrImageGroupContentContainer,.endrCaptionLeftTextContentContainer,.endrCaptionRightTextContentContainer,.endrCaptionLeftImageContentContainer,.endrCaptionRightImageContentContainer,.endrImageCardLeftTextContentContainer,.endrImageCardRightTextContentContainer{
	max-width:100% !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrBoxedTextContentContainer{
	min-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.column{
	width:100% !important;
	max-width:100% !important;
	}
	} @media only screen and (max-width: 480px){
	.endrImageGroupContent{
	padding:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrCaptionLeftContentOuter .endrTextContent,.endrCaptionRightContentOuter .endrTextContent{
	padding-top:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardTopImageContent,.endrCaptionBlockInner .endrCaptionTopContent:last-child .endrTextContent{
	padding-top:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardBottomImageContent{
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockInner{
	padding-top:0 !important;
	padding-bottom:0 !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageGroupBlockOuter{
	padding-top:9px !important;
	padding-bottom:9px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrTextContent,.endrBoxedTextContentColumn{
	padding-right:18px !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.endrImageCardLeftImageContent,.endrImageCardRightImageContent{
	padding-right:18px !important;
	padding-bottom:0 !important;
	padding-left:18px !important;
	}
	}	@media only screen and (max-width: 480px){
	.mcpreview-image-uploader{
	display:none !important;
	width:100% !important;
	}
	}	@media only screen and (max-width: 480px){

	h1{
	font-size:22px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h2{
	font-size:20px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h3{
	font-size:18px !important;
	line-height:125% !important;
	}
	}	@media only screen and (max-width: 480px){

	h4{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){
	
	.endrBoxedTextContentContainer .endrTextContent,.endrBoxedTextContentContainer .endrTextContent p{
	font-size:14px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader{
	display:block !important;
	}
	}	@media only screen and (max-width: 480px){

	#templatePreheader .endrTextContent,#templatePreheader .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateHeader .endrTextContent,#templateHeader .endrTextContent p{
	font-size:16px !important;
	line-height:100% !important;
	text-align:center !important;
	}

	#templateHeader .endrTextContent, #templateHeader .endrTextContent h1{
	font-size:20px !important;
	line-height:100% !important;
	padding-bottom:10px !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateUpperBody .endrTextContent,#templateUpperBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	
	}	@media only screen and (max-width: 480px){

	#templateColumns .columnContainer .endrTextContent,#templateColumns .columnContainer .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	}
	}	@media only screen and (max-width: 480px){

	.templateLowerBody .endrTextContent,.templateLowerBody .endrTextContent p{
	font-size:16px !important;
	line-height:150% !important;
	text-align:center !important;
	}
	}	@media only screen and (max-width: 480px){

	#templateFooter .endrTextContent,#templateFooter .endrTextContent p{
	font-size:12px !important;
	line-height:150% !important;
	}
	}
</style>

<!--[if mso]>
<style type="text/css">
body, table, td {font-family: ''Amazon Ember'';}
h1 {font-family: ''Amazon Ember'';}
h2 {font-family: ''Amazon Ember'';}
h3 {font-family: ''Amazon Ember'';}
h4 {font-family: ''Amazon Ember'';}
h5 {font-family: ''Amazon Ember'';}
h6 {font-family: ''Amazon Ember'';}
h7 {font-family: ''Amazon Ember'';}
p {font-family: ''Amazon Ember'';}
</style>
<![endif]-->

<!--[if gt mso 15]>
<style type="text/css" media="all">
/* Outlook 2016 Height Fix */
table, tr, td {border-collapse: collapse;}
tr {border-collapse: collapse; }
body {background-color:#ffffff;}
</style>
<![endif]-->    </head>

    <body>
        <center class="wrapper" style="width:100%;table-layout:fixed;background-color:#e4e3e4;">
  <div class="webkit" style="max-width:600px;margin:0 auto;">
      <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable" style="border-collapse:collapse;height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;width:100%;background-color:#e4e3e4;color:#5a5a5a;font-family:''Lato'', Helvetica, Arial, sans-serif;">
        <tbody><tr>
            <td align="center" valign="top" id="bodyCell" style="height:100%;margin-top:0;margin-bottom:0;margin-right:0;margin-left:0;width:100%;padding-top:10px;padding-bottom:10px;border-top-width:0;">
<!-- BEGIN TEMPLATE // -->
<!--[if (gte mso 9)|(IE)]>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;border-collapse:collapse;" >
	<tr>
	<td align="center" valign="top" width="600" style="width:600px;" >
		<![endif]-->
		<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-header>
		<tbody><tr>
		<td>
        <div style="display:none;font-size:1px;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;mso-hide:all;font-family: ''Amazon Ember'';">
            Ship by: 12/01/2026, Standard Shipping
        </div>

        <!-- BLOCK Logo Center -->
 <table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" data-space-sc-header>
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
          <td class="templateHeader" valign="top" style="padding: 20px 0; padding-left:40px">
          <img align="center" alt="" src="https://m.media-amazon.com/images/G/01/SPACE/logo-selling_coach.png" width="200" style="max-width:200px;padding-bottom:0;display:inline !important;vertical-align:bottom;border-width:0;height:auto;outline-style:none;text-decoration:none;-ms-interpolation-mode:bicubic;">
          </td>
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
<!-- ENDR Header  -->


</td>
</tr>
</tbody></table>

<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;background-color:#ffffff;" bgcolor="#ffffff">
<tbody><tr>
<td>
        <table class="one-column">
            <tbody><tr valign="top" class="templateBlocks">
                <td valign="top">
                    <table class="endrTextBlock">
                        <tbody class="endrTextBlockOuter">
                            <tr>
                                <td valign="top" class="endrTextBlockInner">
                                    <table align="left" class="endrTextContentContainer">
                                        <tbody>
                                            <tr>
                                                <td valign="top" class="endrTextContent" align="center">
                                                    <p style="text-align:left;margin-top:10px;margin-bottom:10px;margin-right:0;margin-left:0;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;line-height:185%;">
                                                        











            </p><div style="text-align:left">
                            
    
    
    <p>Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026.</p>

                            
                    <p>Please review your order:</p>
    
                <center>
                    <div style="margin: 20px 0px 20px 10px; padding:10px; display:inline-block; background-color:#006574;">
    <a style="color:#fff; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/1621812a-bf66-3ef6-b13d-f88f7e6e66d2?nt=SOLD_SHIP_NOW&amp;sk=Z_I8Rz52rdGakUxkBbAddB0K64SdZkpMeNCIYHMdUiSY8cVRfmjcndtjvpoi1sOz5TM4sbLoa5M2QDakwS9yuQ&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9vcmRlcnMtdjMvb3JkZXIvNDA2LTM4ODgwOTgtNDI2OTkyMT9yZWZfPXh4X2VtYWlsX2JvZHlfc2hpcA">
        View Order
    </a>
</div>

                            <div style="margin: 20px 0px 20px 20px; padding:10px; display:inline-block; background-color:#e3eced;">
    <a style="color:#002f36; text-decoration:none;" href="https://sellercentral.amazon.in/nms/sellermobile/redirect/cc0071bc-f680-3ec0-b03d-25cfdd84aa71?nt=SOLD_SHIP_NOW&amp;sk=BXqbJO0xYLCouQ0U_82B6wU-x0G7te7gowKhgyFxDHwRTk4IZNuT0NMmO9mSKeRGQR6DVXJ9a3Btk0dMvMY_ow&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9oZWxwL2h1Yi9yZWZlcmVuY2UvRzIwMTM4MzM0MD9yZWZfPXh4X2VtYWlsX2JvZHlfaGVscA">
        Get Help Shipping Your Order
    </a>
</div>
    </center>
    <h3>Order Details</h3>
                                <b>Order ID:</b> 406-3888098-4269921
    <br>
                <b>Order date:</b> 10/01/2026
    <br>
                                        <b>Please ship this order using:</b> Standard Shipping
        <br>
                                        <br>
                                        
                                                    <b>Ship by:</b> 12/01/2026
            <br>
                                        <b>Item:</b> Digital Pocket Weighing Scale - Precise Jewellery Weight Machine Small, Gripit Portable Gold Weighing Machine for Accurate Measurements with Digital Display, Ideal for Gems, Herbs &amp; More (White).
        <br>
                                                                    <b>Condition:</b> New
                    <br>
                                                                            <b>SKU:</b> PocketScale - White
        <br>
                                <b>Quantity:</b> 1
        <br>
                                            <b>Price:</b> INR 380.51
    <br>
                                                            <b>Tax:</b> INR 68.49
        <br>
                                                                                                                                                                                                                                                                                                                                                                                    <b>Amazon fees:</b> -INR 47.42
    <br>
                                                                                                                                                                                                                    <b>Your earnings:</b> INR 401.58
    <br>
            
    
    
</div>
                                                    <p></p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody></table>


                

					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" width="100%" style="width:100%;max-width:600px;border-collapse:collapse;" data-space-footer data-space-sc-footer>
					<tbody><tr>
					<td>
				
					<!-- BLOCK Footer About Us -->
					<table class="one-column" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-spacing:0;" dir="auto">
					<tbody><tr valign="top" style="border-top-width:0;border-bottom-width:0;font-size:14px;line-height:185%;text-align:left;">
						<td valign="top" class="templateLowerBody" style="background-color:#2a323a;">
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextBlock" style="min-width:100%;border-collapse:collapse;background-color:#2a323a;" bgcolor="#2a323a">
								<tbody class="endrTextBlockOuter">
									<tr>
										<td valign="top" class="endrTextBlockInner">
											<center style="margin-top: 20px;">
                        	<a style="padding: 7px 24px; text-decoration: none; background: #fff; border: 1px solid #EC937C; border-radius: 5px; color: #7F1809; font-family: ''Amazon Ember''; font-size: 13px; font-weight: 600;display: inline-block; margin-bottom: 10px" href="https://sellercentral.amazon.in/notifications/feedback?deliveryId=2163840496542824&amp;communicationName=SOLD_SHIP_NOW&amp;deliveryChannel=EMAIL">
                    <img src="https://m.media-amazon.com/images/G/01/space/icon.png" style="margin-right: 10px;vertical-align: middle;" width="20" height="20">Report an issue with this email
                  </a>
                        </center><p style="text-align:center !important;margin-top:10px;margin-bottom:10px;margin-right:10px;margin-left:15px;padding-top:0;padding-bottom:0;padding-right:0;padding-left:0;color:#ffffff;font-family:''Amazon Ember'';font-size:13px;line-height:150%;">If you have any questions visit: <a href="https://sellercentral.amazon.in/nms/sellermobile/redirect/4d9c8d43-a135-3c9c-bc17-f2a41c9315a1?nt=SOLD_SHIP_NOW&amp;sk=zJtMKQ4cEVdu33wMKNI_xMzv85h70Ifz3Q2caevoJjWXHtMkSTJcR5RNEKMqUTE2nceKW3iRy_AunKEEY1dktA&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbg" metric="help" style="text-decoration: none; color: #ffffff;">Seller Central</a><br><br>
											    To change your email preferences visit: <a href="https://sellercentral.amazon.in/nms/redirect/fc6111ba-de88-3595-a3db-3f1c81db1673?nt=SOLD_SHIP_NOW&amp;sk=nI2Wh0we4uWVeGWDmxjLm-3r348zKggUvftyrmHLNs7UhfpFmlkxqz08audiVo3YPschHLxdvHRJLd2BvA4c8w&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL3JlZj1pZF9ub3RpZnByZWZfZG5hdl94eF8" metric="optout" style="text-decoration: none; color: #ffffff;">Notification Preferences</a><br><br>
																		We hope you found this message to be useful. However, if you''d rather not receive future e-mails of this sort from Amazon.com, please opt-out <a href="https://sellercentral.amazon.in/nms/redirect/113e22ca-b593-392c-b932-23ee8ce3ddda?nt=SOLD_SHIP_NOW&amp;sk=3OFgY6Qx9l7z_FDLZ5a8Qvi9xb_ap9fqKMVyXeYKmhJYSlO9d-yWe_wPQedjG-KPsDKT2LQtC4IDjAwEWA7eZg&amp;n=1&amp;u=aHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ub3RpZmljYXRpb25zL3ByZWZlcmVuY2VzL29wdG91dD9vcHRvdXRJZD1lN2FhOWUyZS1jMGY1LTQ5NjQtYTc0YS1hM2IxYmRkZmNjNDQ" metric="optout" style="text-decoration: none; color: #ffffff;">here.</a><br><br>
												Copyright  2026 Amazon, Inc, or its affiliates. All rights reserved.<br> 
												Amazon Seller Services Private Limited, 8th floor, Brigade Gateway, 26/1 Dr. Rajkumar Road, Bangalore 560055 (Karnataka)<br></p><table align="left" border="0" cellpadding="0" cellspacing="0" width="100%" class="endrTextContentContainer" style="min-width:100%;border-collapse:collapse;" bgcolor="#2a323a">
											<tbody>
											<tr>
                        
                        
                        
											
                        					</tr>
                                            </tbody>
                                            </table>
                                       </td>
                                   </tr>
                             </tbody>
                             </table>
						</td>
					</tr>
					</tbody></table>
					<!-- BLOCK Footer About Us -->
					</td>
					</tr>
					</tbody></table>
					
					<table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="width:100%;max-width:600px;border-collapse:collapse;">
					<tbody><tr>
					<td>
				
					</td>
					</tr>
					</tbody></table>
					<!--[if (gte mso 9)|(IE)]>
				</td>
				</tr>
			</table>
			<![endif]-->
			<!-- // END TEMPLATE -->
			</td>
		</tr>
		</tbody></table>    

</td></tr></tbody></table></div></center><img src="https://sellercentral.amazon.in/nms/img/f6bd2bf1-fbc6-388b-bc56-7ab4890a1e51?sk=waHxKKzfzj_hE6wNtq9Yls_li2wIegzAejRsLXS8-qjJfNKwqqZneHW_JhsnoYbygsC5S0jtPVPSLVXkazAGAg&amp;n=1">
<div id="spc-watermark">
  <p style="font-size: 10px !important;padding-bottom: 10px !important;display: table !important;margin: 5px auto 10px !important;text-align: center !important;color: #a2a2a2 !important;font-family: ''Amazon Ember'' !important;font-weight: 400 !important;">SPC-EUAmazon-2163840496542824</p>
</div></body></html>', '2026-01-10T17:05:02.000Z', '{"id":"19ba8de5838f2b27","threadId":"19b9c2f156ccf4e7","labelIds":["UNREAD","CATEGORY_UPDATES","INBOX"],"snippet":"Ship by: 12/01/2026, Standard Shipping Congratulations, you have a new order on Amazon! Your customer is expecting this to ship by 12/01/2026. Please review your order: View Order Get Help Shipping","payload":{"partId":"","mimeType":"multipart/alternative","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2358160pxc;        Sat, 10 Jan 2026 09:05:03 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IEcbFjCnn4v7En3l6RxWd/iixd9ZmZt/HS7f1Hme++Gmx80O0/f/lznwsFgAKdxrufTrlv3"},{"name":"X-Received","value":"by 2002:a05:6000:24c2:b0:430:f68f:ee96 with SMTP id ffacd0b85a97d-432c37c8649mr14546998f8f.36.1768064702970;        Sat, 10 Jan 2026 09:05:02 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768064702; cv=none;        d=google.com; s=arc-20240605;        b=HCZ4cWa25Q1ETxS0Weh0hR2RpIr/UFrn5ldTKZ3i4d6LHp4GL1GrL1WBJ9oVhPTrYm         BPS4KuixVBEnudY3plPfgsEjdRm7RJKHxMCzBYQxrVvs9NUbTQ/6QGYt79/1SBSt7eaQ         4EUR/Bc0Sxn/vLwauMlkdQBOL2l2+fJljGiV1FjLB/rmRv8eZAfkOzVVzANGMYc/lPnm         WTJnZVxQFcSKcGr+xEbqpFDDkV+dCb1O/8XoeJLQiCO+oo8T+QWutlOy6R5SWQasmMyV         xOkGoQk3o9yABel9c25bYN610GGx2L8l6YoAMFDsh2SZGIDLFjXMhJHHThRpBrnDWQ1e         mdBA=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=feedback-id:list-unsubscribe-post:list-unsubscribe:bounces-to         :mime-version:subject:message-id:to:reply-to:from:date         :dkim-signature:dkim-signature;        bh=TPP9GMt0Z1NR+y/xYHCUhyzhkKeQDoVfUl/PqGcyG+Q=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=HaRoHHA3Hh+oZ5gcQrUWnG820JXptyaxxKy+XydateLRHmW0MSkQeFACj8VntIQ8Ji         YT4k1VMxR6NvQhDNU/6bgrrh/PDK9cil3wj7H8EDZV4zfybJ8DAR3twjtFRd2u+TNEKu         MiZlgzA1HRpKtS/tN6a1MireD533Vr0QvVu5a3OmVxxpBeT2GTu/brKN9mfQ/GL6fs4l         WEmrDqlPz4yKtU6ri+xOn98mwNVnjDQDEzrkVZwi02j+ATSv61U4N8lGTnAv6GB1Bk+P         Zd9SbToi8M8wxR32e2wLwZEZRQnEFpvJE6mTiG/00gS0cuV06CIBrXg8wHBe6AfIKIWc         IJEw==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=bmmB4W3V;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=JGlZWpCP;       spf=pass (google.com: domain of 0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com designates 76.223.149.203 as permitted sender) smtp.mailfrom=0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"Return-Path","value":"<0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com>"},{"name":"Received","value":"from c149-203.smtp-out.eu-west-1.amazonses.com (c149-203.smtp-out.eu-west-1.amazonses.com. [76.223.149.203])        by mx.google.com with ESMTPS id ffacd0b85a97d-432bd60672dsi22159257f8f.224.2026.01.10.09.05.02        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Sat, 10 Jan 2026 09:05:02 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of 0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com designates 76.223.149.203 as permitted sender) client-ip=76.223.149.203;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@amazon.in header.s=oispgif7zht3cwr3nad5jndkl43aztnu header.b=bmmB4W3V;       dkim=pass header.i=@amazonses.com header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=JGlZWpCP;       spf=pass (google.com: domain of 0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com designates 76.223.149.203 as permitted sender) smtp.mailfrom=0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.in"},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=oispgif7zht3cwr3nad5jndkl43aztnu; d=amazon.in; t=1768064702; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post; bh=lZwOezBUT1SADbcL6tnck9jOtfw+b55p27a1/3yEfi4=; b=bmmB4W3V6WJcotg0D1KhOSG799Tp1PttfNu0xHS7+0dyR5KlBsHMxJpIC0p2DeII 8yESK1QvNsGkBAS23NS2nf94uy8LTqAHj5WNb9DQeSiWzWyzLGs3j8dfbPYFCOW8czV WoVjjpbZk2GsGvYfIZ1EyCsFPXO6Uos96nP9gLWr6MAEfvd6/EGv5Kn9Li3HLNhYhWU 1gj2oQ6Q/eWGPKDh/HT/15AW+HxwbsmJw/Ly8VvfclrwS3seQBkZ4qGVoBc1nv5EY2N UVIh8drk7kdsso6YmiN5/woR2ITAOC/AJ13q76nLGpUdfdCgo77TD8Z/hNTT7DJCwLG 6uGMQ64kDg=="},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768064702; h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:List-Unsubscribe:List-Unsubscribe-Post:Feedback-ID; bh=lZwOezBUT1SADbcL6tnck9jOtfw+b55p27a1/3yEfi4=; b=JGlZWpCPaA7ZvvC9UvHNVVO1mJwziJjwEy5P7h7Acf9N/RSfeBwaon8Ef46a3mcH xZvIaGXvQShVZ9UpvZOHpnVNodT0NiozgNITc5QIxCj2x6BI8g9h/rUOfyZQN9+lfws /QPH/MXyVQynyyNgiYCq4HKUaH6kafQHzqIqmUJ0="},{"name":"Date","value":"Sat, 10 Jan 2026 17:05:02 +0000"},{"name":"From","value":"Seller Notification <seller-notification@amazon.in>"},{"name":"Reply-To","value":"seller-notification@amazon.in"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Message-ID","value":"<0102019ba8de57cf-0ad77d4a-a2fa-4f48-a27b-1c7b064397d8-000000@eu-west-1.amazonses.com>"},{"name":"Subject","value":"Sold, ship now: PocketScale - White Digital Pocket Weighing Scale - Precise Jewellery Weight Machine Small, Gripit Portable Gold Weighing Machine for Accurate Measurements with Digital Display, Ideal for Gems, Herbs & More (White)."},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/alternative; boundary=\"----=_Part_1329510_704426156.1768064702409\""},{"name":"Bounces-to","value":"RTE+NE-null-b1cb1A01052231D7WUU93XLPGJ@sellernotifications.amazon.com"},{"name":"X-Space-Message-ID","value":"2163840496542824"},{"name":"X-Marketplace-ID","value":"A21TJRUUN4KGV"},{"name":"List-Unsubscribe","value":"<https://sellercentral.amazon.in/notifications/preferences/optout/header-one-click?optoutId=e7aa9e2e-c0f5-4964-a74a-a3b1bddfcc44>"},{"name":"List-Unsubscribe-Post","value":"List-Unsubscribe=One-Click"},{"name":"Feedback-ID","value":"::1.eu-west-1.QXQDwfZxBksRk8Fey1ctk1ELdO+bec9bLwquzardhBQ=:AmazonSES"},{"name":"X-SES-Outgoing","value":"2026.01.10-76.223.149.203"}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"7bit"}],"body":{"size":31108,"data":"PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg0KPGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zOnY9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206dm1sIiB4bWxuczpvPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTpvZmZpY2UiPg0KDQogICAgPGhlYWQ-DQogICAgICAgIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4NCiAgICAgICAgDQoNCjwhLS1baWYgZ3RlIG1zbyAxNV0-DQo8eG1sPg0KCTxvOk9mZmljZURvY3VtZW50U2V0dGluZ3M-DQoJPG86QWxsb3dQTkcvPg0KCTxvOlBpeGVsc1BlckluY2g-OTY8L286UGl4ZWxzUGVySW5jaD4NCgk8L286T2ZmaWNlRG9jdW1lbnRTZXR0aW5ncz4NCjwveG1sPg0KPCFbZW5kaWZdLS0-DQo8bWV0YSBjaGFyc2V0PSJVVEYtOCI-DQo8IS0tW2lmICFtc29dPjwhLS0-DQoJCTxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSI-DQoJPCEtLTwhW2VuZGlmXS0tPg0KPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIj4NCjx0aXRsZT48L3RpdGxlPg0KPGxpbmsgaHJlZj0iaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TGF0bzo0MDAsNzAwIiByZWw9InN0eWxlc2hlZXQiIHR5cGU9InRleHQvY3NzIj4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQoJDQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogbm9ybWFsOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0JyksIGxvY2FsKCdBbWF6b25FbWJlci1MaWdodCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9sdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiAzMDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIExpZ2h0IEl0YWxpYycpLCBsb2NhbCgnQW1hem9uRW1iZXItTGlnaHRJdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbHRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2x0aXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXInKSwgbG9jYWwoJ0FtYXpvbkVtYmVyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnX2Jhc2Uud29mZjIpIGZvcm1hdCgnd29mZjInKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBpdGFsaWM7DQogICAgZm9udC13ZWlnaHQ6IDQwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfcmdpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX3JnaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDYwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgTWVkaXVtJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW0nKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9tZF9iYXNlLndvZmYpIGZvcm1hdCgnd29mZicpOw0KfQ0KQGZvbnQtZmFjZSB7DQogICAgZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KICAgIGZvbnQtc3R5bGU6IGl0YWxpYzsNCiAgICBmb250LXdlaWdodDogNjAwOw0KICAgIHNyYzogbG9jYWwoJ0FtYXpvbiBFbWJlciBNZWRpdW0gSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1NZWRpdW1JdGFsaWMnKSwgdXJsKGh0dHBzOi8vbS5tZWRpYS1hbWF6b24uY29tL2ltYWdlcy9HLzAxL25idXMtY29tbW9uL3dvZmYvYW1hem9uZW1iZXJfbWRpdF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX21kaXRfYmFzZS53b2ZmKSBmb3JtYXQoJ3dvZmYnKTsNCn0NCkBmb250LWZhY2Ugew0KICAgIGZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCiAgICBmb250LXN0eWxlOiBub3JtYWw7DQogICAgZm9udC13ZWlnaHQ6IDcwMDsNCiAgICBzcmM6IGxvY2FsKCdBbWF6b24gRW1iZXIgQm9sZCcpLCBsb2NhbCgnQW1hem9uRW1iZXItQm9sZCcpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZF9iYXNlLndvZmYyKSBmb3JtYXQoJ3dvZmYyJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkX2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQpAZm9udC1mYWNlIHsNCiAgICBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQogICAgZm9udC1zdHlsZTogaXRhbGljOw0KICAgIGZvbnQtd2VpZ2h0OiA3MDA7DQogICAgc3JjOiBsb2NhbCgnQW1hem9uIEVtYmVyIEJvbGQgSXRhbGljJyksIGxvY2FsKCdBbWF6b25FbWJlci1Cb2xkSXRhbGljJyksIHVybChodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9uYnVzLWNvbW1vbi93b2ZmL2FtYXpvbmVtYmVyX2JkaXRfYmFzZS53b2ZmMikgZm9ybWF0KCd3b2ZmMicpLCB1cmwoaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvbmJ1cy1jb21tb24vd29mZi9hbWF6b25lbWJlcl9iZGl0X2Jhc2Uud29mZikgZm9ybWF0KCd3b2ZmJyk7DQp9DQoNCg0KDQoJLm5idXMtc3VydmV5e2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJLm5idXMtc3VydmV5OnZpc2l0ZWR7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6aG92ZXJ7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6Zm9jdXN7Y29sb3I6ICNGRkY7Zm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7Zm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MTUwJTt0ZXh0LWFsaWduOmNlbnRlcn0NCgkubmJ1cy1zdXJ2ZXk6YWN0aXZle2NvbG9yOiAjRkZGO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7dGV4dC1hbGlnbjpjZW50ZXJ9DQoJDQoJb25lLWNvbHVtbntib3JkZXItc3BhY2luZzowcHg7YmFja2dyb3VuZC1jb2xvcjojRkZGRkZGO2JvcmRlcjowcHg7cGFkZGluZzowcHg7d2lkdGg6MTAwJTtjb2x1bW4tY291bnQ6MTt9DQoJZW5kckltYWdlQmxvY2t7cGFkZGluZzowcHg7Ym9yZGVyLXNwYWNpbmc6MHB4O21pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTt3aWR0aDoxMDAlO2JvcmRlcjowcHg7fQ0KCWVuZHJJbWFnZUJsb2NrSW5uZXJ7cGFkZGluZzowcHg7fQ0KCWVuZHJJbWFnZUNvbnRlbnRDb250YWluZXJ7YWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7bWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO3dpZHRoOjEwMCU7Ym9yZGVyOjBweDt9DQoJZW5kclRleHRDb250ZW50Q29udGFpbmVye21pbi13aWR0aDoxMDAlO3dpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO2JhY2tncm91bmQtY29sb3I6I0ZGRkZGRjtib3JkZXI6MHB4O3BhZGRpbmc6MHB4O2JvcmRlci1zcGFjaW5nOjBweDt9DQoJZW5kclRleHRCbG9ja3ttaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO3dpZHRoOjEwMCVwYWRkaW5nOjBweDtib3JkZXItc3BhY2luZzowcHg7Ym9yZGVyOjBweDt9DQoJcHJldmlldy10ZXh0e2Rpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQoJDQoJcHsNCgl0ZXh0LWFsaWduOiBsZWZ0Ow0KCW1hcmdpbi10b3A6MTBweDsNCgltYXJnaW4tYm90dG9tOjEwcHg7DQoJbWFyZ2luLXJpZ2h0OjA7DQoJbWFyZ2luLWxlZnQ6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJcGFkZGluZy1yaWdodDowOw0KCXBhZGRpbmctbGVmdDowOw0KCWxpbmUtaGVpZ2h0OjE4NSU7DQoJfQ0KCXRhYmxlew0KCWJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsNCgl9DQoJaDEsaDIsaDMsaDQsaDUsaDZ7DQoJZGlzcGxheTpibG9jazsNCgltYXJnaW46MDsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZyxhIGltZ3sNCglib3JkZXI6MDsNCgloZWlnaHQ6YXV0bzsNCglvdXRsaW5lOm5vbmU7DQoJdGV4dC1kZWNvcmF0aW9uOm5vbmU7DQoJfQ0KCXByZXsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJZm9udC1mYW1pbHk6J0FtYXpvbiBFbWJlcic7DQoJbWluLXdpZHRoOjEwMCU7DQoJd2hpdGUtc3BhY2U6IHByZS13cmFwOyAgICAgICAvKiBTaW5jZSBDU1MgMi4xICovDQogICAgd2hpdGUtc3BhY2U6IC1tb3otcHJlLXdyYXA7ICAvKiBNb3ppbGxhLCBzaW5jZSAxOTk5ICovDQogICAgd2hpdGUtc3BhY2U6IC1wcmUtd3JhcDsgICAgICAvKiBPcGVyYSA0LTYgKi8NCiAgICB3aGl0ZS1zcGFjZTogLW8tcHJlLXdyYXA7ICAgIC8qIE9wZXJhIDcgKi8NCiAgICB3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7ICAgICAgIC8qIEludGVybmV0IEV4cGxvcmVyIDUuNSsgKi8NCgl9DQoJYm9keSwjYm9keVRhYmxlLCNib2R5Q2VsbHsNCgloZWlnaHQ6MTAwJTsNCgltYXJnaW46MHB4Ow0KCXBhZGRpbmc6MHB4Ow0KCXdpZHRoOjEwMCU7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCWNvbG9yOiM5OTk5OTkNCglmb250LWZhbWlseTonQW1hem9uIEVtYmVyJzsNCgltaW4td2lkdGg6MTAwJTsNCgl9DQoJI291dGxvb2sgYXsNCglwYWRkaW5nOjA7DQoJfQ0KCWltZ3sNCgktbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7DQoJfQ0KCXRhYmxlew0KCW1zby10YWJsZS1sc3BhY2U6MHB0Ow0KCW1zby10YWJsZS1yc3BhY2U6MHB0Ow0KCX0NCgkuUmVhZE1zZ0JvZHl7DQoJd2lkdGg6MTAwJTsNCgl9DQoJLkV4dGVybmFsQ2xhc3N7DQoJd2lkdGg6MTAwJTsNCgl9DQoJcCxhLGxpLHRkLGJsb2NrcXVvdGV7DQoJbXNvLWxpbmUtaGVpZ2h0LXJ1bGU6ZXhhY3RseTsNCgl9DQoJYVtocmVmXj10ZWxdLGFbaHJlZl49c21zXXsNCgljb2xvcjppbmhlcml0Ow0KCWN1cnNvcjpkZWZhdWx0Ow0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCglwLGEsbGksdGQsYm9keSx0YWJsZSxibG9ja3F1b3Rlew0KCS1tcy10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OjEwMCU7DQoJfQ0KCS5FeHRlcm5hbENsYXNzLC5FeHRlcm5hbENsYXNzIHAsLkV4dGVybmFsQ2xhc3MgdGQsLkV4dGVybmFsQ2xhc3MgZGl2LC5FeHRlcm5hbENsYXNzIHNwYW4sLkV4dGVybmFsQ2xhc3MgZm9udHsNCglsaW5lLWhlaWdodDoxMDAlOw0KCX0NCglhW3gtYXBwbGUtZGF0YS1kZXRlY3RvcnNdew0KCWNvbG9yOmluaGVyaXQgIWltcG9ydGFudDsNCgl0ZXh0LWRlY29yYXRpb246bm9uZSAhaW1wb3J0YW50Ow0KCWZvbnQtc2l6ZTppbmhlcml0ICFpbXBvcnRhbnQ7DQoJZm9udC1mYW1pbHk6aW5oZXJpdCAhaW1wb3J0YW50Ow0KCWZvbnQtd2VpZ2h0OmluaGVyaXQgIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDppbmhlcml0ICFpbXBvcnRhbnQ7DQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgltYXgtd2lkdGg6NjAwcHggIWltcG9ydGFudDsNCgl9DQoJLmVuZHJJbWFnZXsNCgl2ZXJ0aWNhbC1hbGlnbjpib3R0b207DQoJfQ0KCS5lbmRyVGV4dENvbnRlbnR7DQoJd29yZC1icmVhazpicmVhay13b3JkOw0KCXBhZGRpbmctdG9wOjE1cHg7DQoJcGFkZGluZy1ib3R0b206MTBweDsNCglwYWRkaW5nLXJpZ2h0OjE4cHg7DQoJcGFkZGluZy1sZWZ0OjE4cHg7DQoJdGV4dC1hbGlnbjogbGVmdDsNCgl9DQoJLmVuZHJUZXh0Q29udGVudCBpbWd7DQoJaGVpZ2h0OmF1dG8gIWltcG9ydGFudDsNCgl9DQoJLmVuZHJEaXZpZGVyQmxvY2t7DQoJdGFibGUtbGF5b3V0OmZpeGVkICFpbXBvcnRhbnQ7DQoJfQ0KCWJvZHkgeyBtYXJnaW46MCAhaW1wb3J0YW50OyB9DQoJZGl2W3N0eWxlKj0ibWFyZ2luOiAxNnB4IDAiXSB7IG1hcmdpbjowICFpbXBvcnRhbnQ7IH0NCg0KCWJvZHksI2JvZHlUYWJsZXsNCgliYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7DQoJY29sb3I6Izk5OTk5OTsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJfQ0KCQ0KCS50ZW1wbGF0ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGRkZGRkY7DQoJYm9yZGVyLXRvcC13aWR0aDowOw0KCWJvcmRlci1ib3R0b20td2lkdGg6MDsNCglwYWRkaW5nLXRvcDowOw0KCXBhZGRpbmctYm90dG9tOjA7DQoJZm9udC1zaXplOjE1cHg7DQoJbGluZS1oZWlnaHQ6MTg1JTsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJYmFja2dyb3VuZC1jb2xvcjojRkZGRkZGOw0KCX0NCgkNCgkudGVtcGxhdGVRdW90ZUJsb2Nrc3sNCgliYWNrZ3JvdW5kLWNvbG9yOiNGMDRENDQ7DQoJfQ0KCQ0KCSNib2R5Q2VsbHsNCglib3JkZXItdG9wOjA7DQoJfQ0KDQoJaDF7DQoJY29sb3I6IzQ1NWM2NDsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjMwcHg7DQoJZm9udC1zdHlsZTpub3JtYWw7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCWxpbmUtaGVpZ2h0OjEyMCU7DQoJbGV0dGVyLXNwYWNpbmc6bm9ybWFsOw0KCXBhZGRpbmctdG9wOjJweDsNCglwYWRkaW5nLWJvdHRvbToycHg7DQoJfQ0KDQoJYXsNCgljb2xvcjojZTc0YzNjOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCWgyew0KCWNvbG9yOiM4NDg0ODQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxNXB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDUlOw0KCWxldHRlci1zcGFjaW5nOjFweDsNCglwYWRkaW5nLXRvcDo1cHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWgzew0KCWNvbG9yOiM0NTVjNjQ7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxNDAlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MnB4Ow0KCXBhZGRpbmctYm90dG9tOjJweDsNCgl9DQoNCgloNHsNCgljb2xvcjojNjY2NjY2Ow0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTZweDsNCglmb250LXN0eWxlOm5vcm1hbDsNCglmb250LXdlaWdodDpub3JtYWw7DQoJbGluZS1oZWlnaHQ6MTI1JTsNCglsZXR0ZXItc3BhY2luZzpub3JtYWw7DQoJdGV4dC1hbGlnbjpsZWZ0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1ib3R0b206NHB4Ow0KCX0NCg0KCWg1ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyMHB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOmxlZnQ7DQoJcGFkZGluZy10b3A6MTFweDsNCglwYWRkaW5nLXJpZ2h0OjIwcHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCXBhZGRpbmctbGVmdDoyMHB4Ow0KCX0NCg0KCWg2ew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToyNnB4Ow0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCglsaW5lLWhlaWdodDoxMzUlOw0KCWxldHRlci1zcGFjaW5nOm5vcm1hbDsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCXBhZGRpbmctdG9wOjExcHg7DQoJcGFkZGluZy1yaWdodDoyMHB4Ow0KCXBhZGRpbmctYm90dG9tOjhweDsNCglwYWRkaW5nLWxlZnQ6MjBweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXJ7DQoJYm9yZGVyLXRvcDowOw0KCWJvcmRlci1ib3R0b206MDsNCglwYWRkaW5nLXRvcDo0cHg7DQoJcGFkZGluZy1ib3R0b206MTJweDsNCgl9DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInOw0KCWZvbnQtc2l6ZToxMnB4Ow0KCWxpbmUtaGVpZ2h0OjE1MCU7DQoJdGV4dC1hbGlnbjpjZW50ZXI7DQoJfQ0KDQoJI3RlbXBsYXRlUHJlaGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgYSwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwIGF7DQoJY29sb3I6I2ZiZmJmYjsNCglmb250LXdlaWdodDpub3JtYWw7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTsNCgl9DQoNCgkjdGVtcGxhdGVIZWFkZXJ7DQoJYmFja2dyb3VuZC1jb2xvcjojMzAzOTQyOw0KCWJvcmRlci10b3A6MHB4IHNvbGlkICNlNGUzZTQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjBweDsNCglwYWRkaW5nLWJvdHRvbTowcHg7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxMDAlOw0KCXRleHQtYWxpZ246cmlnaHQ7DQoJfQ0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgaDF7DQoJY29sb3I6I2ZmZmZmZjsNCglmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7DQoJZm9udC1zaXplOjIwcHg7DQoJbGluZS1oZWlnaHQ6MTAwJTsNCgl0ZXh0LWFsaWduOnJpZ2h0Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmZmZmZmY7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjpub25lOw0KCX0NCg0KCSN0ZW1wbGF0ZVNlcGFyYXRvcnsNCglwYWRkaW5nLXRvcDo4cHg7DQoJcGFkZGluZy1ib3R0b206OHB4Ow0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keXsNCgliYWNrZ3JvdW5kLWNvbG9yOiM0NTVDNjQ7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjFweDsNCglwYWRkaW5nLWJvdHRvbToxcHg7DQoJfQ0KDQoJLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQsLnRlbXBsYXRlTG93ZXJCb2R5IC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTNweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246bGVmdDsNCgl9DQoNCgkudGVtcGxhdGVMb3dlckJvZHkgLmVuZHJUZXh0Q29udGVudCBhLC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHAgYXsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0Om5vcm1hbDsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lOw0KCX0NCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IGgxIHsNCgljb2xvcjojZmZmZmZmOw0KCWZvbnQtd2VpZ2h0OjcwMDsNCglmb250LXNpemU6MThweDsNCgl9DQoNCgkudGVtcGxhdGVTb2NpYWx7DQoJYmFja2dyb3VuZC1jb2xvcjojZTRlM2U0Ow0KCXBhZGRpbmctdG9wOjEzcHg7DQoJcGFkZGluZy1ib3R0b206M3B4Ow0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlcnsNCglib3JkZXItdG9wOjA7DQoJYm9yZGVyLWJvdHRvbTowOw0KCXBhZGRpbmctdG9wOjVweDsNCglwYWRkaW5nLWJvdHRvbTo1cHg7DQoJfQ0KDQoJI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCgljb2xvcjojZmJmYmZiOw0KCWZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsNCglmb250LXNpemU6MTJweDsNCglsaW5lLWhlaWdodDoxNTAlOw0KCXRleHQtYWxpZ246Y2VudGVyOw0KCX0NCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IGEsI3RlbXBsYXRlRm9vdGVyIC5lbmRyVGV4dENvbnRlbnQgcCBhew0KCWNvbG9yOiNmYmZiZmI7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7DQoJfQ0KCQ0KCUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDo3NjhweCl7DQoJLnRlbXBsYXRlQ29udGFpbmVyew0KCXdpZHRoOjYwMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JDQoJDQoJQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLnRlbXBsYXRlSGVhZGVyew0KCQlkaXNwbGF5OiBub25lOw0KCX0NCgkJDQoJLmJpZ2ltYWdlIC5lbmRySW1hZ2VDb250ZW50ew0KCXBhZGRpbmctdG9wOjBweCAhaW1wb3J0YW50Ow0KDQoJfQ0KCS50ZW1wbGF0ZUNvbnRhaW5lcnsNCgl3aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJbWF4LXdpZHRoOjYwMHB4Ow0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJYm9keSx0YWJsZSx0ZCxwLGEsbGksYmxvY2txdW90ZXsNCgktd2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6bm9uZSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCWJvZHl7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCW1pbi13aWR0aDoxMDAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJI2JvZHlDZWxsew0KCXBhZGRpbmctdG9wOjEwcHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uV3JhcHBlcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25Ub3BDb250ZW50LC5lbmRyQ2FwdGlvbkJvdHRvbUNvbnRlbnQsLmVuZHJUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJJbWFnZUdyb3VwQ29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0VGV4dENvbnRlbnRDb250YWluZXIsLmVuZHJDYXB0aW9uUmlnaHRUZXh0Q29udGVudENvbnRhaW5lciwuZW5kckNhcHRpb25MZWZ0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRyQ2FwdGlvblJpZ2h0SW1hZ2VDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkTGVmdFRleHRDb250ZW50Q29udGFpbmVyLC5lbmRySW1hZ2VDYXJkUmlnaHRUZXh0Q29udGVudENvbnRhaW5lcnsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckJveGVkVGV4dENvbnRlbnRDb250YWluZXJ7DQoJbWluLXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgl9DQoJfSBAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuY29sdW1uew0KCXdpZHRoOjEwMCUgIWltcG9ydGFudDsNCgltYXgtd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9IEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VHcm91cENvbnRlbnR7DQoJcGFkZGluZzo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckNhcHRpb25MZWZ0Q29udGVudE91dGVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJDYXB0aW9uUmlnaHRDb250ZW50T3V0ZXIgLmVuZHJUZXh0Q29udGVudHsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZFRvcEltYWdlQ29udGVudCwuZW5kckNhcHRpb25CbG9ja0lubmVyIC5lbmRyQ2FwdGlvblRvcENvbnRlbnQ6bGFzdC1jaGlsZCAuZW5kclRleHRDb250ZW50ew0KCXBhZGRpbmctdG9wOjE4cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlQ2FyZEJvdHRvbUltYWdlQ29udGVudHsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kckltYWdlR3JvdXBCbG9ja0lubmVyew0KCXBhZGRpbmctdG9wOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTowICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJLmVuZHJJbWFnZUdyb3VwQmxvY2tPdXRlcnsNCglwYWRkaW5nLXRvcDo5cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbTo5cHggIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCgkuZW5kclRleHRDb250ZW50LC5lbmRyQm94ZWRUZXh0Q29udGVudENvbHVtbnsNCglwYWRkaW5nLXJpZ2h0OjE4cHggIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5lbmRySW1hZ2VDYXJkTGVmdEltYWdlQ29udGVudCwuZW5kckltYWdlQ2FyZFJpZ2h0SW1hZ2VDb250ZW50ew0KCXBhZGRpbmctcmlnaHQ6MThweCAhaW1wb3J0YW50Ow0KCXBhZGRpbmctYm90dG9tOjAgIWltcG9ydGFudDsNCglwYWRkaW5nLWxlZnQ6MThweCAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KCS5tY3ByZXZpZXctaW1hZ2UtdXBsb2FkZXJ7DQoJZGlzcGxheTpub25lICFpbXBvcnRhbnQ7DQoJd2lkdGg6MTAwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDF7DQoJZm9udC1zaXplOjIycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxMjUlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgloMnsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEyNSUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCWgzew0KCWZvbnQtc2l6ZToxOHB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTI1JSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJaDR7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoJDQoJLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsLmVuZHJCb3hlZFRleHRDb250ZW50Q29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTRweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZVByZWhlYWRlcnsNCglkaXNwbGF5OmJsb2NrICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVQcmVoZWFkZXIgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxMnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlSGVhZGVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCgl0ZXh0LWFsaWduOmNlbnRlciAhaW1wb3J0YW50Ow0KCX0NCg0KCSN0ZW1wbGF0ZUhlYWRlciAuZW5kclRleHRDb250ZW50LCAjdGVtcGxhdGVIZWFkZXIgLmVuZHJUZXh0Q29udGVudCBoMXsNCglmb250LXNpemU6MjBweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjEwMCUgIWltcG9ydGFudDsNCglwYWRkaW5nLWJvdHRvbToxMHB4ICFpbXBvcnRhbnQ7DQoJfQ0KCX0JQG1lZGlhIG9ubHkgc2NyZWVuIGFuZCAobWF4LXdpZHRoOiA0ODBweCl7DQoNCgkjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCwjdGVtcGxhdGVVcHBlckJvZHkgLmVuZHJUZXh0Q29udGVudCBwew0KCWZvbnQtc2l6ZToxNnB4ICFpbXBvcnRhbnQ7DQoJbGluZS1oZWlnaHQ6MTUwJSAhaW1wb3J0YW50Ow0KCX0NCgkNCgl9CUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNDgwcHgpew0KDQoJI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQsI3RlbXBsYXRlQ29sdW1ucyAuY29sdW1uQ29udGFpbmVyIC5lbmRyVGV4dENvbnRlbnQgcHsNCglmb250LXNpemU6MTZweCAhaW1wb3J0YW50Ow0KCWxpbmUtaGVpZ2h0OjE1MCUgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCS50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50LC50ZW1wbGF0ZUxvd2VyQm9keSAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjE2cHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJdGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDsNCgl9DQoJfQlAbWVkaWEgb25seSBzY3JlZW4gYW5kIChtYXgtd2lkdGg6IDQ4MHB4KXsNCg0KCSN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50LCN0ZW1wbGF0ZUZvb3RlciAuZW5kclRleHRDb250ZW50IHB7DQoJZm9udC1zaXplOjEycHggIWltcG9ydGFudDsNCglsaW5lLWhlaWdodDoxNTAlICFpbXBvcnRhbnQ7DQoJfQ0KCX0NCjwvc3R5bGU-DQoNCjwhLS1baWYgbXNvXT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI-DQpib2R5LCB0YWJsZSwgdGQge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoMSB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmgyIHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDMge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNCB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCmg1IHtmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7fQ0KaDYge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQpoNyB7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInO30NCnAge2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzt9DQo8L3N0eWxlPg0KPCFbZW5kaWZdLS0-DQoNCjwhLS1baWYgZ3QgbXNvIDE1XT4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgbWVkaWE9ImFsbCI-DQovKiBPdXRsb29rIDIwMTYgSGVpZ2h0IEZpeCAqLw0KdGFibGUsIHRyLCB0ZCB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTt9DQp0ciB7Ym9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsgfQ0KYm9keSB7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO30NCjwvc3R5bGU-DQo8IVtlbmRpZl0tLT4gICAgPC9oZWFkPg0KDQogICAgPGJvZHk-DQogICAgICAgIDxjZW50ZXIgY2xhc3M9IndyYXBwZXIiIHN0eWxlPSJ3aWR0aDoxMDAlO3RhYmxlLWxheW91dDpmaXhlZDtiYWNrZ3JvdW5kLWNvbG9yOiNlNGUzZTQ7Ij4NCiAgPGRpdiBjbGFzcz0id2Via2l0IiBzdHlsZT0ibWF4LXdpZHRoOjYwMHB4O21hcmdpbjowIGF1dG87Ij4NCiAgICAgIDx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgaGVpZ2h0PSIxMDAlIiB3aWR0aD0iMTAwJSIgaWQ9ImJvZHlUYWJsZSIgc3R5bGU9ImJvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTtoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDt3aWR0aDoxMDAlO2JhY2tncm91bmQtY29sb3I6I2U0ZTNlNDtjb2xvcjojNWE1YTVhO2ZvbnQtZmFtaWx5OidMYXRvJywgSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsiPg0KICAgICAgICA8dGJvZHk-PHRyPg0KICAgICAgICAgICAgPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiBpZD0iYm9keUNlbGwiIHN0eWxlPSJoZWlnaHQ6MTAwJTttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO21hcmdpbi1yaWdodDowO21hcmdpbi1sZWZ0OjA7d2lkdGg6MTAwJTtwYWRkaW5nLXRvcDoxMHB4O3BhZGRpbmctYm90dG9tOjEwcHg7Ym9yZGVyLXRvcC13aWR0aDowOyI-DQo8IS0tIEJFR0lOIFRFTVBMQVRFIC8vIC0tPg0KPCEtLVtpZiAoZ3RlIG1zbyA5KXwoSUUpXT4NCjx0YWJsZSBhbGlnbj0iY2VudGVyIiBib3JkZXI9IjAiIGNlbGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgd2lkdGg9IjYwMCIgc3R5bGU9IndpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiID4NCgk8dHI-DQoJPHRkIGFsaWduPSJjZW50ZXIiIHZhbGlnbj0idG9wIiB3aWR0aD0iNjAwIiBzdHlsZT0id2lkdGg6NjAwcHg7IiA-DQoJCTwhW2VuZGlmXS0tPg0KCQk8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjYwMHB4O2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGRhdGEtc3BhY2UtaGVhZGVyPg0KCQk8dGJvZHk-PHRyPg0KCQk8dGQ-DQogICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZTtmb250LXNpemU6MXB4O2xpbmUtaGVpZ2h0OjFweDttYXgtaGVpZ2h0OjBweDttYXgtd2lkdGg6MHB4O29wYWNpdHk6MDtvdmVyZmxvdzpoaWRkZW47bXNvLWhpZGU6YWxsO2ZvbnQtZmFtaWx5OiAnQW1hem9uIEVtYmVyJzsiPg0KICAgICAgICAgICAgU2hpcCBieTogMTIvMDEvMjAyNiwgU3RhbmRhcmQgU2hpcHBpbmcNCiAgICAgICAgPC9kaXY-DQoNCiAgICAgICAgPCEtLSBCTE9DSyBMb2dvIENlbnRlciAtLT4NCiA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjA7IiBkYXRhLXNwYWNlLXNjLWhlYWRlcj4NCgkJCQkJPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgc3R5bGU9ImJvcmRlci10b3Atd2lkdGg6MDtib3JkZXItYm90dG9tLXdpZHRoOjA7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MTg1JTt0ZXh0LWFsaWduOmxlZnQ7Ij4NCgkJCQkJCTx0ZCB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlTG93ZXJCb2R5IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyI-DQogICAgICAgICAgICAgICAgICAgICAgICAJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0QmxvY2siIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojMmEzMjNhOyIgYmdjb2xvcj0iIzJhMzIzYSI-DQoJCQkJCQkJCTx0Ym9keSBjbGFzcz0iZW5kclRleHRCbG9ja091dGVyIj4NCgkJCQkJCQkJCTx0cj4NCgkJCQkJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dEJsb2NrSW5uZXIiPg0KCQkJCQkJCQkJCQk8dGFibGUgYWxpZ249ImxlZnQiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciIgc3R5bGU9Im1pbi13aWR0aDoxMDAlO2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQkJCQk8dGJvZHk-DQoJCQkJCQkJCQkJCTx0cj4NCiAgICAgICAgICA8dGQgY2xhc3M9InRlbXBsYXRlSGVhZGVyIiB2YWxpZ249InRvcCIgc3R5bGU9InBhZGRpbmc6IDIwcHggMDsgcGFkZGluZy1sZWZ0OjQwcHgiPg0KICAgICAgICAgIDxpbWcgYWxpZ249ImNlbnRlciIgYWx0PSIiIHNyYz0iaHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvU1BBQ0UvbG9nby1zZWxsaW5nX2NvYWNoLnBuZyIgd2lkdGg9IjIwMCIgc3R5bGU9Im1heC13aWR0aDoyMDBweDtwYWRkaW5nLWJvdHRvbTowO2Rpc3BsYXk6aW5saW5lICFpbXBvcnRhbnQ7dmVydGljYWwtYWxpZ246Ym90dG9tO2JvcmRlci13aWR0aDowO2hlaWdodDphdXRvO291dGxpbmUtc3R5bGU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTstbXMtaW50ZXJwb2xhdGlvbi1tb2RlOmJpY3ViaWM7Ij4NCiAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCjwhLS0gRU5EUiBIZWFkZXIgIC0tPg0KDQoNCjwvdGQ-DQo8L3RyPg0KPC90Ym9keT48L3RhYmxlPg0KDQo8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGNsYXNzPSJ0ZW1wbGF0ZUNvbnRhaW5lciIgd2lkdGg9IjEwMCUiIHN0eWxlPSJ3aWR0aDoxMDAlO21heC13aWR0aDo2MDBweDtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmOyIgYmdjb2xvcj0iI2ZmZmZmZiI-DQo8dGJvZHk-PHRyPg0KPHRkPg0KICAgICAgICA8dGFibGUgY2xhc3M9Im9uZS1jb2x1bW4iPg0KICAgICAgICAgICAgPHRib2R5Pjx0ciB2YWxpZ249InRvcCIgY2xhc3M9InRlbXBsYXRlQmxvY2tzIj4NCiAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiPg0KICAgICAgICAgICAgICAgICAgICA8dGFibGUgY2xhc3M9ImVuZHJUZXh0QmxvY2siPg0KICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5IGNsYXNzPSJlbmRyVGV4dEJsb2NrT3V0ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0iZW5kclRleHRCbG9ja0lubmVyIj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0YWJsZSBhbGlnbj0ibGVmdCIgY2xhc3M9ImVuZHJUZXh0Q29udGVudENvbnRhaW5lciI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnQiIGFsaWduPSJjZW50ZXIiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7bWFyZ2luLXRvcDoxMHB4O21hcmdpbi1ib3R0b206MTBweDttYXJnaW4tcmlnaHQ6MDttYXJnaW4tbGVmdDowO3BhZGRpbmctdG9wOjA7cGFkZGluZy1ib3R0b206MDtwYWRkaW5nLXJpZ2h0OjA7cGFkZGluZy1sZWZ0OjA7bGluZS1oZWlnaHQ6MTg1JTsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQogICAgICAgICAgICA8L3A-PGRpdiBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0Ij4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICANCiAgICANCiAgICA8cD5Db25ncmF0dWxhdGlvbnMsIHlvdSBoYXZlIGEgbmV3IG9yZGVyIG9uIEFtYXpvbiEgWW91ciBjdXN0b21lciBpcyBleHBlY3RpbmcgdGhpcyB0byBzaGlwIGJ5IDEyLzAxLzIwMjYuPC9wPg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgIDxwPlBsZWFzZSByZXZpZXcgeW91ciBvcmRlcjo8L3A-DQogICAgDQogICAgICAgICAgICAgICAgPGNlbnRlcj4NCiAgICAgICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luOiAyMHB4IDBweCAyMHB4IDEwcHg7IHBhZGRpbmc6MTBweDsgZGlzcGxheTppbmxpbmUtYmxvY2s7IGJhY2tncm91bmQtY29sb3I6IzAwNjU3NDsiPg0KICAgIDxhIHN0eWxlPSJjb2xvcjojZmZmOyB0ZXh0LWRlY29yYXRpb246bm9uZTsiIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3NlbGxlcm1vYmlsZS9yZWRpcmVjdC8xNjIxODEyYS1iZjY2LTNlZjYtYjEzZC1mODhmN2U2ZTY2ZDI_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9Wl9JOFJ6NTJyZEdha1V4a0JiQWRkQjBLNjRTZFprcE1lTkNJWUhNZFVpU1k4Y1ZSZm1qY25kdGp2cG9pMXNPejVUTTRzYkxvYTVNMlFEYWt3Uzl5dVEmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5dmNtUmxjbk10ZGpNdmIzSmtaWEl2TkRBMkxUTTRPRGd3T1RndE5ESTJPVGt5TVQ5eVpXWmZQWGg0WDJWdFlXbHNYMkp2WkhsZmMyaHBjQSI-DQogICAgICAgIFZpZXcgT3JkZXINCiAgICA8L2E-DQo8L2Rpdj4NCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxkaXYgc3R5bGU9Im1hcmdpbjogMjBweCAwcHggMjBweCAyMHB4OyBwYWRkaW5nOjEwcHg7IGRpc3BsYXk6aW5saW5lLWJsb2NrOyBiYWNrZ3JvdW5kLWNvbG9yOiNlM2VjZWQ7Ij4NCiAgICA8YSBzdHlsZT0iY29sb3I6IzAwMmYzNjsgdGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9zZWxsZXJtb2JpbGUvcmVkaXJlY3QvY2MwMDcxYmMtZjY4MC0zZWMwLWIwM2QtMjVjZmRkODRhYTcxP250PVNPTERfU0hJUF9OT1cmYW1wO3NrPUJYcWJKTzB4WUxDb3VRMFVfODJCNndVLXgwRzd0ZTdnb3dLaGd5RnhESHdSVGs0SVpOdVQwTk1tTzltU0tlUkdRUjZEVlhKOWEzQnRrMGRNdk1ZX293JmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJpOW9aV3h3TDJoMVlpOXlaV1psY21WdVkyVXZSekl3TVRNNE16TTBNRDl5WldaZlBYaDRYMlZ0WVdsc1gySnZaSGxmYUdWc2NBIj4NCiAgICAgICAgR2V0IEhlbHAgU2hpcHBpbmcgWW91ciBPcmRlcg0KICAgIDwvYT4NCjwvZGl2Pg0KICAgIDwvY2VudGVyPg0KICAgIDxoMz5PcmRlciBEZXRhaWxzPC9oMz4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-T3JkZXIgSUQ6PC9iPiA0MDYtMzg4ODA5OC00MjY5OTIxDQogICAgPGJyPg0KICAgICAgICAgICAgICAgIDxiPk9yZGVyIGRhdGU6PC9iPiAxMC8wMS8yMDI2DQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlBsZWFzZSBzaGlwIHRoaXMgb3JkZXIgdXNpbmc6PC9iPiBTdGFuZGFyZCBTaGlwcGluZw0KICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNoaXAgYnk6PC9iPiAxMi8wMS8yMDI2DQogICAgICAgICAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-SXRlbTo8L2I-IERpZ2l0YWwgUG9ja2V0IFdlaWdoaW5nIFNjYWxlIC0gUHJlY2lzZSBKZXdlbGxlcnkgV2VpZ2h0IE1hY2hpbmUgU21hbGwsIEdyaXBpdCBQb3J0YWJsZSBHb2xkIFdlaWdoaW5nIE1hY2hpbmUgZm9yIEFjY3VyYXRlIE1lYXN1cmVtZW50cyB3aXRoIERpZ2l0YWwgRGlzcGxheSwgSWRlYWwgZm9yIEdlbXMsIEhlcmJzICZhbXA7IE1vcmUgKFdoaXRlKS4NCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Db25kaXRpb246PC9iPiBOZXcNCiAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNLVTo8L2I-IFBvY2tldFNjYWxlIC0gV2hpdGUNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5RdWFudGl0eTo8L2I-IDENCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5QcmljZTo8L2I-IElOUiAzODAuNTENCiAgICA8YnI-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5UYXg6PC9iPiBJTlIgNjguNDkNCiAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI-QW1hem9uIGZlZXM6PC9iPiAtSU5SIDQ3LjQyDQogICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Yj5Zb3VyIGVhcm5pbmdzOjwvYj4gSU5SIDQwMS41OA0KICAgIDxicj4NCiAgICAgICAgICAgIA0KICAgIA0KICAgIA0KPC9kaXY-DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHA-PC9wPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCiAgICAgICAgICAgICAgICA8L3RkPg0KICAgICAgICAgICAgPC90cj4NCiAgICAgICAgPC90Ym9keT48L3RhYmxlPg0KDQoNCiAgICAgICAgICAgICAgICANCg0KCQkJCQkNCgkJCQkJPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBjbGFzcz0idGVtcGxhdGVDb250YWluZXIiIHdpZHRoPSIxMDAlIiBzdHlsZT0id2lkdGg6MTAwJTttYXgtd2lkdGg6NjAwcHg7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlOyIgZGF0YS1zcGFjZS1mb290ZXIgZGF0YS1zcGFjZS1zYy1mb290ZXI-DQoJCQkJCTx0Ym9keT48dHI-DQoJCQkJCTx0ZD4NCgkJCQkNCgkJCQkJPCEtLSBCTE9DSyBGb290ZXIgQWJvdXQgVXMgLS0-DQoJCQkJCTx0YWJsZSBjbGFzcz0ib25lLWNvbHVtbiIgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHdpZHRoPSIxMDAlIiBzdHlsZT0iYm9yZGVyLXNwYWNpbmc6MDsiIGRpcj0iYXV0byI-DQoJCQkJCTx0Ym9keT48dHIgdmFsaWduPSJ0b3AiIHN0eWxlPSJib3JkZXItdG9wLXdpZHRoOjA7Ym9yZGVyLWJvdHRvbS13aWR0aDowO2ZvbnQtc2l6ZToxNHB4O2xpbmUtaGVpZ2h0OjE4NSU7dGV4dC1hbGlnbjpsZWZ0OyI-DQoJCQkJCQk8dGQgdmFsaWduPSJ0b3AiIGNsYXNzPSJ0ZW1wbGF0ZUxvd2VyQm9keSIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6IzJhMzIzYTsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgCTx0YWJsZSBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgd2lkdGg9IjEwMCUiIGNsYXNzPSJlbmRyVGV4dEJsb2NrIiBzdHlsZT0ibWluLXdpZHRoOjEwMCU7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlO2JhY2tncm91bmQtY29sb3I6IzJhMzIzYTsiIGJnY29sb3I9IiMyYTMyM2EiPg0KCQkJCQkJCQk8dGJvZHkgY2xhc3M9ImVuZHJUZXh0QmxvY2tPdXRlciI-DQoJCQkJCQkJCQk8dHI-DQoJCQkJCQkJCQkJPHRkIHZhbGlnbj0idG9wIiBjbGFzcz0iZW5kclRleHRCbG9ja0lubmVyIj4NCgkJCQkJCQkJCQkJPGNlbnRlciBzdHlsZT0ibWFyZ2luLXRvcDogMjBweDsiPg0KICAgICAgICAgICAgICAgICAgICAgICAgCTxhIHN0eWxlPSJwYWRkaW5nOiA3cHggMjRweDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBiYWNrZ3JvdW5kOiAjZmZmOyBib3JkZXI6IDFweCBzb2xpZCAjRUM5MzdDOyBib3JkZXItcmFkaXVzOiA1cHg7IGNvbG9yOiAjN0YxODA5OyBmb250LWZhbWlseTogJ0FtYXpvbiBFbWJlcic7IGZvbnQtc2l6ZTogMTNweDsgZm9udC13ZWlnaHQ6IDYwMDtkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IG1hcmdpbi1ib3R0b206IDEwcHgiIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm90aWZpY2F0aW9ucy9mZWVkYmFjaz9kZWxpdmVyeUlkPTIxNjM4NDA0OTY1NDI4MjQmYW1wO2NvbW11bmljYXRpb25OYW1lPVNPTERfU0hJUF9OT1cmYW1wO2RlbGl2ZXJ5Q2hhbm5lbD1FTUFJTCI-DQogICAgICAgICAgICAgICAgICAgIDxpbWcgc3JjPSJodHRwczovL20ubWVkaWEtYW1hem9uLmNvbS9pbWFnZXMvRy8wMS9zcGFjZS9pY29uLnBuZyIgc3R5bGU9Im1hcmdpbi1yaWdodDogMTBweDt2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOyIgd2lkdGg9IjIwIiBoZWlnaHQ9IjIwIj5SZXBvcnQgYW4gaXNzdWUgd2l0aCB0aGlzIGVtYWlsDQogICAgICAgICAgICAgICAgICA8L2E-DQogICAgICAgICAgICAgICAgICAgICAgICA8L2NlbnRlcj48cCBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXIgIWltcG9ydGFudDttYXJnaW4tdG9wOjEwcHg7bWFyZ2luLWJvdHRvbToxMHB4O21hcmdpbi1yaWdodDoxMHB4O21hcmdpbi1sZWZ0OjE1cHg7cGFkZGluZy10b3A6MDtwYWRkaW5nLWJvdHRvbTowO3BhZGRpbmctcmlnaHQ6MDtwYWRkaW5nLWxlZnQ6MDtjb2xvcjojZmZmZmZmO2ZvbnQtZmFtaWx5OidBbWF6b24gRW1iZXInO2ZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjE1MCU7Ij5JZiB5b3UgaGF2ZSBhbnkgcXVlc3Rpb25zIHZpc2l0OiA8YSBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9zZWxsZXJtb2JpbGUvcmVkaXJlY3QvNGQ5YzhkNDMtYTEzNS0zYzljLWJjMTctZjJhNDFjOTMxNWExP250PVNPTERfU0hJUF9OT1cmYW1wO3NrPXpKdE1LUTRjRVZkdTMzd01LTklfeE16djg1aDcwSWZ6M1EyY2Fldm9KaldYSHRNa1NUSmNSNVJORUtNcVVURTJuY2VLVzNpUnlfQXVuS0VFWTFka3RBJmFtcDtuPTEmYW1wO3U9YUhSMGNITTZMeTl6Wld4c1pYSmpaVzUwY21Gc0xtRnRZWHB2Ymk1cGJnIiBtZXRyaWM9ImhlbHAiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjZmZmZmZmOyI-U2VsbGVyIENlbnRyYWw8L2E-PGJyPjxicj4NCgkJCQkJCQkJCQkJICAgIFRvIGNoYW5nZSB5b3VyIGVtYWlsIHByZWZlcmVuY2VzIHZpc2l0OiA8YSBocmVmPSJodHRwczovL3NlbGxlcmNlbnRyYWwuYW1hem9uLmluL25tcy9yZWRpcmVjdC9mYzYxMTFiYS1kZTg4LTM1OTUtYTNkYi0zZjFjODFkYjE2NzM_bnQ9U09MRF9TSElQX05PVyZhbXA7c2s9bkkyV2gwd2U0dVdWZUdXRG14akxtLTNyMzQ4ektnZ1V2ZnR5cm1ITE5zN1VoZnBGbWxreHF6MDhhdWRpVm8zWVBzY2hITHhkdkhSSkxkMkJ2QTRjOHcmYW1wO249MSZhbXA7dT1hSFIwY0hNNkx5OXpaV3hzWlhKalpXNTBjbUZzTG1GdFlYcHZiaTVwYmk5dWIzUnBabWxqWVhScGIyNXpMM0J5WldabGNtVnVZMlZ6TDNKbFpqMXBaRjl1YjNScFpuQnlaV1pmWkc1aGRsOTRlRjgiIG1ldHJpYz0ib3B0b3V0IiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOiBub25lOyBjb2xvcjogI2ZmZmZmZjsiPk5vdGlmaWNhdGlvbiBQcmVmZXJlbmNlczwvYT48YnI-PGJyPg0KCQkJCQkJCQkJCQkJCQkJCQkJV2UgaG9wZSB5b3UgZm91bmQgdGhpcyBtZXNzYWdlIHRvIGJlIHVzZWZ1bC4gSG93ZXZlciwgaWYgeW91J2QgcmF0aGVyIG5vdCByZWNlaXZlIGZ1dHVyZSBlLW1haWxzIG9mIHRoaXMgc29ydCBmcm9tIEFtYXpvbi5jb20sIHBsZWFzZSBvcHQtb3V0IDxhIGhyZWY9Imh0dHBzOi8vc2VsbGVyY2VudHJhbC5hbWF6b24uaW4vbm1zL3JlZGlyZWN0LzExM2UyMmNhLWI1OTMtMzkyYy1iOTMyLTIzZWU4Y2UzZGRkYT9udD1TT0xEX1NISVBfTk9XJmFtcDtzaz0zT0ZnWTZReDlsN3pfRkRMWjVhOFF2aTl4Yl9hcDlmcUtNVnlYZVlLbWhKWVNsTzlkLXlXZV93UFFlZGpHLUtQc0RLVDJMUXRDNElEakF3RVdBN2VaZyZhbXA7bj0xJmFtcDt1PWFIUjBjSE02THk5elpXeHNaWEpqWlc1MGNtRnNMbUZ0WVhwdmJpNXBiaTl1YjNScFptbGpZWFJwYjI1ekwzQnlaV1psY21WdVkyVnpMMjl3ZEc5MWREOXZjSFJ2ZFhSSlpEMWxOMkZoT1dVeVpTMWpNR1kxTFRRNU5qUXRZVGMwWVMxaE0ySXhZbVJrWm1Oak5EUSIgbWV0cmljPSJvcHRvdXQiIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246IG5vbmU7IGNvbG9yOiAjZmZmZmZmOyI-aGVyZS48L2E-PGJyPjxicj4NCgkJCQkJCQkJCQkJCUNvcHlyaWdodCAgMjAyNiBBbWF6b24sIEluYywgb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuPGJyPiANCgkJCQkJCQkJCQkJCUFtYXpvbiBTZWxsZXIgU2VydmljZXMgUHJpdmF0ZSBMaW1pdGVkLCA4dGggZmxvb3IsIEJyaWdhZGUgR2F0ZXdheSwgMjYvMSBEci4gUmFqa3VtYXIgUm9hZCwgQmFuZ2Fsb3JlIDU2MDA1NSAoS2FybmF0YWthKTxicj48L3A-PHRhYmxlIGFsaWduPSJsZWZ0IiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgd2lkdGg9IjEwMCUiIGNsYXNzPSJlbmRyVGV4dENvbnRlbnRDb250YWluZXIiIHN0eWxlPSJtaW4td2lkdGg6MTAwJTtib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7IiBiZ2NvbG9yPSIjMmEzMjNhIj4NCgkJCQkJCQkJCQkJPHRib2R5Pg0KCQkJCQkJCQkJCQk8dHI-DQogICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgDQoJCQkJCQkJCQkJCQ0KICAgICAgICAgICAgICAgICAgICAgICAgCQkJCQk8L3RyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3Rib2R5Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L3RhYmxlPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90Ym9keT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC90YWJsZT4NCgkJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCgkJCQkJPCEtLSBCTE9DSyBGb290ZXIgQWJvdXQgVXMgLS0-DQoJCQkJCTwvdGQ-DQoJCQkJCTwvdHI-DQoJCQkJCTwvdGJvZHk-PC90YWJsZT4NCgkJCQkJDQoJCQkJCTx0YWJsZSBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgY2xhc3M9InRlbXBsYXRlQ29udGFpbmVyIiBzdHlsZT0id2lkdGg6MTAwJTttYXgtd2lkdGg6NjAwcHg7Ym9yZGVyLWNvbGxhcHNlOmNvbGxhcHNlOyI-DQoJCQkJCTx0Ym9keT48dHI-DQoJCQkJCTx0ZD4NCgkJCQkNCgkJCQkJPC90ZD4NCgkJCQkJPC90cj4NCgkJCQkJPC90Ym9keT48L3RhYmxlPg0KCQkJCQk8IS0tW2lmIChndGUgbXNvIDkpfChJRSldPg0KCQkJCTwvdGQ-DQoJCQkJPC90cj4NCgkJCTwvdGFibGU-DQoJCQk8IVtlbmRpZl0tLT4NCgkJCTwhLS0gLy8gRU5EIFRFTVBMQVRFIC0tPg0KCQkJPC90ZD4NCgkJPC90cj4NCgkJPC90Ym9keT48L3RhYmxlPiAgICANCg0KPC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2Rpdj48L2NlbnRlcj48aW1nIHNyYz0iaHR0cHM6Ly9zZWxsZXJjZW50cmFsLmFtYXpvbi5pbi9ubXMvaW1nL2Y2YmQyYmYxLWZiYzYtMzg4Yi1iYzU2LTdhYjQ4OTBhMWU1MT9zaz13YUh4S0t6ZnpqX2hFNndOdHE5WWxzX2xpMndJZWd6QWVqUnNMWFM4LXFqSmZOS3dxcVpuZUhXX0poc25vWWJ5Z3NDNVMwanRQVlBTTFZYa2F6QUdBZyZhbXA7bj0xIj4NCjxkaXYgaWQ9InNwYy13YXRlcm1hcmsiPg0KICA8cCBzdHlsZT0iZm9udC1zaXplOiAxMHB4ICFpbXBvcnRhbnQ7cGFkZGluZy1ib3R0b206IDEwcHggIWltcG9ydGFudDtkaXNwbGF5OiB0YWJsZSAhaW1wb3J0YW50O21hcmdpbjogNXB4IGF1dG8gMTBweCAhaW1wb3J0YW50O3RleHQtYWxpZ246IGNlbnRlciAhaW1wb3J0YW50O2NvbG9yOiAjYTJhMmEyICFpbXBvcnRhbnQ7Zm9udC1mYW1pbHk6ICdBbWF6b24gRW1iZXInICFpbXBvcnRhbnQ7Zm9udC13ZWlnaHQ6IDQwMCAhaW1wb3J0YW50OyI-U1BDLUVVQW1hem9uLTIxNjM4NDA0OTY1NDI4MjQ8L3A-DQo8L2Rpdj48L2JvZHk-PC9odG1sPg=="}}]},"sizeEstimate":37176,"historyId":"2853450","internalDate":"1768064702000"}', '2026-01-11T04:56:57.666Z', '19ba8de5838f2b27', '19b9c2f156ccf4e7', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0),
  ('375f15ce23d7f3960950c1af148b737c', '101f04af63cbefc2bf8f0a98b9ae1205', 'Alibaba <noreply@service.alibaba.com>', 'Track Your Shipments in Real-Time!', '<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"><head><meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1"/><style>@font-face{font-family:''Inter'';font-style:normal;font-weight:400;mso-font-alt:''Helvetica'';src:url(https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.woff2) format(''woff2'')}*{font-family:''Inter'',Helvetica}</style><style>@font-face{font-family:''Inter'';font-style:normal;font-weight:600;mso-font-alt:''Helvetica'';src:url(https://fonts.gstatic.com/s/inter/v18/UcC73FwrK3iLTeHuS_fjbvMwCp50PDca1ZL7.woff2) format(''woff2'')}*{font-family:''Inter'',Helvetica}</style><style>@font-face{font-family:''Inter'';font-style:normal;font-weight:700;mso-font-alt:''Helvetica'';src:url(https://fonts.gstatic.com/s/inter/v18/UcC73FwrK3iLTeHuS_fjbvMwCp50BTca1ZL7.woff2) format(''woff2'')}*{font-family:''Inter'',Helvetica}</style><style>@media only screen and (min-width:480px){.pc-width-350{width:350px !important}.pc-height-128{height:128px !important}.pc-width-420{width:420px !important}.pc-column-per-33{width:33.33% !important}.pc-padding-8{padding:8px !important}.pc-padding-12{padding:12px !important}.pc-padding-16{padding:16px !important}.pc-padding-20{padding:20px !important}.pc-padding-24{padding:24px !important}.pc-padding-top-8{padding-top:8px !important}.pc-padding-top-12{padding-top:12px !important}.pc-padding-top-16{padding-top:16px !important}.pc-padding-top-20{padding-top:20px !important}.pc-padding-top-24{padding-top:24px !important}.pc-padding-bottom-8{padding-bottom:8px !important}.pc-padding-bottom-12{padding-bottom:12px !important}.pc-padding-bottom-16{padding-bottom:16px !important}.pc-padding-bottom-20{padding-bottom:20px !important}.pc-padding-bottom-24{padding-bottom:24px !important}.pc-padding-left-8{padding-left:8px !important}.pc-padding-left-12{padding-left:12px !important}.pc-padding-left-16{padding-left:16px !important}.pc-padding-left-20{padding-left:20px !important}.pc-padding-left-24{padding-left:24px !important}.pc-padding-right-8{padding-right:8px !important}.pc-padding-right-12{padding-right:12px !important}.pc-padding-right-16{padding-right:16px !important}.pc-padding-right-20{padding-right:20px !important}.pc-padding-right-24{padding-right:24px !important}.pc-font-16{font-size:16px !important}.pc-font-18{font-size:18px !important}.pc-font-20{font-size:20px !important}.pc-font-22{font-size:22px !important}.pc-font-24{font-size:24px !important}}</style></head><body style="word-spacing:normal;background-color:#fff;margin: 0;padding: 0;"><table align="center" cellpadding="0" cellspacing="0" width="100%" style="width: 100%;background-color:#ffffff;max-width:640px;margin:0 auto;"><tbody><tr><td><p style="text-align:right;background-color:#f2f3f7;font-size:0px;line-height:0px;color:#f2f3f7;"> Choose Alibaba.com Logistics for your shipping needs </p><table cellpadding="0" cellspacing="0" data-border="0" width="100%" style="font-size: 0; line-height: 0;"><tbody><tr><td><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td style="text-align: center;"><div><div style="line-height: 0;"> ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ </div></div></td></tr></tbody></table></td></tr></tbody></table><table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="max-width:640px;width:100%;margin:0 auto;background:#fff"><tbody><tr style="width:100%"><td><a href="https://www.alibaba.com?tracelog=edm-header&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="display:block;text-align:center;padding:20px 0"><img style="width:150px;height:auto" src="https://img.alicdn.com/imgextra/i3/O1CN01ME39hS1XK5A4Ka5VE_!!6000000002904-2-tps-1140-144.png" alt="" border="0px"/></a></td></tr></tbody></table><table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="max-width:640px;width:100%;margin:0 auto"><tbody><tr style="width:100%"><td><table width="100%" cellpadding="0" cellspacing="0" border="0"><tbody><tr><td style="display:none"></td></tr><tr><td><a href="https://logistics.alibaba.com/buyer/luyou/public/blg/home.htm?wx_navbar_transparent=true&from=edm&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com"><img src="https://img.alicdn.com/imgextra/i4/O1CN01v032cT1EbxuczDW71_!!6000000000371-1-tps-412-483.gif" alt="Banner" style="width:100%;height:auto;display:block" border="0px"/></a></td></tr></tbody></table></td></tr></tbody></table><table align="center" width="100%" class="pc-padding-left-12 pc-padding-right-12" border="0" cellpadding="0" cellspacing="0" role="presentation" style="max-width:640px;width:100%;margin:0 auto;padding:0 8px"><tbody><tr style="width:100%"><td><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0"><tbody><tr><td class="pc-padding-top-24 pc-padding-bottom-24 pc-padding-left-6 pc-padding-right-6" style="width:100%;padding:14px 2px;text-align:left"><h2 class="pc-font-24" style="font-size:20px;font-weight:600;color:#222222;margin:0"> Items for your business</h2></td></tr><tr><td style="width:100%"><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/HK-MX801-Wholesale-Stock-Electric-Wireless_1601395967799.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H8aa80d87ffac48e68fdf7ac6310abfdaO.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> HK-MX801 Wholesale... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$1.02</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">9 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/YLR-JW-607B-Bottom-Load-Hot_60735902474.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/Hc602b370fe7c493ba8f0eb59b3742dd6R.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> YLR-JW-607B Bottom... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$81.5</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">35 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Bbq-Furniture-Green-Egg-Modular-Outdoor_1600987336798.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/Hb7c6c4e222b74b2dbe2d5fa62412de82A.png_220x220.png" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Bbq Furniture Gre... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$381.0</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">40 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Hot-Selling-5-Gallon-Bottom-Load_1600923693327.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/Hc7e452c97d544c90a0742575b99b5ba1K.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Hot Selling 5 Gall... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$2.2</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">7 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Hot-Selling-Cheap-Price-Plastic-Automatic_1600250431431.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H4f6635eee5324dbfbc41dc9c275d282e7.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Hot Selling Cheap ... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$2.6</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">15 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/High-Quality-Electric-USB-Charging-Automatic_1600080840221.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H4164a62cb85d4959b646e60519cca9073.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> High Quality Elect... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$2.95</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">15 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Mini-Portable-Plastic-Hand-Press-Large_1601422701670.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H8a4133a7b8e04dfa92fc2b113215c634F.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Mini Portable Plas... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$0.52</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">7 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/MORE-DESIGN-Low-Price-Lifting-Rotating_1601116484099.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H01d4b78455c74b8096d2744af4ad016dp.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> MORE DESIGN Low Pr... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$28.0</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">14 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Hot-Sale-15-20-Stage-Chrome_1600603201785.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/Hf0c69fd0172d4d778947764032f04122a.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Hot Sale 15 20 Sta... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$3.6</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">7 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Wholesale-Low-Noise-5-Gallon-USB_1601456240673.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H732cb91c393347aeb68064e1e4bf20b7d.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Wholesale Low Nois... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$1.3</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">31 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/2024-Portable-Rechargeable-1200mA-USB-Home_1601568616459.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H2acbe59636e4429686eb6ca3076556a80.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> 2024 Portable Rech... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$1.45</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">6 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span><span style="display:none"></span><table width="100%" cellpadding="0" cellspacing="0" border="0" class="pc-padding-left-8 pc-padding-right-8 pc-column-per-33" style="display:inline-block;vertical-align:top;width:50%;box-sizing:border-box;padding-right:2px;padding-left:2px"><tbody><tr><td><a href="https://www.alibaba.com/product-detail/Hot-Sale-Free-Sample-Cheap-Small_1601069978331.html?fromPlat=buyer_ops&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#067df7;text-decoration-line:none;text-decoration:none;display:block" target="_blank"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;border-radius:8px;overflow:hidden"><tbody><tr><td><img src="https://sc04.alicdn.com/kf/H8dcd5969d8e74b0a9015af7a66188b7ay.jpg_220x220.jpg" style="display:block;outline:none;border:none;text-decoration:none;width:100%;height:auto;border-radius:4px" width="100%" border="0px"/></td></tr><tr><td style="padding:8px 0px" class="pc-padding-bottom-12 pc-padding-top-12"><span style="display:none"></span><span class="pc-font-16 pc-padding-bottom-8" style="font-size:14px;line-height:22px;font-weight:400;color:#222222;display:block"><span style="display:none"></span><span style="display:none"></span><span style="display:inline"> Hot Sale Free Samp... </span><span style="display:none"></span></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-18 pc-padding-bottom-8" style="font-size:14px;font-weight:600;line-height:22px;color:#222;display:block">$0.8</span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span style="display:none"></span><span class="pc-font-14 pc-padding-bottom-8" style="font-size:13px;line-height:20px;font-weight:400;color:#222;display:block;line-break:anywhere">3 Days Lead Time</span><span style="display:none"></span><span style="display:none"></span></td></tr></tbody></table></a></td></tr></tbody></table><span style="display:none"></span></td></tr></tbody></table></td></tr></tbody></table><table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="max-width:640px;width:100%;margin:0 auto"><tbody><tr style="width:100%"><td><table align="center" cellpadding="0" cellspacing="0" width="100%" style="width:100%"><tbody><tr><td><div><table cellpadding="0" cellspacing="0" border="0" style="width:100%"><tbody><tr><td class="pc-padding-24" style="padding:12px 6px"><table cellpadding="0" cellspacing="0" border="0" align="left"><tbody><tr><td class="pc-font-24" style="font-size:20px;line-height:24px"><div style="font-weight:bold"> Trending categories </div></td></tr></tbody></table></td></tr></tbody></table><div><div style="margin:0px auto;max-width:616px"><table cellpadding="0" cellspacing="0" width="100%" style="font-size:0vw;line-height:0"><tbody><tr><td><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?spm=a2700.galleryofferlist.the-new-header_fy23_pc_search_bar.keydown__Enter&tab=all&SearchText=electronics&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Consumer Electronics" src="https://img.alicdn.com/imgextra/i3/O1CN01eRA2Ue1xlixDKWgNo_!!6000000006484-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Consumer Electronics </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?spm=a2700.galleryofferlist.the-new-header_fy23_pc_search_bar.keydown__Enter&tab=all&SearchText=apparel&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Apparel" src="https://img.alicdn.com/imgextra/i2/O1CN012BU46I1ky0ZTVKngI_!!6000000004751-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Apparel </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&keywords=vehicle+parts&originKeywords=vehicle+parts&tab=all&viewtype=L&spm=a2700.galleryofferlist.viewtype.L&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Vehicles & Accessories" src="https://img.alicdn.com/imgextra/i1/O1CN01mdJTXV24jcRTVQqrl_!!6000000007427-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Vehicles & Accessories </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?spm=a2700.galleryofferlist.the-new-header_fy23_pc_search_bar.keydown__Enter&tab=all&SearchText=sports&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Sports & Entertainment" src="https://img.alicdn.com/imgextra/i3/O1CN01WtZswq1DXYNKUv4lt_!!6000000000226-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Sports & Entertainment </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?spm=a2700.galleryofferlist.the-new-header_fy23_pc_search_bar.searchButton&tab=all&SearchText=Industrial+Machinery&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Industrial Machinery" src="https://img.alicdn.com/imgextra/i4/O1CN01DtL04H1Uek3fo26kX_!!6000000002543-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Industrial Machinery </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&keywords=home+%26+garden&originKeywords=home+%26+garden&tab=all&&page=1&spm=a2700.galleryofferlist.pagination.0&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Home & Garden" src="https://img.alicdn.com/imgextra/i2/O1CN01FFwPf823qeum6hoaE_!!6000000007307-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Home & Garden </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?spm=a2700.galleryofferlist.the-new-header_fy23_pc_search_bar.keydown__Enter&tab=all&SearchText=beauty&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="Beauty" src="https://img.alicdn.com/imgextra/i4/O1CN01qOSuNW26a7SYbrtyb_!!6000000007677-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> Beauty </p></a></td></tr></tbody></table></div><div style="text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:25%"><table cellpadding="0" cellspacing="0" border="0" align="left" width="100%"><tbody><tr><td class="pc-padding-12" style="padding:4px"><a href="https://www.alibaba.com/trade/search?spm=a2700.galleryofferlist.the-new-header_fy23_pc_search_bar.keydown__Enter&tab=all&SearchText=2025+new&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="text-decoration:none"><img alt="All categories" src="https://img.alicdn.com/imgextra/i1/O1CN01sLnvTl2187AAhBHOp_!!6000000006939-2-tps-176-176.png" style="display:block;outline:none;border:none;text-decoration:none;border-radius:8px;width:100%;letter-spacing:0px" border="0px"/><p style="color:rgb(118, 118, 118);font-size:13px;font-family:undefined;line-height:16px;font-weight:400;text-align:center;padding:0px;margin:12px 0px 0px;vertical-align:middle;text-decoration:none;overflow-wrap:normal;word-break:keep-all"> All categories </p></a></td></tr></tbody></table></div></td></tr></tbody></table></div></div></div></td></tr></tbody></table></td></tr></tbody></table><table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="max-width:640px;width:100%;margin:0 auto;background:#F4F4F4;margin-top:12px"><tbody><tr style="width:100%"><td><table width="100%" cellpadding="0" cellspacing="0" border="0"><tbody><tr><td class="pc-padding-left-24 pc-padding-right-24" style="padding:40px 12px"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tbody><tr><td style="text-align:center;padding-bottom:28px"><span style="color:#767676;font-size:11px;font-weight:400;line-height:16px;letter-spacing:0.1px;display:block;max-width:574px;margin:0 auto"><span style="display:none"></span><div> If you no longer wish to receive this kind of emails, <br/>you may change your preferences by clicking the link below. </div><span style="display:none"></span><span style="display:none"></span></span></td></tr><tr><td style="text-align:center;padding-bottom:28px"><span style="display:none"></span><span style="display:none"></span><table cellpadding="0" cellspacing="0" border="0" style="margin:0 auto"><tbody><tr><td class="pc-padding-right-20" style="padding-right:8px"><a href="https://rulechannel.alibaba.com/icbu?type=detail&ruleId=2034&cId=1306&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com#/rule/detail?cId=1306&ruleId=2034" style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px;line-break:anywhere">Privacy Policy</a></td><td class="pc-padding-right-20" style="padding-right:8px"><span style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px">|</span></td><td class="pc-padding-right-20" style="padding-right:8px"><a href="https://rulechannel.alibaba.com/icbu?type=detail&ruleId=2041&cId=1307&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com#/rule/detail?cId=1307&ruleId=2041" style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px;line-break:anywhere">Terms of Use</a></td><td class="pc-padding-right-20" style="padding-right:8px"><span style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px">|</span></td><td class="pc-padding-right-20" style="padding-right:8px"><a href="https://air.alibaba.com/app/sc-assets/edm_unsubscribe/pages.html?url_type=footer_unsub&tracelog=unsub_con&$unsubscriptionEncryptTool.unsubscriptionEncrypt&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px;line-break:anywhere">Email Preferences</a></td><td class="pc-padding-right-20" style="padding-right:8px"><span style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px">|</span></td><td><a href="https://air.alibaba.com/app/sc-assets/edm_unsubscribe/pages.html?url_type=footer_unsub&tracelog=unsub_con&$unsubscriptionEncryptTool.unsubscriptionEncrypt&mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com" style="color:#222222;font-size:10px;font-weight:400;line-height:normal;letter-spacing:-0.1px;line-break:anywhere">Unsubscribe</a></td></tr></tbody></table></td></tr><tr><td style="text-align:center;padding-bottom:28px"><span style="color:#767676;font-size:11px;font-weight:400;line-height:16px;letter-spacing:0.1px;display:block;max-width:592px;margin:0 auto"><span style="display:none"></span><div> If you cannot unsubscribe from the mailing list or have concerns about your personal data, please email DataProtection​@service.​alibaba​.com </div><span style="display:none"></span><span style="display:none"></span></span></td></tr><tr><td style="text-align:center"><span style="color:#767676;font-size:11px;font-weight:400;line-height:16px;letter-spacing:0.1px;display:block">Alibaba.com Singapore E-commerce Private Limited, 51 Bras Basah Road, #04-08 Lazada One, Singapore 189554</span></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><input type="text" value="https://usmy.alibaba.com/user/emailservice/unsubscribe_entry.htm?url_type=footer_unsub&tracelog=unsub_con&_000_e_a_=Pn6VoSAJkI4i5KteD4rcseet9dJZYBbkA6wBwC2jpQk%3D&_000_e_t_=RHQ-wDx*kaNEmvIl-lHGpJXEvhA05MY*7OGsBUof*cE%3D" style="width:0;height:0"/><img style="display:none; visibility:hidden; color:#fff;" width="0" height="0" src="https://alicrm.alibaba.com/outer/email/setReadStatus.html?mt=mail&crm_mtn_tracelog_log_id=113965086464&s_id=push-task_110675&t_id=2000114762&c_id=41171&as_token=qbxS0QcZ39W5KMfgJKtyjg35MvwwJLAvKf9iDTdd3sIs7dvf&to=kothariqutub%40gmail.com&from=noreply%40service.alibaba.com"/><img style="display:none; visibility:hidden; color:#fff;" width="0" height="0" src="http://stat.alibaba.com/mail_callback.html?crm_mtn_tracelog_log_id=113965086464&crm_mtn_tracelog_task_id=push-task_110675"/><img style="display:none; visibility:hidden; color:#fff;" width="0" height="0" src="http://gm.mmstat.com/btob.10?crm_mtn_tracelog_log_id=113965086464&crm_mtn_tracelog_task_id=push-task_110675&from=noreply@service.alibaba.com&to=kothariqutub@gmail.com&from_sys=null&biz_type=null&template=null"/></body></html>', '2026-01-10T15:25:37.000Z', '{"id":"19ba883630fc079b","threadId":"19ba883630fc079b","labelIds":["UNREAD","CATEGORY_PERSONAL","INBOX"],"snippet":"Choose Alibaba.com Logistics for your shipping needs ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌","payload":{"partId":"","mimeType":"multipart/mixed","filename":"","headers":[{"name":"Delivered-To","value":"kothariqutub@gmail.com"},{"name":"Received","value":"by 2002:a05:6a11:9182:b0:695:903d:b965 with SMTP id lb2csp2311869pxc;        Sat, 10 Jan 2026 07:25:41 -0800 (PST)"},{"name":"X-Google-Smtp-Source","value":"AGHT+IFfOosnyd3tKi6sOAdj+iNeYud4ptZHZJXYR104bts6NTVEMpwx2jm/rh4lwqFyxk9Wg4f0"},{"name":"X-Received","value":"by 2002:a17:903:94b:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-2a3ee43853emr138779855ad.4.1768058741718;        Sat, 10 Jan 2026 07:25:41 -0800 (PST)"},{"name":"ARC-Seal","value":"i=1; a=rsa-sha256; t=1768058741; cv=none;        d=google.com; s=arc-20240605;        b=AHTJb+8decVDVENWzzHugl5dr3/uaznjYVH4W5LSsrqk8mFf8hW8h3pob2txRG5MuC         /gt9X5UfZfQfD3pr58VA1uzzhnljrQdu5krSeybALEeVuhl/zpXH3TyVtbqH4uH3Mioq         p+ifLM2uyFDXK8/KY5sdv9UXd+zGhseAGC1brKG/0L0VS86TFZmiklPXzaRAh6HcUntz         4IZRIS2p5K4msa1EIVrqvcAsiyIlwARxy1TW6+jv5/mRFVfdTAGaIyTxSsIKxpUJ8k5k         2xM+4eCa53OFlUS3kPeqTwo38rbs+TtH5DK80wEETvOPOHl3XZnSHVzlv0zM+jjg1x32         zOqg=="},{"name":"ARC-Message-Signature","value":"i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;        h=feedback-id:mime-version:subject:to:from:date:dkim-signature         :message-id;        bh=u3YlcAXx/6HKw4Y6cp5/qmIg7/X4zeKujglCGzVZmjc=;        fh=s9DHEgIuyncp28jzqCxwblOubGuXGt4s/Dr/B/byp5Q=;        b=GBltxQ31mbf/hp2GryY59kiLyomx91lq1hDXe5R0gtc/Lr5uA8l8B3eKEXkMf+cPQU         1vLZHbchbPZi3ZJ3yfdJTc7EpVNBwPC8Gr1OubpzI7BBw3xQx9zGvlnHWII/vKAGLclT         3vI7pnQGgDvtJiJvEutUrS3dgLMGVujfkbbzHN8QQgj4HQCYCuydCL9H5bEUwyl6qpNI         74Zu0JPC1n18mT5tBG9x9ruosO9QTYJnQwJrsRm+cJPofD5uBq3wsJJa/R4CFO+u1ZsO         AdRkPsq+wI3mgdtM0VdNDHAYwtKG06wobR08BOymw5bsbxxMQjWfiIOG57ovt+1ymIHK         qshQ==;        dara=google.com"},{"name":"ARC-Authentication-Results","value":"i=1; mx.google.com;       dkim=pass header.i=@service.alibaba.com header.s=aliyun-cn-hangzhou header.b=aCiGg+B5;       spf=pass (google.com: domain of noreply@service.alibaba.com designates 140.205.210.111 as permitted sender) smtp.mailfrom=noreply@service.alibaba.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=service.alibaba.com"},{"name":"Return-Path","value":"<noreply@service.alibaba.com>"},{"name":"Received","value":"from out210-111.dm.aliyun.com (out210-111.dm.aliyun.com. [140.205.210.111])        by mx.google.com with ESMTPS id d9443c01a7336-2a3e3cb50desi200039435ad.126.2026.01.10.07.25.40        for <kothariqutub@gmail.com>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Sat, 10 Jan 2026 07:25:41 -0800 (PST)"},{"name":"Received-SPF","value":"pass (google.com: domain of noreply@service.alibaba.com designates 140.205.210.111 as permitted sender) client-ip=140.205.210.111;"},{"name":"Authentication-Results","value":"mx.google.com;       dkim=pass header.i=@service.alibaba.com header.s=aliyun-cn-hangzhou header.b=aCiGg+B5;       spf=pass (google.com: domain of noreply@service.alibaba.com designates 140.205.210.111 as permitted sender) smtp.mailfrom=noreply@service.alibaba.com;       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=service.alibaba.com"},{"name":"Message-ID","value":"<69626f75.170a0220.8bbd6.f655SMTPIN_ADDED_BROKEN@mx.google.com>"},{"name":"X-Google-Original-Message-ID","value":"ce34edf1-4087-4eb4-8019-3c2c84225109-0"},{"name":"X-AliDM-RcptTo","value":"a290aGFyaXF1dHViQGdtYWlsLmNvbQ=="},{"name":"DKIM-Signature","value":"v=1; a=rsa-sha256; c=relaxed/relaxed; d=service.alibaba.com; s=aliyun-cn-hangzhou; t=1768058738; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; bh=u3YlcAXx/6HKw4Y6cp5/qmIg7/X4zeKujglCGzVZmjc=; b=aCiGg+B54fljtdxrYfJ5g6yQWthLOgQwKSp+f0woNn1k75w04vJIH8Bc9G3DWSL3KNzaIFFHTEAeR5IONlznkKOFXyFV2QbPKJK6/OPVfWo8AileTOaw++JNhXSN0VERoES0T6wjxTPVKfIDGuw8848WcT1pV1TRNctJjRNEe2A="},{"name":"Received","value":"from mobile-messages-service033103082230.center.na620(mailfrom:noreply@service.alibaba.com fp:SMTPD_-VHcEz4N5HT cluster:AY35D)          by smtp.aliyun-inc.com(127.0.0.1);          Sat, 10 Jan 2026 23:25:38 +0800"},{"name":"X-EnvId","value":"600000264495461643"},{"name":"Date","value":"Sat, 10 Jan 2026 07:25:37 -0800 (PST)"},{"name":"From","value":"Alibaba <noreply@service.alibaba.com>"},{"name":"To","value":"kothariqutub@gmail.com"},{"name":"Subject","value":"Track Your Shipments in Real-Time!"},{"name":"MIME-Version","value":"1.0"},{"name":"Content-Type","value":"multipart/mixed; boundary=\"----=_Part_972160_1599858059.1768058737739\""},{"name":"Feedback-ID","value":"41171:kothariqutub@gmail.com:push-task_110675:icbu_edm"},{"name":"X-AliDM-Settings","value":"eyJWZXJzaW9uIjoiMS4wIiwiVW5zdWJzY3JpYmUiOnsiRmlsdGVyTGV2ZWwiOiJtYWlsZnJvbV9kb21haW4iLCJMaW5rVHlwZSI6ImRpc2FibGVkIn0sIk91dGJvdW5kSXAiOnsiSXBQb29sSWQiOiJiOWFkNzdlOS1hMTY5LTQ0MDktYTUwZS1jNDM0OTgxOGY1NDEifX0="}],"body":{"size":0},"parts":[{"partId":"0","mimeType":"text/html","filename":"","headers":[{"name":"Content-Type","value":"text/html; charset=UTF-8"},{"name":"Content-Transfer-Encoding","value":"quoted-printable"}],"body":{"size":51168,"data":"PCFET0NUWVBFIGh0bWw-PGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHhtbG5zOnY9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206dm1sIiB4bWxuczpvPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTpvZmZpY2UiPjxoZWFkPjxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSIvPjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ii8-PG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIi8-PHN0eWxlPkBmb250LWZhY2V7Zm9udC1mYW1pbHk6J0ludGVyJztmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDo0MDA7bXNvLWZvbnQtYWx0OidIZWx2ZXRpY2EnO3NyYzp1cmwoaHR0cHM6Ly9mb250cy5nc3RhdGljLmNvbS9zL2ludGVyL3YxOC9VY0NPM0Z3ckszaUxUZUh1U19uVk1yTXhDcDUwU2pJdzJib0tvZHVLbU1FVnVMeWZBWjloaUEud29mZjIpIGZvcm1hdCgnd29mZjInKX0qe2ZvbnQtZmFtaWx5OidJbnRlcicsSGVsdmV0aWNhfTwvc3R5bGU-PHN0eWxlPkBmb250LWZhY2V7Zm9udC1mYW1pbHk6J0ludGVyJztmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDo2MDA7bXNvLWZvbnQtYWx0OidIZWx2ZXRpY2EnO3NyYzp1cmwoaHR0cHM6Ly9mb250cy5nc3RhdGljLmNvbS9zL2ludGVyL3YxOC9VY0M3M0Z3ckszaUxUZUh1U19mamJ2TXdDcDUwUERjYTFaTDcud29mZjIpIGZvcm1hdCgnd29mZjInKX0qe2ZvbnQtZmFtaWx5OidJbnRlcicsSGVsdmV0aWNhfTwvc3R5bGU-PHN0eWxlPkBmb250LWZhY2V7Zm9udC1mYW1pbHk6J0ludGVyJztmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDo3MDA7bXNvLWZvbnQtYWx0OidIZWx2ZXRpY2EnO3NyYzp1cmwoaHR0cHM6Ly9mb250cy5nc3RhdGljLmNvbS9zL2ludGVyL3YxOC9VY0M3M0Z3ckszaUxUZUh1U19mamJ2TXdDcDUwQlRjYTFaTDcud29mZjIpIGZvcm1hdCgnd29mZjInKX0qe2ZvbnQtZmFtaWx5OidJbnRlcicsSGVsdmV0aWNhfTwvc3R5bGU-PHN0eWxlPkBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDo0ODBweCl7LnBjLXdpZHRoLTM1MHt3aWR0aDozNTBweCAhaW1wb3J0YW50fS5wYy1oZWlnaHQtMTI4e2hlaWdodDoxMjhweCAhaW1wb3J0YW50fS5wYy13aWR0aC00MjB7d2lkdGg6NDIwcHggIWltcG9ydGFudH0ucGMtY29sdW1uLXBlci0zM3t3aWR0aDozMy4zMyUgIWltcG9ydGFudH0ucGMtcGFkZGluZy04e3BhZGRpbmc6OHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctMTJ7cGFkZGluZzoxMnB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctMTZ7cGFkZGluZzoxNnB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctMjB7cGFkZGluZzoyMHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctMjR7cGFkZGluZzoyNHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctdG9wLTh7cGFkZGluZy10b3A6OHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctdG9wLTEye3BhZGRpbmctdG9wOjEycHggIWltcG9ydGFudH0ucGMtcGFkZGluZy10b3AtMTZ7cGFkZGluZy10b3A6MTZweCAhaW1wb3J0YW50fS5wYy1wYWRkaW5nLXRvcC0yMHtwYWRkaW5nLXRvcDoyMHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctdG9wLTI0e3BhZGRpbmctdG9wOjI0cHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1ib3R0b20tOHtwYWRkaW5nLWJvdHRvbTo4cHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1ib3R0b20tMTJ7cGFkZGluZy1ib3R0b206MTJweCAhaW1wb3J0YW50fS5wYy1wYWRkaW5nLWJvdHRvbS0xNntwYWRkaW5nLWJvdHRvbToxNnB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctYm90dG9tLTIwe3BhZGRpbmctYm90dG9tOjIwcHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1ib3R0b20tMjR7cGFkZGluZy1ib3R0b206MjRweCAhaW1wb3J0YW50fS5wYy1wYWRkaW5nLWxlZnQtOHtwYWRkaW5nLWxlZnQ6OHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctbGVmdC0xMntwYWRkaW5nLWxlZnQ6MTJweCAhaW1wb3J0YW50fS5wYy1wYWRkaW5nLWxlZnQtMTZ7cGFkZGluZy1sZWZ0OjE2cHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1sZWZ0LTIwe3BhZGRpbmctbGVmdDoyMHB4ICFpbXBvcnRhbnR9LnBjLXBhZGRpbmctbGVmdC0yNHtwYWRkaW5nLWxlZnQ6MjRweCAhaW1wb3J0YW50fS5wYy1wYWRkaW5nLXJpZ2h0LTh7cGFkZGluZy1yaWdodDo4cHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1yaWdodC0xMntwYWRkaW5nLXJpZ2h0OjEycHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1yaWdodC0xNntwYWRkaW5nLXJpZ2h0OjE2cHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1yaWdodC0yMHtwYWRkaW5nLXJpZ2h0OjIwcHggIWltcG9ydGFudH0ucGMtcGFkZGluZy1yaWdodC0yNHtwYWRkaW5nLXJpZ2h0OjI0cHggIWltcG9ydGFudH0ucGMtZm9udC0xNntmb250LXNpemU6MTZweCAhaW1wb3J0YW50fS5wYy1mb250LTE4e2ZvbnQtc2l6ZToxOHB4ICFpbXBvcnRhbnR9LnBjLWZvbnQtMjB7Zm9udC1zaXplOjIwcHggIWltcG9ydGFudH0ucGMtZm9udC0yMntmb250LXNpemU6MjJweCAhaW1wb3J0YW50fS5wYy1mb250LTI0e2ZvbnQtc2l6ZToyNHB4ICFpbXBvcnRhbnR9fTwvc3R5bGU-PC9oZWFkPjxib2R5IHN0eWxlPSJ3b3JkLXNwYWNpbmc6bm9ybWFsO2JhY2tncm91bmQtY29sb3I6I2ZmZjttYXJnaW46IDA7cGFkZGluZzogMDsiPjx0YWJsZSBhbGlnbj0iY2VudGVyIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHdpZHRoPSIxMDAlIiBzdHlsZT0id2lkdGg6IDEwMCU7YmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO21heC13aWR0aDo2NDBweDttYXJnaW46MCBhdXRvOyI-PHRib2R5Pjx0cj48dGQ-PHAgc3R5bGU9InRleHQtYWxpZ246cmlnaHQ7YmFja2dyb3VuZC1jb2xvcjojZjJmM2Y3O2ZvbnQtc2l6ZTowcHg7bGluZS1oZWlnaHQ6MHB4O2NvbG9yOiNmMmYzZjc7Ij4gQ2hvb3NlIEFsaWJhYmEuY29tIExvZ2lzdGljcyBmb3IgeW91ciBzaGlwcGluZyBuZWVkcyA8L3A-PHRhYmxlIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgZGF0YS1ib3JkZXI9IjAiIHdpZHRoPSIxMDAlIiBzdHlsZT0iZm9udC1zaXplOiAwOyBsaW5lLWhlaWdodDogMDsiPjx0Ym9keT48dHI-PHRkPjx0YWJsZSBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgYWxpZ249ImxlZnQiIHdpZHRoPSIxMDAlIj48dGJvZHk-PHRyPjx0ZCBzdHlsZT0idGV4dC1hbGlnbjogY2VudGVyOyI-PGRpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDogMDsiPiDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwg4oCMIOKAjCDigIwgPC9kaXY-PC9kaXY-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjx0YWJsZSBhbGlnbj0iY2VudGVyIiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHJvbGU9InByZXNlbnRhdGlvbiIgc3R5bGU9Im1heC13aWR0aDo2NDBweDt3aWR0aDoxMDAlO21hcmdpbjowIGF1dG87YmFja2dyb3VuZDojZmZmIj48dGJvZHk-PHRyIHN0eWxlPSJ3aWR0aDoxMDAlIj48dGQ-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20_dHJhY2Vsb2c9ZWRtLWhlYWRlciZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0iZGlzcGxheTpibG9jazt0ZXh0LWFsaWduOmNlbnRlcjtwYWRkaW5nOjIwcHggMCI-PGltZyBzdHlsZT0id2lkdGg6MTUwcHg7aGVpZ2h0OmF1dG8iIHNyYz0iaHR0cHM6Ly9pbWcuYWxpY2RuLmNvbS9pbWdleHRyYS9pMy9PMUNOMDFNRTM5aFMxWEs1QTRLYTVWRV8hITYwMDAwMDAwMDI5MDQtMi10cHMtMTE0MC0xNDQucG5nIiBhbHQ9IiIgYm9yZGVyPSIwcHgiLz48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48dGFibGUgYWxpZ249ImNlbnRlciIgd2lkdGg9IjEwMCUiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiByb2xlPSJwcmVzZW50YXRpb24iIHN0eWxlPSJtYXgtd2lkdGg6NjQwcHg7d2lkdGg6MTAwJTttYXJnaW46MCBhdXRvIj48dGJvZHk-PHRyIHN0eWxlPSJ3aWR0aDoxMDAlIj48dGQ-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCI-PHRib2R5Pjx0cj48dGQgc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC90ZD48L3RyPjx0cj48dGQ-PGEgaHJlZj0iaHR0cHM6Ly9sb2dpc3RpY3MuYWxpYmFiYS5jb20vYnV5ZXIvbHV5b3UvcHVibGljL2JsZy9ob21lLmh0bT93eF9uYXZiYXJfdHJhbnNwYXJlbnQ9dHJ1ZSZmcm9tPWVkbSZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIj48aW1nIHNyYz0iaHR0cHM6Ly9pbWcuYWxpY2RuLmNvbS9pbWdleHRyYS9pNC9PMUNOMDF2MDMyY1QxRWJ4dWN6RFc3MV8hITYwMDAwMDAwMDAzNzEtMS10cHMtNDEyLTQ4My5naWYiIGFsdD0iQmFubmVyIiBzdHlsZT0id2lkdGg6MTAwJTtoZWlnaHQ6YXV0bztkaXNwbGF5OmJsb2NrIiBib3JkZXI9IjBweCIvPjwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PHRhYmxlIGFsaWduPSJjZW50ZXIiIHdpZHRoPSIxMDAlIiBjbGFzcz0icGMtcGFkZGluZy1sZWZ0LTEyIHBjLXBhZGRpbmctcmlnaHQtMTIiIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiByb2xlPSJwcmVzZW50YXRpb24iIHN0eWxlPSJtYXgtd2lkdGg6NjQwcHg7d2lkdGg6MTAwJTttYXJnaW46MCBhdXRvO3BhZGRpbmc6MCA4cHgiPjx0Ym9keT48dHIgc3R5bGU9IndpZHRoOjEwMCUiPjx0ZD48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCI-PHRib2R5Pjx0cj48dGQgY2xhc3M9InBjLXBhZGRpbmctdG9wLTI0IHBjLXBhZGRpbmctYm90dG9tLTI0IHBjLXBhZGRpbmctbGVmdC02IHBjLXBhZGRpbmctcmlnaHQtNiIgc3R5bGU9IndpZHRoOjEwMCU7cGFkZGluZzoxNHB4IDJweDt0ZXh0LWFsaWduOmxlZnQiPjxoMiBjbGFzcz0icGMtZm9udC0yNCIgc3R5bGU9ImZvbnQtc2l6ZToyMHB4O2ZvbnQtd2VpZ2h0OjYwMDtjb2xvcjojMjIyMjIyO21hcmdpbjowIj4gSXRlbXMgZm9yIHlvdXIgYnVzaW5lc3M8L2gyPjwvdGQ-PC90cj48dHI-PHRkIHN0eWxlPSJ3aWR0aDoxMDAlIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgY2xhc3M9InBjLXBhZGRpbmctbGVmdC04IHBjLXBhZGRpbmctcmlnaHQtOCBwYy1jb2x1bW4tcGVyLTMzIiBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjUwJTtib3gtc2l6aW5nOmJvcmRlci1ib3g7cGFkZGluZy1yaWdodDoycHg7cGFkZGluZy1sZWZ0OjJweCI-PHRib2R5Pjx0cj48dGQ-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vcHJvZHVjdC1kZXRhaWwvSEstTVg4MDEtV2hvbGVzYWxlLVN0b2NrLUVsZWN0cmljLVdpcmVsZXNzXzE2MDEzOTU5Njc3OTkuaHRtbD9mcm9tUGxhdD1idXllcl9vcHMmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSIgc3R5bGU9ImNvbG9yOiMwNjdkZjc7dGV4dC1kZWNvcmF0aW9uLWxpbmU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmJsb2NrIiB0YXJnZXQ9Il9ibGFuayI-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6I2ZmZmZmZjtib3JkZXItcmFkaXVzOjhweDtvdmVyZmxvdzpoaWRkZW4iPjx0Ym9keT48dHI-PHRkPjxpbWcgc3JjPSJodHRwczovL3NjMDQuYWxpY2RuLmNvbS9rZi9IOGFhODBkODdmZmFjNDhlNjhmZGY3YWM2MzEwYWJmZGFPLmpwZ18yMjB4MjIwLmpwZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO3dpZHRoOjEwMCU7aGVpZ2h0OmF1dG87Ym9yZGVyLXJhZGl1czo0cHgiIHdpZHRoPSIxMDAlIiBib3JkZXI9IjBweCIvPjwvdGQ-PC90cj48dHI-PHRkIHN0eWxlPSJwYWRkaW5nOjhweCAwcHgiIGNsYXNzPSJwYy1wYWRkaW5nLWJvdHRvbS0xMiBwYy1wYWRkaW5nLXRvcC0xMiI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE2IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtsaW5lLWhlaWdodDoyMnB4O2ZvbnQtd2VpZ2h0OjQwMDtjb2xvcjojMjIyMjIyO2Rpc3BsYXk6YmxvY2siPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6aW5saW5lIj4gSEstTVg4MDEgV2hvbGVzYWxlLi4uIDwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTggcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtd2VpZ2h0OjYwMDtsaW5lLWhlaWdodDoyMnB4O2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jayI-JDEuMDI8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTQgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjIwcHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jaztsaW5lLWJyZWFrOmFueXdoZXJlIj45IERheXMgTGVhZCBUaW1lPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGNsYXNzPSJwYy1wYWRkaW5nLWxlZnQtOCBwYy1wYWRkaW5nLXJpZ2h0LTggcGMtY29sdW1uLXBlci0zMyIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDo1MCU7Ym94LXNpemluZzpib3JkZXItYm94O3BhZGRpbmctcmlnaHQ6MnB4O3BhZGRpbmctbGVmdDoycHgiPjx0Ym9keT48dHI-PHRkPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3Byb2R1Y3QtZGV0YWlsL1lMUi1KVy02MDdCLUJvdHRvbS1Mb2FkLUhvdF82MDczNTkwMjQ3NC5odG1sP2Zyb21QbGF0PWJ1eWVyX29wcyZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0iY29sb3I6IzA2N2RmNzt0ZXh0LWRlY29yYXRpb24tbGluZTpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6YmxvY2siIHRhcmdldD0iX2JsYW5rIj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO2JvcmRlci1yYWRpdXM6OHB4O292ZXJmbG93OmhpZGRlbiI-PHRib2R5Pjx0cj48dGQ-PGltZyBzcmM9Imh0dHBzOi8vc2MwNC5hbGljZG4uY29tL2tmL0hjNjAyYjM3MGZlN2M0OTNiYThmMGViNTliMzc0MmRkNlIuanBnXzIyMHgyMjAuanBnIiBzdHlsZT0iZGlzcGxheTpibG9jaztvdXRsaW5lOm5vbmU7Ym9yZGVyOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7d2lkdGg6MTAwJTtoZWlnaHQ6YXV0bztib3JkZXItcmFkaXVzOjRweCIgd2lkdGg9IjEwMCUiIGJvcmRlcj0iMHB4Ii8-PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6OHB4IDBweCIgY2xhc3M9InBjLXBhZGRpbmctYm90dG9tLTEyIHBjLXBhZGRpbmctdG9wLTEyIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTYgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2xpbmUtaGVpZ2h0OjIycHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjIyMjI7ZGlzcGxheTpibG9jayI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTppbmxpbmUiPiBZTFItSlctNjA3QiBCb3R0b20uLi4gPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xOCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC13ZWlnaHQ6NjAwO2xpbmUtaGVpZ2h0OjIycHg7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrIj4kODEuNTwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MjBweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrO2xpbmUtYnJlYWs6YW55d2hlcmUiPjM1IERheXMgTGVhZCBUaW1lPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGNsYXNzPSJwYy1wYWRkaW5nLWxlZnQtOCBwYy1wYWRkaW5nLXJpZ2h0LTggcGMtY29sdW1uLXBlci0zMyIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDo1MCU7Ym94LXNpemluZzpib3JkZXItYm94O3BhZGRpbmctcmlnaHQ6MnB4O3BhZGRpbmctbGVmdDoycHgiPjx0Ym9keT48dHI-PHRkPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3Byb2R1Y3QtZGV0YWlsL0JicS1GdXJuaXR1cmUtR3JlZW4tRWdnLU1vZHVsYXItT3V0ZG9vcl8xNjAwOTg3MzM2Nzk4Lmh0bWw_ZnJvbVBsYXQ9YnV5ZXJfb3BzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJjb2xvcjojMDY3ZGY3O3RleHQtZGVjb3JhdGlvbi1saW5lOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpibG9jayIgdGFyZ2V0PSJfYmxhbmsiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiNmZmZmZmY7Ym9yZGVyLXJhZGl1czo4cHg7b3ZlcmZsb3c6aGlkZGVuIj48dGJvZHk-PHRyPjx0ZD48aW1nIHNyYz0iaHR0cHM6Ly9zYzA0LmFsaWNkbi5jb20va2YvSGI3YzZjNGUyMjJiNzRiMmRiZTJkNWZhNjI0MTJkZTgyQS5wbmdfMjIweDIyMC5wbmciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTt3aWR0aDoxMDAlO2hlaWdodDphdXRvO2JvcmRlci1yYWRpdXM6NHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwcHgiLz48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0icGFkZGluZzo4cHggMHB4IiBjbGFzcz0icGMtcGFkZGluZy1ib3R0b20tMTIgcGMtcGFkZGluZy10b3AtMTIiPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNiBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjJweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjIyMjtkaXNwbGF5OmJsb2NrIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5OmlubGluZSI-IEJicSBGdXJuaXR1cmUgR3JlLi4uIDwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTggcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtd2VpZ2h0OjYwMDtsaW5lLWhlaWdodDoyMnB4O2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jayI-JDM4MS4wPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE0IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTNweDtsaW5lLWhlaWdodDoyMHB4O2ZvbnQtd2VpZ2h0OjQwMDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2s7bGluZS1icmVhazphbnl3aGVyZSI-NDAgRGF5cyBMZWFkIFRpbWU8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgY2xhc3M9InBjLXBhZGRpbmctbGVmdC04IHBjLXBhZGRpbmctcmlnaHQtOCBwYy1jb2x1bW4tcGVyLTMzIiBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjUwJTtib3gtc2l6aW5nOmJvcmRlci1ib3g7cGFkZGluZy1yaWdodDoycHg7cGFkZGluZy1sZWZ0OjJweCI-PHRib2R5Pjx0cj48dGQ-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vcHJvZHVjdC1kZXRhaWwvSG90LVNlbGxpbmctNS1HYWxsb24tQm90dG9tLUxvYWRfMTYwMDkyMzY5MzMyNy5odG1sP2Zyb21QbGF0PWJ1eWVyX29wcyZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0iY29sb3I6IzA2N2RmNzt0ZXh0LWRlY29yYXRpb24tbGluZTpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6YmxvY2siIHRhcmdldD0iX2JsYW5rIj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO2JvcmRlci1yYWRpdXM6OHB4O292ZXJmbG93OmhpZGRlbiI-PHRib2R5Pjx0cj48dGQ-PGltZyBzcmM9Imh0dHBzOi8vc2MwNC5hbGljZG4uY29tL2tmL0hjN2U0NTJjOTdkNTQ0YzkwYTA3NDI1NzViOTliNWJhMUsuanBnXzIyMHgyMjAuanBnIiBzdHlsZT0iZGlzcGxheTpibG9jaztvdXRsaW5lOm5vbmU7Ym9yZGVyOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7d2lkdGg6MTAwJTtoZWlnaHQ6YXV0bztib3JkZXItcmFkaXVzOjRweCIgd2lkdGg9IjEwMCUiIGJvcmRlcj0iMHB4Ii8-PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6OHB4IDBweCIgY2xhc3M9InBjLXBhZGRpbmctYm90dG9tLTEyIHBjLXBhZGRpbmctdG9wLTEyIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTYgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2xpbmUtaGVpZ2h0OjIycHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjIyMjI7ZGlzcGxheTpibG9jayI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTppbmxpbmUiPiBIb3QgU2VsbGluZyA1IEdhbGwuLi4gPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xOCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC13ZWlnaHQ6NjAwO2xpbmUtaGVpZ2h0OjIycHg7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrIj4kMi4yPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE0IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTNweDtsaW5lLWhlaWdodDoyMHB4O2ZvbnQtd2VpZ2h0OjQwMDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2s7bGluZS1icmVhazphbnl3aGVyZSI-NyBEYXlzIExlYWQgVGltZTwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBjbGFzcz0icGMtcGFkZGluZy1sZWZ0LTggcGMtcGFkZGluZy1yaWdodC04IHBjLWNvbHVtbi1wZXItMzMiIHN0eWxlPSJkaXNwbGF5OmlubGluZS1ibG9jazt2ZXJ0aWNhbC1hbGlnbjp0b3A7d2lkdGg6NTAlO2JveC1zaXppbmc6Ym9yZGVyLWJveDtwYWRkaW5nLXJpZ2h0OjJweDtwYWRkaW5nLWxlZnQ6MnB4Ij48dGJvZHk-PHRyPjx0ZD48YSBocmVmPSJodHRwczovL3d3dy5hbGliYWJhLmNvbS9wcm9kdWN0LWRldGFpbC9Ib3QtU2VsbGluZy1DaGVhcC1QcmljZS1QbGFzdGljLUF1dG9tYXRpY18xNjAwMjUwNDMxNDMxLmh0bWw_ZnJvbVBsYXQ9YnV5ZXJfb3BzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJjb2xvcjojMDY3ZGY3O3RleHQtZGVjb3JhdGlvbi1saW5lOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpibG9jayIgdGFyZ2V0PSJfYmxhbmsiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiNmZmZmZmY7Ym9yZGVyLXJhZGl1czo4cHg7b3ZlcmZsb3c6aGlkZGVuIj48dGJvZHk-PHRyPjx0ZD48aW1nIHNyYz0iaHR0cHM6Ly9zYzA0LmFsaWNkbi5jb20va2YvSDRmNjYzNWVlZTUzMjRkYmZiYzQxZGM5YzI3NWQyODJlNy5qcGdfMjIweDIyMC5qcGciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTt3aWR0aDoxMDAlO2hlaWdodDphdXRvO2JvcmRlci1yYWRpdXM6NHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwcHgiLz48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0icGFkZGluZzo4cHggMHB4IiBjbGFzcz0icGMtcGFkZGluZy1ib3R0b20tMTIgcGMtcGFkZGluZy10b3AtMTIiPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNiBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjJweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjIyMjtkaXNwbGF5OmJsb2NrIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5OmlubGluZSI-IEhvdCBTZWxsaW5nIENoZWFwIC4uLiA8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE4IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LXdlaWdodDo2MDA7bGluZS1oZWlnaHQ6MjJweDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2siPiQyLjY8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTQgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjIwcHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jaztsaW5lLWJyZWFrOmFueXdoZXJlIj4xNSBEYXlzIExlYWQgVGltZTwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBjbGFzcz0icGMtcGFkZGluZy1sZWZ0LTggcGMtcGFkZGluZy1yaWdodC04IHBjLWNvbHVtbi1wZXItMzMiIHN0eWxlPSJkaXNwbGF5OmlubGluZS1ibG9jazt2ZXJ0aWNhbC1hbGlnbjp0b3A7d2lkdGg6NTAlO2JveC1zaXppbmc6Ym9yZGVyLWJveDtwYWRkaW5nLXJpZ2h0OjJweDtwYWRkaW5nLWxlZnQ6MnB4Ij48dGJvZHk-PHRyPjx0ZD48YSBocmVmPSJodHRwczovL3d3dy5hbGliYWJhLmNvbS9wcm9kdWN0LWRldGFpbC9IaWdoLVF1YWxpdHktRWxlY3RyaWMtVVNCLUNoYXJnaW5nLUF1dG9tYXRpY18xNjAwMDgwODQwMjIxLmh0bWw_ZnJvbVBsYXQ9YnV5ZXJfb3BzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJjb2xvcjojMDY3ZGY3O3RleHQtZGVjb3JhdGlvbi1saW5lOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpibG9jayIgdGFyZ2V0PSJfYmxhbmsiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiNmZmZmZmY7Ym9yZGVyLXJhZGl1czo4cHg7b3ZlcmZsb3c6aGlkZGVuIj48dGJvZHk-PHRyPjx0ZD48aW1nIHNyYz0iaHR0cHM6Ly9zYzA0LmFsaWNkbi5jb20va2YvSDQxNjRhNjJjYjg1ZDQ5NTliNjQ2ZTYwNTE5Y2NhOTA3My5qcGdfMjIweDIyMC5qcGciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTt3aWR0aDoxMDAlO2hlaWdodDphdXRvO2JvcmRlci1yYWRpdXM6NHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwcHgiLz48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0icGFkZGluZzo4cHggMHB4IiBjbGFzcz0icGMtcGFkZGluZy1ib3R0b20tMTIgcGMtcGFkZGluZy10b3AtMTIiPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNiBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjJweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjIyMjtkaXNwbGF5OmJsb2NrIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5OmlubGluZSI-IEhpZ2ggUXVhbGl0eSBFbGVjdC4uLiA8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE4IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LXdlaWdodDo2MDA7bGluZS1oZWlnaHQ6MjJweDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2siPiQyLjk1PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE0IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTNweDtsaW5lLWhlaWdodDoyMHB4O2ZvbnQtd2VpZ2h0OjQwMDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2s7bGluZS1icmVhazphbnl3aGVyZSI-MTUgRGF5cyBMZWFkIFRpbWU8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgY2xhc3M9InBjLXBhZGRpbmctbGVmdC04IHBjLXBhZGRpbmctcmlnaHQtOCBwYy1jb2x1bW4tcGVyLTMzIiBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjUwJTtib3gtc2l6aW5nOmJvcmRlci1ib3g7cGFkZGluZy1yaWdodDoycHg7cGFkZGluZy1sZWZ0OjJweCI-PHRib2R5Pjx0cj48dGQ-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vcHJvZHVjdC1kZXRhaWwvTWluaS1Qb3J0YWJsZS1QbGFzdGljLUhhbmQtUHJlc3MtTGFyZ2VfMTYwMTQyMjcwMTY3MC5odG1sP2Zyb21QbGF0PWJ1eWVyX29wcyZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0iY29sb3I6IzA2N2RmNzt0ZXh0LWRlY29yYXRpb24tbGluZTpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6YmxvY2siIHRhcmdldD0iX2JsYW5rIj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO2JvcmRlci1yYWRpdXM6OHB4O292ZXJmbG93OmhpZGRlbiI-PHRib2R5Pjx0cj48dGQ-PGltZyBzcmM9Imh0dHBzOi8vc2MwNC5hbGljZG4uY29tL2tmL0g4YTQxMzNhN2I4ZTA0ZGZhOTJmYzJiMTEzMjE1YzYzNEYuanBnXzIyMHgyMjAuanBnIiBzdHlsZT0iZGlzcGxheTpibG9jaztvdXRsaW5lOm5vbmU7Ym9yZGVyOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7d2lkdGg6MTAwJTtoZWlnaHQ6YXV0bztib3JkZXItcmFkaXVzOjRweCIgd2lkdGg9IjEwMCUiIGJvcmRlcj0iMHB4Ii8-PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6OHB4IDBweCIgY2xhc3M9InBjLXBhZGRpbmctYm90dG9tLTEyIHBjLXBhZGRpbmctdG9wLTEyIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTYgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2xpbmUtaGVpZ2h0OjIycHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjIyMjI7ZGlzcGxheTpibG9jayI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTppbmxpbmUiPiBNaW5pIFBvcnRhYmxlIFBsYXMuLi4gPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xOCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC13ZWlnaHQ6NjAwO2xpbmUtaGVpZ2h0OjIycHg7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrIj4kMC41Mjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MjBweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrO2xpbmUtYnJlYWs6YW55d2hlcmUiPjcgRGF5cyBMZWFkIFRpbWU8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgY2xhc3M9InBjLXBhZGRpbmctbGVmdC04IHBjLXBhZGRpbmctcmlnaHQtOCBwYy1jb2x1bW4tcGVyLTMzIiBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjUwJTtib3gtc2l6aW5nOmJvcmRlci1ib3g7cGFkZGluZy1yaWdodDoycHg7cGFkZGluZy1sZWZ0OjJweCI-PHRib2R5Pjx0cj48dGQ-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vcHJvZHVjdC1kZXRhaWwvTU9SRS1ERVNJR04tTG93LVByaWNlLUxpZnRpbmctUm90YXRpbmdfMTYwMTExNjQ4NDA5OS5odG1sP2Zyb21QbGF0PWJ1eWVyX29wcyZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0iY29sb3I6IzA2N2RmNzt0ZXh0LWRlY29yYXRpb24tbGluZTpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6YmxvY2siIHRhcmdldD0iX2JsYW5rIj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojZmZmZmZmO2JvcmRlci1yYWRpdXM6OHB4O292ZXJmbG93OmhpZGRlbiI-PHRib2R5Pjx0cj48dGQ-PGltZyBzcmM9Imh0dHBzOi8vc2MwNC5hbGljZG4uY29tL2tmL0gwMWQ0Yjc4NDU1Yzc0YjgwOTZkMjc0NGFmNGFkMDE2ZHAuanBnXzIyMHgyMjAuanBnIiBzdHlsZT0iZGlzcGxheTpibG9jaztvdXRsaW5lOm5vbmU7Ym9yZGVyOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7d2lkdGg6MTAwJTtoZWlnaHQ6YXV0bztib3JkZXItcmFkaXVzOjRweCIgd2lkdGg9IjEwMCUiIGJvcmRlcj0iMHB4Ii8-PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6OHB4IDBweCIgY2xhc3M9InBjLXBhZGRpbmctYm90dG9tLTEyIHBjLXBhZGRpbmctdG9wLTEyIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTYgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2xpbmUtaGVpZ2h0OjIycHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjIyMjI7ZGlzcGxheTpibG9jayI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTppbmxpbmUiPiBNT1JFIERFU0lHTiBMb3cgUHIuLi4gPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xOCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC13ZWlnaHQ6NjAwO2xpbmUtaGVpZ2h0OjIycHg7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrIj4kMjguMDwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MjBweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrO2xpbmUtYnJlYWs6YW55d2hlcmUiPjE0IERheXMgTGVhZCBUaW1lPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGNsYXNzPSJwYy1wYWRkaW5nLWxlZnQtOCBwYy1wYWRkaW5nLXJpZ2h0LTggcGMtY29sdW1uLXBlci0zMyIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDo1MCU7Ym94LXNpemluZzpib3JkZXItYm94O3BhZGRpbmctcmlnaHQ6MnB4O3BhZGRpbmctbGVmdDoycHgiPjx0Ym9keT48dHI-PHRkPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3Byb2R1Y3QtZGV0YWlsL0hvdC1TYWxlLTE1LTIwLVN0YWdlLUNocm9tZV8xNjAwNjAzMjAxNzg1Lmh0bWw_ZnJvbVBsYXQ9YnV5ZXJfb3BzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJjb2xvcjojMDY3ZGY3O3RleHQtZGVjb3JhdGlvbi1saW5lOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpibG9jayIgdGFyZ2V0PSJfYmxhbmsiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiNmZmZmZmY7Ym9yZGVyLXJhZGl1czo4cHg7b3ZlcmZsb3c6aGlkZGVuIj48dGJvZHk-PHRyPjx0ZD48aW1nIHNyYz0iaHR0cHM6Ly9zYzA0LmFsaWNkbi5jb20va2YvSGYwYzY5ZmQwMTcyZDRkNzc4OTQ3NzY0MDMyZjA0MTIyYS5qcGdfMjIweDIyMC5qcGciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTt3aWR0aDoxMDAlO2hlaWdodDphdXRvO2JvcmRlci1yYWRpdXM6NHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwcHgiLz48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0icGFkZGluZzo4cHggMHB4IiBjbGFzcz0icGMtcGFkZGluZy1ib3R0b20tMTIgcGMtcGFkZGluZy10b3AtMTIiPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNiBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjJweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjIyMjtkaXNwbGF5OmJsb2NrIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5OmlubGluZSI-IEhvdCBTYWxlIDE1IDIwIFN0YS4uLiA8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE4IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LXdlaWdodDo2MDA7bGluZS1oZWlnaHQ6MjJweDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2siPiQzLjY8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTQgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjIwcHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jaztsaW5lLWJyZWFrOmFueXdoZXJlIj43IERheXMgTGVhZCBUaW1lPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGNsYXNzPSJwYy1wYWRkaW5nLWxlZnQtOCBwYy1wYWRkaW5nLXJpZ2h0LTggcGMtY29sdW1uLXBlci0zMyIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDo1MCU7Ym94LXNpemluZzpib3JkZXItYm94O3BhZGRpbmctcmlnaHQ6MnB4O3BhZGRpbmctbGVmdDoycHgiPjx0Ym9keT48dHI-PHRkPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3Byb2R1Y3QtZGV0YWlsL1dob2xlc2FsZS1Mb3ctTm9pc2UtNS1HYWxsb24tVVNCXzE2MDE0NTYyNDA2NzMuaHRtbD9mcm9tUGxhdD1idXllcl9vcHMmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSIgc3R5bGU9ImNvbG9yOiMwNjdkZjc7dGV4dC1kZWNvcmF0aW9uLWxpbmU6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmJsb2NrIiB0YXJnZXQ9Il9ibGFuayI-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6I2ZmZmZmZjtib3JkZXItcmFkaXVzOjhweDtvdmVyZmxvdzpoaWRkZW4iPjx0Ym9keT48dHI-PHRkPjxpbWcgc3JjPSJodHRwczovL3NjMDQuYWxpY2RuLmNvbS9rZi9INzMyY2I5MWMzOTMzNDdhZWI2ODA2NGUxZTRiZjIwYjdkLmpwZ18yMjB4MjIwLmpwZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO3dpZHRoOjEwMCU7aGVpZ2h0OmF1dG87Ym9yZGVyLXJhZGl1czo0cHgiIHdpZHRoPSIxMDAlIiBib3JkZXI9IjBweCIvPjwvdGQ-PC90cj48dHI-PHRkIHN0eWxlPSJwYWRkaW5nOjhweCAwcHgiIGNsYXNzPSJwYy1wYWRkaW5nLWJvdHRvbS0xMiBwYy1wYWRkaW5nLXRvcC0xMiI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE2IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtsaW5lLWhlaWdodDoyMnB4O2ZvbnQtd2VpZ2h0OjQwMDtjb2xvcjojMjIyMjIyO2Rpc3BsYXk6YmxvY2siPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6aW5saW5lIj4gV2hvbGVzYWxlIExvdyBOb2lzLi4uIDwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTggcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtd2VpZ2h0OjYwMDtsaW5lLWhlaWdodDoyMnB4O2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jayI-JDEuMzwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNCBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjEzcHg7bGluZS1oZWlnaHQ6MjBweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjtkaXNwbGF5OmJsb2NrO2xpbmUtYnJlYWs6YW55d2hlcmUiPjMxIERheXMgTGVhZCBUaW1lPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGNsYXNzPSJwYy1wYWRkaW5nLWxlZnQtOCBwYy1wYWRkaW5nLXJpZ2h0LTggcGMtY29sdW1uLXBlci0zMyIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDo1MCU7Ym94LXNpemluZzpib3JkZXItYm94O3BhZGRpbmctcmlnaHQ6MnB4O3BhZGRpbmctbGVmdDoycHgiPjx0Ym9keT48dHI-PHRkPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3Byb2R1Y3QtZGV0YWlsLzIwMjQtUG9ydGFibGUtUmVjaGFyZ2VhYmxlLTEyMDBtQS1VU0ItSG9tZV8xNjAxNTY4NjE2NDU5Lmh0bWw_ZnJvbVBsYXQ9YnV5ZXJfb3BzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJjb2xvcjojMDY3ZGY3O3RleHQtZGVjb3JhdGlvbi1saW5lOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpibG9jayIgdGFyZ2V0PSJfYmxhbmsiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiNmZmZmZmY7Ym9yZGVyLXJhZGl1czo4cHg7b3ZlcmZsb3c6aGlkZGVuIj48dGJvZHk-PHRyPjx0ZD48aW1nIHNyYz0iaHR0cHM6Ly9zYzA0LmFsaWNkbi5jb20va2YvSDJhY2JlNTk2MzZlNDQyOTY4NmViNmNhMzA3NjU1NmE4MC5qcGdfMjIweDIyMC5qcGciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTt3aWR0aDoxMDAlO2hlaWdodDphdXRvO2JvcmRlci1yYWRpdXM6NHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwcHgiLz48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0icGFkZGluZzo4cHggMHB4IiBjbGFzcz0icGMtcGFkZGluZy1ib3R0b20tMTIgcGMtcGFkZGluZy10b3AtMTIiPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNiBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjJweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjIyMjtkaXNwbGF5OmJsb2NrIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5OmlubGluZSI-IDIwMjQgUG9ydGFibGUgUmVjaC4uLiA8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE4IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LXdlaWdodDo2MDA7bGluZS1oZWlnaHQ6MjJweDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2siPiQxLjQ1PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE0IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTNweDtsaW5lLWhlaWdodDoyMHB4O2ZvbnQtd2VpZ2h0OjQwMDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2s7bGluZS1icmVhazphbnl3aGVyZSI-NiBEYXlzIExlYWQgVGltZTwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48dGFibGUgd2lkdGg9IjEwMCUiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBjbGFzcz0icGMtcGFkZGluZy1sZWZ0LTggcGMtcGFkZGluZy1yaWdodC04IHBjLWNvbHVtbi1wZXItMzMiIHN0eWxlPSJkaXNwbGF5OmlubGluZS1ibG9jazt2ZXJ0aWNhbC1hbGlnbjp0b3A7d2lkdGg6NTAlO2JveC1zaXppbmc6Ym9yZGVyLWJveDtwYWRkaW5nLXJpZ2h0OjJweDtwYWRkaW5nLWxlZnQ6MnB4Ij48dGJvZHk-PHRyPjx0ZD48YSBocmVmPSJodHRwczovL3d3dy5hbGliYWJhLmNvbS9wcm9kdWN0LWRldGFpbC9Ib3QtU2FsZS1GcmVlLVNhbXBsZS1DaGVhcC1TbWFsbF8xNjAxMDY5OTc4MzMxLmh0bWw_ZnJvbVBsYXQ9YnV5ZXJfb3BzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJjb2xvcjojMDY3ZGY3O3RleHQtZGVjb3JhdGlvbi1saW5lOm5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpibG9jayIgdGFyZ2V0PSJfYmxhbmsiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiNmZmZmZmY7Ym9yZGVyLXJhZGl1czo4cHg7b3ZlcmZsb3c6aGlkZGVuIj48dGJvZHk-PHRyPjx0ZD48aW1nIHNyYz0iaHR0cHM6Ly9zYzA0LmFsaWNkbi5jb20va2YvSDhkY2Q1OTY5ZDhlNzRiMGE5MDE1YWY3YTY2MTg4YjdheS5qcGdfMjIweDIyMC5qcGciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTt3aWR0aDoxMDAlO2hlaWdodDphdXRvO2JvcmRlci1yYWRpdXM6NHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwcHgiLz48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0icGFkZGluZzo4cHggMHB4IiBjbGFzcz0icGMtcGFkZGluZy1ib3R0b20tMTIgcGMtcGFkZGluZy10b3AtMTIiPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBjbGFzcz0icGMtZm9udC0xNiBwYy1wYWRkaW5nLWJvdHRvbS04IiBzdHlsZT0iZm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjJweDtmb250LXdlaWdodDo0MDA7Y29sb3I6IzIyMjIyMjtkaXNwbGF5OmJsb2NrIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5OmlubGluZSI-IEhvdCBTYWxlIEZyZWUgU2FtcC4uLiA8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIGNsYXNzPSJwYy1mb250LTE4IHBjLXBhZGRpbmctYm90dG9tLTgiIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LXdlaWdodDo2MDA7bGluZS1oZWlnaHQ6MjJweDtjb2xvcjojMjIyO2Rpc3BsYXk6YmxvY2siPiQwLjg8L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gY2xhc3M9InBjLWZvbnQtMTQgcGMtcGFkZGluZy1ib3R0b20tOCIgc3R5bGU9ImZvbnQtc2l6ZToxM3B4O2xpbmUtaGVpZ2h0OjIwcHg7Zm9udC13ZWlnaHQ6NDAwO2NvbG9yOiMyMjI7ZGlzcGxheTpibG9jaztsaW5lLWJyZWFrOmFueXdoZXJlIj4zIERheXMgTGVhZCBUaW1lPC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjx0YWJsZSBhbGlnbj0iY2VudGVyIiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHJvbGU9InByZXNlbnRhdGlvbiIgc3R5bGU9Im1heC13aWR0aDo2NDBweDt3aWR0aDoxMDAlO21hcmdpbjowIGF1dG8iPjx0Ym9keT48dHIgc3R5bGU9IndpZHRoOjEwMCUiPjx0ZD48dGFibGUgYWxpZ249ImNlbnRlciIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiB3aWR0aD0iMTAwJSIgc3R5bGU9IndpZHRoOjEwMCUiPjx0Ym9keT48dHI-PHRkPjxkaXY-PHRhYmxlIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBzdHlsZT0id2lkdGg6MTAwJSI-PHRib2R5Pjx0cj48dGQgY2xhc3M9InBjLXBhZGRpbmctMjQiIHN0eWxlPSJwYWRkaW5nOjEycHggNnB4Ij48dGFibGUgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGFsaWduPSJsZWZ0Ij48dGJvZHk-PHRyPjx0ZCBjbGFzcz0icGMtZm9udC0yNCIgc3R5bGU9ImZvbnQtc2l6ZToyMHB4O2xpbmUtaGVpZ2h0OjI0cHgiPjxkaXYgc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQiPiBUcmVuZGluZyBjYXRlZ29yaWVzIDwvZGl2PjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48ZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowcHggYXV0bzttYXgtd2lkdGg6NjE2cHgiPjx0YWJsZSBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHdpZHRoPSIxMDAlIiBzdHlsZT0iZm9udC1zaXplOjB2dztsaW5lLWhlaWdodDowIj48dGJvZHk-PHRyPjx0ZD48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7ZGlyZWN0aW9uOmx0cjtkaXNwbGF5OmlubGluZS1ibG9jazt2ZXJ0aWNhbC1hbGlnbjp0b3A7d2lkdGg6MjUlIj48dGFibGUgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGFsaWduPSJsZWZ0IiB3aWR0aD0iMTAwJSI-PHRib2R5Pjx0cj48dGQgY2xhc3M9InBjLXBhZGRpbmctMTIiIHN0eWxlPSJwYWRkaW5nOjRweCI-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vdHJhZGUvc2VhcmNoP3NwbT1hMjcwMC5nYWxsZXJ5b2ZmZXJsaXN0LnRoZS1uZXctaGVhZGVyX2Z5MjNfcGNfc2VhcmNoX2Jhci5rZXlkb3duX19FbnRlciZ0YWI9YWxsJlNlYXJjaFRleHQ9ZWxlY3Ryb25pY3MmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjpub25lIj48aW1nIGFsdD0iQ29uc3VtZXIgRWxlY3Ryb25pY3MiIHNyYz0iaHR0cHM6Ly9pbWcuYWxpY2RuLmNvbS9pbWdleHRyYS9pMy9PMUNOMDFlUkEyVWUxeGxpeERLV2dOb18hITYwMDAwMDAwMDY0ODQtMi10cHMtMTc2LTE3Ni5wbmciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTtib3JkZXItcmFkaXVzOjhweDt3aWR0aDoxMDAlO2xldHRlci1zcGFjaW5nOjBweCIgYm9yZGVyPSIwcHgiLz48cCBzdHlsZT0iY29sb3I6cmdiKDExOCwgMTE4LCAxMTgpO2ZvbnQtc2l6ZToxM3B4O2ZvbnQtZmFtaWx5OnVuZGVmaW5lZDtsaW5lLWhlaWdodDoxNnB4O2ZvbnQtd2VpZ2h0OjQwMDt0ZXh0LWFsaWduOmNlbnRlcjtwYWRkaW5nOjBweDttYXJnaW46MTJweCAwcHggMHB4O3ZlcnRpY2FsLWFsaWduOm1pZGRsZTt0ZXh0LWRlY29yYXRpb246bm9uZTtvdmVyZmxvdy13cmFwOm5vcm1hbDt3b3JkLWJyZWFrOmtlZXAtYWxsIj4gQ29uc3VtZXIgRWxlY3Ryb25pY3MgPC9wPjwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvZGl2PjxkaXYgc3R5bGU9InRleHQtYWxpZ246bGVmdDtkaXJlY3Rpb246bHRyO2Rpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDoyNSUiPjx0YWJsZSBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgYWxpZ249ImxlZnQiIHdpZHRoPSIxMDAlIj48dGJvZHk-PHRyPjx0ZCBjbGFzcz0icGMtcGFkZGluZy0xMiIgc3R5bGU9InBhZGRpbmc6NHB4Ij48YSBocmVmPSJodHRwczovL3d3dy5hbGliYWJhLmNvbS90cmFkZS9zZWFyY2g_c3BtPWEyNzAwLmdhbGxlcnlvZmZlcmxpc3QudGhlLW5ldy1oZWFkZXJfZnkyM19wY19zZWFyY2hfYmFyLmtleWRvd25fX0VudGVyJnRhYj1hbGwmU2VhcmNoVGV4dD1hcHBhcmVsJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246bm9uZSI-PGltZyBhbHQ9IkFwcGFyZWwiIHNyYz0iaHR0cHM6Ly9pbWcuYWxpY2RuLmNvbS9pbWdleHRyYS9pMi9PMUNOMDEyQlU0Nkkxa3kwWlRWS25nSV8hITYwMDAwMDAwMDQ3NTEtMi10cHMtMTc2LTE3Ni5wbmciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTtib3JkZXItcmFkaXVzOjhweDt3aWR0aDoxMDAlO2xldHRlci1zcGFjaW5nOjBweCIgYm9yZGVyPSIwcHgiLz48cCBzdHlsZT0iY29sb3I6cmdiKDExOCwgMTE4LCAxMTgpO2ZvbnQtc2l6ZToxM3B4O2ZvbnQtZmFtaWx5OnVuZGVmaW5lZDtsaW5lLWhlaWdodDoxNnB4O2ZvbnQtd2VpZ2h0OjQwMDt0ZXh0LWFsaWduOmNlbnRlcjtwYWRkaW5nOjBweDttYXJnaW46MTJweCAwcHggMHB4O3ZlcnRpY2FsLWFsaWduOm1pZGRsZTt0ZXh0LWRlY29yYXRpb246bm9uZTtvdmVyZmxvdy13cmFwOm5vcm1hbDt3b3JkLWJyZWFrOmtlZXAtYWxsIj4gQXBwYXJlbCA8L3A-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9kaXY-PGRpdiBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0O2RpcmVjdGlvbjpsdHI7ZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjI1JSI-PHRhYmxlIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBhbGlnbj0ibGVmdCIgd2lkdGg9IjEwMCUiPjx0Ym9keT48dHI-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLTEyIiBzdHlsZT0icGFkZGluZzo0cHgiPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3RyYWRlL3NlYXJjaD9mc2I9eSZJbmRleEFyZWE9cHJvZHVjdF9lbiZrZXl3b3Jkcz12ZWhpY2xlK3BhcnRzJm9yaWdpbktleXdvcmRzPXZlaGljbGUrcGFydHMmdGFiPWFsbCZ2aWV3dHlwZT1MJnNwbT1hMjcwMC5nYWxsZXJ5b2ZmZXJsaXN0LnZpZXd0eXBlLkwmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjpub25lIj48aW1nIGFsdD0iVmVoaWNsZXMgJiBBY2Nlc3NvcmllcyIgc3JjPSJodHRwczovL2ltZy5hbGljZG4uY29tL2ltZ2V4dHJhL2kxL08xQ04wMW1kSlRYVjI0amNSVFZRcXJsXyEhNjAwMDAwMDAwNzQyNy0yLXRwcy0xNzYtMTc2LnBuZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2JvcmRlci1yYWRpdXM6OHB4O3dpZHRoOjEwMCU7bGV0dGVyLXNwYWNpbmc6MHB4IiBib3JkZXI9IjBweCIvPjxwIHN0eWxlPSJjb2xvcjpyZ2IoMTE4LCAxMTgsIDExOCk7Zm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6dW5kZWZpbmVkO2xpbmUtaGVpZ2h0OjE2cHg7Zm9udC13ZWlnaHQ6NDAwO3RleHQtYWxpZ246Y2VudGVyO3BhZGRpbmc6MHB4O21hcmdpbjoxMnB4IDBweCAwcHg7dmVydGljYWwtYWxpZ246bWlkZGxlO3RleHQtZGVjb3JhdGlvbjpub25lO292ZXJmbG93LXdyYXA6bm9ybWFsO3dvcmQtYnJlYWs6a2VlcC1hbGwiPiBWZWhpY2xlcyAmIEFjY2Vzc29yaWVzIDwvcD48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2Rpdj48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7ZGlyZWN0aW9uOmx0cjtkaXNwbGF5OmlubGluZS1ibG9jazt2ZXJ0aWNhbC1hbGlnbjp0b3A7d2lkdGg6MjUlIj48dGFibGUgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGFsaWduPSJsZWZ0IiB3aWR0aD0iMTAwJSI-PHRib2R5Pjx0cj48dGQgY2xhc3M9InBjLXBhZGRpbmctMTIiIHN0eWxlPSJwYWRkaW5nOjRweCI-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vdHJhZGUvc2VhcmNoP3NwbT1hMjcwMC5nYWxsZXJ5b2ZmZXJsaXN0LnRoZS1uZXctaGVhZGVyX2Z5MjNfcGNfc2VhcmNoX2Jhci5rZXlkb3duX19FbnRlciZ0YWI9YWxsJlNlYXJjaFRleHQ9c3BvcnRzJm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246bm9uZSI-PGltZyBhbHQ9IlNwb3J0cyAmIEVudGVydGFpbm1lbnQiIHNyYz0iaHR0cHM6Ly9pbWcuYWxpY2RuLmNvbS9pbWdleHRyYS9pMy9PMUNOMDFXdFpzd3ExRFhZTktVdjRsdF8hITYwMDAwMDAwMDAyMjYtMi10cHMtMTc2LTE3Ni5wbmciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO291dGxpbmU6bm9uZTtib3JkZXI6bm9uZTt0ZXh0LWRlY29yYXRpb246bm9uZTtib3JkZXItcmFkaXVzOjhweDt3aWR0aDoxMDAlO2xldHRlci1zcGFjaW5nOjBweCIgYm9yZGVyPSIwcHgiLz48cCBzdHlsZT0iY29sb3I6cmdiKDExOCwgMTE4LCAxMTgpO2ZvbnQtc2l6ZToxM3B4O2ZvbnQtZmFtaWx5OnVuZGVmaW5lZDtsaW5lLWhlaWdodDoxNnB4O2ZvbnQtd2VpZ2h0OjQwMDt0ZXh0LWFsaWduOmNlbnRlcjtwYWRkaW5nOjBweDttYXJnaW46MTJweCAwcHggMHB4O3ZlcnRpY2FsLWFsaWduOm1pZGRsZTt0ZXh0LWRlY29yYXRpb246bm9uZTtvdmVyZmxvdy13cmFwOm5vcm1hbDt3b3JkLWJyZWFrOmtlZXAtYWxsIj4gU3BvcnRzICYgRW50ZXJ0YWlubWVudCA8L3A-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9kaXY-PGRpdiBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0O2RpcmVjdGlvbjpsdHI7ZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjI1JSI-PHRhYmxlIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBhbGlnbj0ibGVmdCIgd2lkdGg9IjEwMCUiPjx0Ym9keT48dHI-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLTEyIiBzdHlsZT0icGFkZGluZzo0cHgiPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3RyYWRlL3NlYXJjaD9zcG09YTI3MDAuZ2FsbGVyeW9mZmVybGlzdC50aGUtbmV3LWhlYWRlcl9meTIzX3BjX3NlYXJjaF9iYXIuc2VhcmNoQnV0dG9uJnRhYj1hbGwmU2VhcmNoVGV4dD1JbmR1c3RyaWFsK01hY2hpbmVyeSZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOm5vbmUiPjxpbWcgYWx0PSJJbmR1c3RyaWFsIE1hY2hpbmVyeSIgc3JjPSJodHRwczovL2ltZy5hbGljZG4uY29tL2ltZ2V4dHJhL2k0L08xQ04wMUR0TDA0SDFVZWszZm8yNmtYXyEhNjAwMDAwMDAwMjU0My0yLXRwcy0xNzYtMTc2LnBuZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2JvcmRlci1yYWRpdXM6OHB4O3dpZHRoOjEwMCU7bGV0dGVyLXNwYWNpbmc6MHB4IiBib3JkZXI9IjBweCIvPjxwIHN0eWxlPSJjb2xvcjpyZ2IoMTE4LCAxMTgsIDExOCk7Zm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6dW5kZWZpbmVkO2xpbmUtaGVpZ2h0OjE2cHg7Zm9udC13ZWlnaHQ6NDAwO3RleHQtYWxpZ246Y2VudGVyO3BhZGRpbmc6MHB4O21hcmdpbjoxMnB4IDBweCAwcHg7dmVydGljYWwtYWxpZ246bWlkZGxlO3RleHQtZGVjb3JhdGlvbjpub25lO292ZXJmbG93LXdyYXA6bm9ybWFsO3dvcmQtYnJlYWs6a2VlcC1hbGwiPiBJbmR1c3RyaWFsIE1hY2hpbmVyeSA8L3A-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9kaXY-PGRpdiBzdHlsZT0idGV4dC1hbGlnbjpsZWZ0O2RpcmVjdGlvbjpsdHI7ZGlzcGxheTppbmxpbmUtYmxvY2s7dmVydGljYWwtYWxpZ246dG9wO3dpZHRoOjI1JSI-PHRhYmxlIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgYm9yZGVyPSIwIiBhbGlnbj0ibGVmdCIgd2lkdGg9IjEwMCUiPjx0Ym9keT48dHI-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLTEyIiBzdHlsZT0icGFkZGluZzo0cHgiPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmFsaWJhYmEuY29tL3RyYWRlL3NlYXJjaD9mc2I9eSZJbmRleEFyZWE9cHJvZHVjdF9lbiZrZXl3b3Jkcz1ob21lKyUyNitnYXJkZW4mb3JpZ2luS2V5d29yZHM9aG9tZSslMjYrZ2FyZGVuJnRhYj1hbGwmJnBhZ2U9MSZzcG09YTI3MDAuZ2FsbGVyeW9mZmVybGlzdC5wYWdpbmF0aW9uLjAmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjpub25lIj48aW1nIGFsdD0iSG9tZSAmIEdhcmRlbiIgc3JjPSJodHRwczovL2ltZy5hbGljZG4uY29tL2ltZ2V4dHJhL2kyL08xQ04wMUZGd1BmODIzcWV1bTZob2FFXyEhNjAwMDAwMDAwNzMwNy0yLXRwcy0xNzYtMTc2LnBuZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2JvcmRlci1yYWRpdXM6OHB4O3dpZHRoOjEwMCU7bGV0dGVyLXNwYWNpbmc6MHB4IiBib3JkZXI9IjBweCIvPjxwIHN0eWxlPSJjb2xvcjpyZ2IoMTE4LCAxMTgsIDExOCk7Zm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6dW5kZWZpbmVkO2xpbmUtaGVpZ2h0OjE2cHg7Zm9udC13ZWlnaHQ6NDAwO3RleHQtYWxpZ246Y2VudGVyO3BhZGRpbmc6MHB4O21hcmdpbjoxMnB4IDBweCAwcHg7dmVydGljYWwtYWxpZ246bWlkZGxlO3RleHQtZGVjb3JhdGlvbjpub25lO292ZXJmbG93LXdyYXA6bm9ybWFsO3dvcmQtYnJlYWs6a2VlcC1hbGwiPiBIb21lICYgR2FyZGVuIDwvcD48L2E-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2Rpdj48ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOmxlZnQ7ZGlyZWN0aW9uOmx0cjtkaXNwbGF5OmlubGluZS1ibG9jazt2ZXJ0aWNhbC1hbGlnbjp0b3A7d2lkdGg6MjUlIj48dGFibGUgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIGFsaWduPSJsZWZ0IiB3aWR0aD0iMTAwJSI-PHRib2R5Pjx0cj48dGQgY2xhc3M9InBjLXBhZGRpbmctMTIiIHN0eWxlPSJwYWRkaW5nOjRweCI-PGEgaHJlZj0iaHR0cHM6Ly93d3cuYWxpYmFiYS5jb20vdHJhZGUvc2VhcmNoP3NwbT1hMjcwMC5nYWxsZXJ5b2ZmZXJsaXN0LnRoZS1uZXctaGVhZGVyX2Z5MjNfcGNfc2VhcmNoX2Jhci5rZXlkb3duX19FbnRlciZ0YWI9YWxsJlNlYXJjaFRleHQ9YmVhdXR5Jm10PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb246bm9uZSI-PGltZyBhbHQ9IkJlYXV0eSIgc3JjPSJodHRwczovL2ltZy5hbGljZG4uY29tL2ltZ2V4dHJhL2k0L08xQ04wMXFPU3VOVzI2YTdTWWJydHliXyEhNjAwMDAwMDAwNzY3Ny0yLXRwcy0xNzYtMTc2LnBuZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2JvcmRlci1yYWRpdXM6OHB4O3dpZHRoOjEwMCU7bGV0dGVyLXNwYWNpbmc6MHB4IiBib3JkZXI9IjBweCIvPjxwIHN0eWxlPSJjb2xvcjpyZ2IoMTE4LCAxMTgsIDExOCk7Zm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6dW5kZWZpbmVkO2xpbmUtaGVpZ2h0OjE2cHg7Zm9udC13ZWlnaHQ6NDAwO3RleHQtYWxpZ246Y2VudGVyO3BhZGRpbmc6MHB4O21hcmdpbjoxMnB4IDBweCAwcHg7dmVydGljYWwtYWxpZ246bWlkZGxlO3RleHQtZGVjb3JhdGlvbjpub25lO292ZXJmbG93LXdyYXA6bm9ybWFsO3dvcmQtYnJlYWs6a2VlcC1hbGwiPiBCZWF1dHkgPC9wPjwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvZGl2PjxkaXYgc3R5bGU9InRleHQtYWxpZ246bGVmdDtkaXJlY3Rpb246bHRyO2Rpc3BsYXk6aW5saW5lLWJsb2NrO3ZlcnRpY2FsLWFsaWduOnRvcDt3aWR0aDoyNSUiPjx0YWJsZSBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCIgYWxpZ249ImxlZnQiIHdpZHRoPSIxMDAlIj48dGJvZHk-PHRyPjx0ZCBjbGFzcz0icGMtcGFkZGluZy0xMiIgc3R5bGU9InBhZGRpbmc6NHB4Ij48YSBocmVmPSJodHRwczovL3d3dy5hbGliYWJhLmNvbS90cmFkZS9zZWFyY2g_c3BtPWEyNzAwLmdhbGxlcnlvZmZlcmxpc3QudGhlLW5ldy1oZWFkZXJfZnkyM19wY19zZWFyY2hfYmFyLmtleWRvd25fX0VudGVyJnRhYj1hbGwmU2VhcmNoVGV4dD0yMDI1K25ldyZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOm5vbmUiPjxpbWcgYWx0PSJBbGwgY2F0ZWdvcmllcyIgc3JjPSJodHRwczovL2ltZy5hbGljZG4uY29tL2ltZ2V4dHJhL2kxL08xQ04wMXNMbnZUbDIxODdBQWhCSE9wXyEhNjAwMDAwMDAwNjkzOS0yLXRwcy0xNzYtMTc2LnBuZyIgc3R5bGU9ImRpc3BsYXk6YmxvY2s7b3V0bGluZTpub25lO2JvcmRlcjpub25lO3RleHQtZGVjb3JhdGlvbjpub25lO2JvcmRlci1yYWRpdXM6OHB4O3dpZHRoOjEwMCU7bGV0dGVyLXNwYWNpbmc6MHB4IiBib3JkZXI9IjBweCIvPjxwIHN0eWxlPSJjb2xvcjpyZ2IoMTE4LCAxMTgsIDExOCk7Zm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6dW5kZWZpbmVkO2xpbmUtaGVpZ2h0OjE2cHg7Zm9udC13ZWlnaHQ6NDAwO3RleHQtYWxpZ246Y2VudGVyO3BhZGRpbmc6MHB4O21hcmdpbjoxMnB4IDBweCAwcHg7dmVydGljYWwtYWxpZ246bWlkZGxlO3RleHQtZGVjb3JhdGlvbjpub25lO292ZXJmbG93LXdyYXA6bm9ybWFsO3dvcmQtYnJlYWs6a2VlcC1hbGwiPiBBbGwgY2F0ZWdvcmllcyA8L3A-PC9hPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC9kaXY-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L2Rpdj48L2Rpdj48L2Rpdj48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PHRhYmxlIGFsaWduPSJjZW50ZXIiIHdpZHRoPSIxMDAlIiBib3JkZXI9IjAiIGNlbGxwYWRkaW5nPSIwIiBjZWxsc3BhY2luZz0iMCIgcm9sZT0icHJlc2VudGF0aW9uIiBzdHlsZT0ibWF4LXdpZHRoOjY0MHB4O3dpZHRoOjEwMCU7bWFyZ2luOjAgYXV0bztiYWNrZ3JvdW5kOiNGNEY0RjQ7bWFyZ2luLXRvcDoxMnB4Ij48dGJvZHk-PHRyIHN0eWxlPSJ3aWR0aDoxMDAlIj48dGQ-PHRhYmxlIHdpZHRoPSIxMDAlIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIGJvcmRlcj0iMCI-PHRib2R5Pjx0cj48dGQgY2xhc3M9InBjLXBhZGRpbmctbGVmdC0yNCBwYy1wYWRkaW5nLXJpZ2h0LTI0IiBzdHlsZT0icGFkZGluZzo0MHB4IDEycHgiPjx0YWJsZSB3aWR0aD0iMTAwJSIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiPjx0Ym9keT48dHI-PHRkIHN0eWxlPSJ0ZXh0LWFsaWduOmNlbnRlcjtwYWRkaW5nLWJvdHRvbToyOHB4Ij48c3BhbiBzdHlsZT0iY29sb3I6Izc2NzY3Njtmb250LXNpemU6MTFweDtmb250LXdlaWdodDo0MDA7bGluZS1oZWlnaHQ6MTZweDtsZXR0ZXItc3BhY2luZzowLjFweDtkaXNwbGF5OmJsb2NrO21heC13aWR0aDo1NzRweDttYXJnaW46MCBhdXRvIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PGRpdj4gSWYgeW91IG5vIGxvbmdlciB3aXNoIHRvIHJlY2VpdmUgdGhpcyBraW5kIG9mIGVtYWlscywgPGJyLz55b3UgbWF5IGNoYW5nZSB5b3VyIHByZWZlcmVuY2VzIGJ5IGNsaWNraW5nIHRoZSBsaW5rIGJlbG93LiA8L2Rpdj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjwvc3Bhbj48L3RkPjwvdHI-PHRyPjx0ZCBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXI7cGFkZGluZy1ib3R0b206MjhweCI-PHNwYW4gc3R5bGU9ImRpc3BsYXk6bm9uZSI-PC9zcGFuPjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48dGFibGUgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIiBib3JkZXI9IjAiIHN0eWxlPSJtYXJnaW46MCBhdXRvIj48dGJvZHk-PHRyPjx0ZCBjbGFzcz0icGMtcGFkZGluZy1yaWdodC0yMCIgc3R5bGU9InBhZGRpbmctcmlnaHQ6OHB4Ij48YSBocmVmPSJodHRwczovL3J1bGVjaGFubmVsLmFsaWJhYmEuY29tL2ljYnU_dHlwZT1kZXRhaWwmcnVsZUlkPTIwMzQmY0lkPTEzMDYmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSMvcnVsZS9kZXRhaWw_Y0lkPTEzMDYmcnVsZUlkPTIwMzQiIHN0eWxlPSJjb2xvcjojMjIyMjIyO2ZvbnQtc2l6ZToxMHB4O2ZvbnQtd2VpZ2h0OjQwMDtsaW5lLWhlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6LTAuMXB4O2xpbmUtYnJlYWs6YW55d2hlcmUiPlByaXZhY3kgUG9saWN5PC9hPjwvdGQ-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLXJpZ2h0LTIwIiBzdHlsZT0icGFkZGluZy1yaWdodDo4cHgiPjxzcGFuIHN0eWxlPSJjb2xvcjojMjIyMjIyO2ZvbnQtc2l6ZToxMHB4O2ZvbnQtd2VpZ2h0OjQwMDtsaW5lLWhlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6LTAuMXB4Ij58PC9zcGFuPjwvdGQ-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLXJpZ2h0LTIwIiBzdHlsZT0icGFkZGluZy1yaWdodDo4cHgiPjxhIGhyZWY9Imh0dHBzOi8vcnVsZWNoYW5uZWwuYWxpYmFiYS5jb20vaWNidT90eXBlPWRldGFpbCZydWxlSWQ9MjA0MSZjSWQ9MTMwNyZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIy9ydWxlL2RldGFpbD9jSWQ9MTMwNyZydWxlSWQ9MjA0MSIgc3R5bGU9ImNvbG9yOiMyMjIyMjI7Zm9udC1zaXplOjEwcHg7Zm9udC13ZWlnaHQ6NDAwO2xpbmUtaGVpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzotMC4xcHg7bGluZS1icmVhazphbnl3aGVyZSI-VGVybXMgb2YgVXNlPC9hPjwvdGQ-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLXJpZ2h0LTIwIiBzdHlsZT0icGFkZGluZy1yaWdodDo4cHgiPjxzcGFuIHN0eWxlPSJjb2xvcjojMjIyMjIyO2ZvbnQtc2l6ZToxMHB4O2ZvbnQtd2VpZ2h0OjQwMDtsaW5lLWhlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6LTAuMXB4Ij58PC9zcGFuPjwvdGQ-PHRkIGNsYXNzPSJwYy1wYWRkaW5nLXJpZ2h0LTIwIiBzdHlsZT0icGFkZGluZy1yaWdodDo4cHgiPjxhIGhyZWY9Imh0dHBzOi8vYWlyLmFsaWJhYmEuY29tL2FwcC9zYy1hc3NldHMvZWRtX3Vuc3Vic2NyaWJlL3BhZ2VzLmh0bWw_dXJsX3R5cGU9Zm9vdGVyX3Vuc3ViJnRyYWNlbG9nPXVuc3ViX2NvbiYkdW5zdWJzY3JpcHRpb25FbmNyeXB0VG9vbC51bnN1YnNjcmlwdGlvbkVuY3J5cHQmbXQ9bWFpbCZjcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmc19pZD1wdXNoLXRhc2tfMTEwNjc1JnRfaWQ9MjAwMDExNDc2MiZjX2lkPTQxMTcxJmFzX3Rva2VuPXFieFMwUWNaMzlXNUtNZmdKS3R5amczNU12d3dKTEF2S2Y5aURUZGQzc0lzN2R2ZiZ0bz1rb3RoYXJpcXV0dWIlNDBnbWFpbC5jb20mZnJvbT1ub3JlcGx5JTQwc2VydmljZS5hbGliYWJhLmNvbSIgc3R5bGU9ImNvbG9yOiMyMjIyMjI7Zm9udC1zaXplOjEwcHg7Zm9udC13ZWlnaHQ6NDAwO2xpbmUtaGVpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzotMC4xcHg7bGluZS1icmVhazphbnl3aGVyZSI-RW1haWwgUHJlZmVyZW5jZXM8L2E-PC90ZD48dGQgY2xhc3M9InBjLXBhZGRpbmctcmlnaHQtMjAiIHN0eWxlPSJwYWRkaW5nLXJpZ2h0OjhweCI-PHNwYW4gc3R5bGU9ImNvbG9yOiMyMjIyMjI7Zm9udC1zaXplOjEwcHg7Zm9udC13ZWlnaHQ6NDAwO2xpbmUtaGVpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzotMC4xcHgiPnw8L3NwYW4-PC90ZD48dGQ-PGEgaHJlZj0iaHR0cHM6Ly9haXIuYWxpYmFiYS5jb20vYXBwL3NjLWFzc2V0cy9lZG1fdW5zdWJzY3JpYmUvcGFnZXMuaHRtbD91cmxfdHlwZT1mb290ZXJfdW5zdWImdHJhY2Vsb2c9dW5zdWJfY29uJiR1bnN1YnNjcmlwdGlvbkVuY3J5cHRUb29sLnVuc3Vic2NyaXB0aW9uRW5jcnlwdCZtdD1tYWlsJmNybV9tdG5fdHJhY2Vsb2dfbG9nX2lkPTExMzk2NTA4NjQ2NCZzX2lkPXB1c2gtdGFza18xMTA2NzUmdF9pZD0yMDAwMTE0NzYyJmNfaWQ9NDExNzEmYXNfdG9rZW49cWJ4UzBRY1ozOVc1S01mZ0pLdHlqZzM1TXZ3d0pMQXZLZjlpRFRkZDNzSXM3ZHZmJnRvPWtvdGhhcmlxdXR1YiU0MGdtYWlsLmNvbSZmcm9tPW5vcmVwbHklNDBzZXJ2aWNlLmFsaWJhYmEuY29tIiBzdHlsZT0iY29sb3I6IzIyMjIyMjtmb250LXNpemU6MTBweDtmb250LXdlaWdodDo0MDA7bGluZS1oZWlnaHQ6bm9ybWFsO2xldHRlci1zcGFjaW5nOi0wLjFweDtsaW5lLWJyZWFrOmFueXdoZXJlIj5VbnN1YnNjcmliZTwvYT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvdGQ-PC90cj48dHI-PHRkIHN0eWxlPSJ0ZXh0LWFsaWduOmNlbnRlcjtwYWRkaW5nLWJvdHRvbToyOHB4Ij48c3BhbiBzdHlsZT0iY29sb3I6Izc2NzY3Njtmb250LXNpemU6MTFweDtmb250LXdlaWdodDo0MDA7bGluZS1oZWlnaHQ6MTZweDtsZXR0ZXItc3BhY2luZzowLjFweDtkaXNwbGF5OmJsb2NrO21heC13aWR0aDo1OTJweDttYXJnaW46MCBhdXRvIj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PGRpdj4gSWYgeW91IGNhbm5vdCB1bnN1YnNjcmliZSBmcm9tIHRoZSBtYWlsaW5nIGxpc3Qgb3IgaGF2ZSBjb25jZXJucyBhYm91dCB5b3VyIHBlcnNvbmFsIGRhdGEsIHBsZWFzZSBlbWFpbCBEYXRhUHJvdGVjdGlvbuKAi0BzZXJ2aWNlLuKAi2FsaWJhYmHigIsuY29tIDwvZGl2PjxzcGFuIHN0eWxlPSJkaXNwbGF5Om5vbmUiPjwvc3Bhbj48c3BhbiBzdHlsZT0iZGlzcGxheTpub25lIj48L3NwYW4-PC9zcGFuPjwvdGQ-PC90cj48dHI-PHRkIHN0eWxlPSJ0ZXh0LWFsaWduOmNlbnRlciI-PHNwYW4gc3R5bGU9ImNvbG9yOiM3Njc2NzY7Zm9udC1zaXplOjExcHg7Zm9udC13ZWlnaHQ6NDAwO2xpbmUtaGVpZ2h0OjE2cHg7bGV0dGVyLXNwYWNpbmc6MC4xcHg7ZGlzcGxheTpibG9jayI-QWxpYmFiYS5jb20gU2luZ2Fwb3JlIEUtY29tbWVyY2UgUHJpdmF0ZSBMaW1pdGVkLCA1MSBCcmFzIEJhc2FoIFJvYWQsICMwNC0wOCBMYXphZGEgT25lLCBTaW5nYXBvcmUgMTg5NTU0PC9zcGFuPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PC90ZD48L3RyPjwvdGJvZHk-PC90YWJsZT48L3RkPjwvdHI-PC90Ym9keT48L3RhYmxlPjwvdGQ-PC90cj48L3Rib2R5PjwvdGFibGU-PGlucHV0IHR5cGU9InRleHQiIHZhbHVlPSJodHRwczovL3VzbXkuYWxpYmFiYS5jb20vdXNlci9lbWFpbHNlcnZpY2UvdW5zdWJzY3JpYmVfZW50cnkuaHRtP3VybF90eXBlPWZvb3Rlcl91bnN1YiZ0cmFjZWxvZz11bnN1Yl9jb24mXzAwMF9lX2FfPVBuNlZvU0FKa0k0aTVLdGVENHJjc2VldDlkSlpZQmJrQTZ3QndDMmpwUWslM0QmXzAwMF9lX3RfPVJIUS13RHgqa2FORW12SWwtbEhHcEpYRXZoQTA1TVkqN09Hc0JVb2YqY0UlM0QiIHN0eWxlPSJ3aWR0aDowO2hlaWdodDowIi8-PGltZyBzdHlsZT0iZGlzcGxheTpub25lOyB2aXNpYmlsaXR5OmhpZGRlbjsgY29sb3I6I2ZmZjsiIHdpZHRoPSIwIiBoZWlnaHQ9IjAiIHNyYz0iaHR0cHM6Ly9hbGljcm0uYWxpYmFiYS5jb20vb3V0ZXIvZW1haWwvc2V0UmVhZFN0YXR1cy5odG1sP210PW1haWwmY3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JnNfaWQ9cHVzaC10YXNrXzExMDY3NSZ0X2lkPTIwMDAxMTQ3NjImY19pZD00MTE3MSZhc190b2tlbj1xYnhTMFFjWjM5VzVLTWZnSkt0eWpnMzVNdnd3SkxBdktmOWlEVGRkM3NJczdkdmYmdG89a290aGFyaXF1dHViJTQwZ21haWwuY29tJmZyb209bm9yZXBseSU0MHNlcnZpY2UuYWxpYmFiYS5jb20iLz48aW1nIHN0eWxlPSJkaXNwbGF5Om5vbmU7IHZpc2liaWxpdHk6aGlkZGVuOyBjb2xvcjojZmZmOyIgd2lkdGg9IjAiIGhlaWdodD0iMCIgc3JjPSJodHRwOi8vc3RhdC5hbGliYWJhLmNvbS9tYWlsX2NhbGxiYWNrLmh0bWw_Y3JtX210bl90cmFjZWxvZ19sb2dfaWQ9MTEzOTY1MDg2NDY0JmNybV9tdG5fdHJhY2Vsb2dfdGFza19pZD1wdXNoLXRhc2tfMTEwNjc1Ii8-PGltZyBzdHlsZT0iZGlzcGxheTpub25lOyB2aXNpYmlsaXR5OmhpZGRlbjsgY29sb3I6I2ZmZjsiIHdpZHRoPSIwIiBoZWlnaHQ9IjAiIHNyYz0iaHR0cDovL2dtLm1tc3RhdC5jb20vYnRvYi4xMD9jcm1fbXRuX3RyYWNlbG9nX2xvZ19pZD0xMTM5NjUwODY0NjQmY3JtX210bl90cmFjZWxvZ190YXNrX2lkPXB1c2gtdGFza18xMTA2NzUmZnJvbT1ub3JlcGx5QHNlcnZpY2UuYWxpYmFiYS5jb20mdG89a290aGFyaXF1dHViQGdtYWlsLmNvbSZmcm9tX3N5cz1udWxsJmJpel90eXBlPW51bGwmdGVtcGxhdGU9bnVsbCIvPjwvYm9keT48L2h0bWw-"}}]},"sizeEstimate":63590,"historyId":"2853271","internalDate":"1768058737000"}', '2026-01-11T04:56:57.921Z', '19ba883630fc079b', '19ba883630fc079b', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, 0)
ON CONFLICT DO NOTHING;



-- Data for: generated_documents (1 rows)
INSERT INTO generated_documents (id, tenant_id, template_id, document_number, document_type, document_title, entity_type, entity_id, generated_html, generated_pdf_path, generated_pdf_url, generation_status, file_size, page_count, merge_data, version, parent_document_id, is_latest_version, sent_at, sent_to, sent_method, total_amount, currency, due_date, payment_status, generated_by, generated_at, finalized_at, finalized_by) VALUES
  ('96226c0c002195a3ac046665b161d75f', 'default-tenant', '61f50f32d13e9088c7fa12ccd17c79de', 'INV-2026010001', 'invoice', 'Sales Invoice - Customer XYZ', 'order', 'order-123', '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body { font-family: Arial; } .invoice { padding: 20px; } table { width: 100%; border-collapse: collapse; } th, td { padding: 8px; border-bottom: 1px solid #ddd; } .total { margin-top: 20px; font-size: 1.2em; }
  </style>
</head>
<body>
  
          <div class="invoice">
            <h1>INVOICE</h1>
            <p><strong>Invoice Number:</strong> INV-202601-0001</p>
            <p><strong>Date:</strong> 2026-01-18</p>
            
            <h3>Bill To:</h3>
            <p>ABC Corporation</p>
            <p>456 Client Avenue, Delhi</p>
            
            <h3>Items:</h3>
            <table>
              <thead>
                <tr>
                  <th>Description</th>
                  <th>Quantity</th>
                  <th>Unit Price</th>
                  <th>Total</th>
                </tr>
              </thead>
              <tbody>
                {{#each line_items}}
                <tr>
                  <td>{{product_name}}</td>
                  <td>{{quantity}}</td>
                  <td>₹{{unit_price}}</td>
                  <td>₹{{total}}</td>
                </tr>
                {{/each}}
              </tbody>
            </table>
            
            <div class="total">
              <p><strong>Total Amount:</strong> ₹7670</p>
            </div>
          </div>
        
</body>
</html>', NULL, NULL, 'draft', NULL, NULL, '{"document":{"number":"INV-202601-0001","date":"2026-01-18"},"customer":{"name":"ABC Corporation","address":"456 Client Avenue, Delhi"},"line_items":[{"product_name":"Product A","product_description":"Premium widget","quantity":10,"unit_price":500,"tax_percent":18,"total":5900},{"product_name":"Product B","product_description":"Standard gadget","quantity":5,"unit_price":300,"tax_percent":18,"total":1770}],"total_amount":7670,"currency":"INR","due_date":"2026-02-18"}', 1, NULL, 1, NULL, NULL, NULL, 7670, 'INR', '2026-02-18', 'pending', 'admin', '2026-01-18 07:39:16', NULL, NULL)
ON CONFLICT DO NOTHING;



-- Data for: geo_pricing (3 rows)
INSERT INTO geo_pricing (id, tenant_id, region_name, state, city, pincode, price_adjustment_type, price_adjustment, shipping_charges, tax_rate, is_active, created_at, updated_at) VALUES
  ('2f7394428eaa43c580e2ab16eb3863b1', '101f04af63cbefc2bf8f0a98b9ae1205', 'Mumbai Metro', 'Maharashtra', 'Mumbai', NULL, 'percentage', 5, 100, 18, 1, '2026-01-18 06:27:49', '2026-01-18 06:27:49'),
  ('1ee76f7715767a9934ccde6447dab270', '101f04af63cbefc2bf8f0a98b9ae1205', 'Delhi NCR', 'Delhi', 'Delhi', NULL, 'percentage', 3, 120, 18, 1, '2026-01-18 06:27:49', '2026-01-18 06:27:49'),
  ('d3d9167ccee75f7264c0f159fc1f8da4', '101f04af63cbefc2bf8f0a98b9ae1205', 'Bangalore Tech Hub', 'Karnataka', 'Bangalore', NULL, 'percentage', 4, 150, 18, 1, '2026-01-18 06:27:49', '2026-01-18 06:27:49')
ON CONFLICT DO NOTHING;


