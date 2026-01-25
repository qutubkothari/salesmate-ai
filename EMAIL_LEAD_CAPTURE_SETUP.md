# Email Lead Capture Setup Guide

## Overview
The Email Lead Capture system automatically converts emails into leads in your CRM. It supports both company inbox and individual salesman email addresses.

## How It Works

### 1. Company Inbox → Auto-Assign Based on Settings
- Emails sent to your company email (e.g., `info@hylite.com`)
- Lead is created automatically
- Auto-assigned based on your assignment settings (round-robin, performance-based, etc.)
- Goes to triage queue if auto-assign is disabled

### 2. Salesman Email → Auto-Assign to That Salesman
- Emails sent to salesman's personal email (e.g., `salesman@hylite.com`)
- Lead is created and **automatically assigned to that specific salesman**
- Salesman sees it immediately in their dashboard

## Setup Instructions

### Option 1: SendGrid Inbound Parse (Recommended)

1. **Login to SendGrid** → Settings → Inbound Parse

2. **Add Inbound Parse Webhook**:
   - Hostname: `email.yourdomain.com` (or use existing domain)
   - URL: `https://sak-ai.saksolution.com/api/integrations/email/webhook`
   - Check "POST the raw, full MIME message"

3. **DNS Configuration**:
   Add MX record to your domain:
   ```
   Type: MX
   Host: email (or @)
   Value: mx.sendgrid.net
   Priority: 10
   ```

4. **Test**:
   Send email to `anything@email.yourdomain.com` - it will create a lead!

### Option 2: Mailgun Routes

1. **Login to Mailgun** → Sending → Routes

2. **Create Route**:
   - Expression Type: `Match Recipient`
   - Recipient: `.*@yourdomain.com`
   - Actions: 
     - Forward to: `https://sak-ai.saksolution.com/api/integrations/email/webhook`
     - Stop: Yes

3. **DNS Configuration**:
   Follow Mailgun's DNS setup instructions for receiving emails

### Option 3: Postmark Inbound

1. **Login to Postmark** → Servers → [Your Server]

2. **Add Inbound Webhook**:
   - URL: `https://sak-ai.saksolution.com/api/integrations/email/webhook`

3. **DNS Configuration**:
   Add MX record:
   ```
   Type: MX
   Host: @
   Value: inbound.postmarkapp.com
   Priority: 10
   ```

### Option 4: Custom Email Forwarding

If you have your own email server, set up a forwarding rule:

1. **Forward emails to**:
   ```
   POST https://sak-ai.saksolution.com/api/integrations/email/webhook
   
   Headers:
   Content-Type: application/json
   x-webhook-secret: YOUR_SECRET_KEY
   
   Body:
   {
     "from": "customer@example.com",
     "to": "info@hylite.com",
     "subject": "Inquiry about products",
     "text": "Email body text",
     "html": "<p>Email body HTML</p>"
   }
   ```

## Security

### Set Webhook Secret (Recommended)

Add to your `.env` file:
```
EMAIL_WEBHOOK_SECRET=your_random_secret_key_here
```

The webhook will verify this secret before processing emails.

## Testing

### Test Endpoint
```bash
curl https://sak-ai.saksolution.com/api/integrations/email/test
```

### Send Test Email
```bash
curl -X POST https://sak-ai.saksolution.com/api/integrations/email/webhook \
  -H "Content-Type: application/json" \
  -H "x-webhook-secret: YOUR_SECRET" \
  -d '{
    "from": "test@example.com",
    "to": "info@hylite.com",
    "subject": "Test Lead",
    "text": "This is a test inquiry"
  }'
```

## Salesman Email Setup

To enable auto-assignment to individual salesmen:

1. **Add Email to Salesman Profile**:
   - Go to Admin Portal → Salesmen Management
   - Edit salesman
   - Add their email address (e.g., `john@hylite.com`)

2. **Configure Email Routing**:
   Set up forwarding so emails to `john@hylite.com` hit the webhook

3. **Test**:
   Send email to `john@hylite.com` → Lead automatically assigned to John!

## Email Parsing

The system automatically extracts:
- **Email**: From sender
- **Name**: From signature or greeting
- **Phone**: International format (if present)
- **Company**: From email domain or signature
- **Message**: Email body

## Lead Creation Flow

```
Email Received
    ↓
Check: Sent to salesman email?
    ↓ YES → Auto-assign to that salesman
    ↓ NO → Company inbox
        ↓
Check: Auto-assign enabled?
    ↓ YES → Assign per settings (round-robin/performance)
    ↓ NO → Send to triage queue for manual assignment
```

## Troubleshooting

### Emails not creating leads?
1. Check webhook is receiving requests (check server logs)
2. Verify webhook secret matches
3. Test with curl command above

### Wrong salesman assigned?
1. Verify salesman email is correct in database
2. Check recipient email in webhook logs

### Leads going to triage instead of auto-assigning?
1. Check auto-assign is enabled in settings
2. Verify active salesmen are available
3. Check assignment settings

## API Endpoints

### POST /api/integrations/email/webhook
- **Purpose**: Receive inbound emails
- **Auth**: Webhook secret (optional but recommended)
- **Body**: Email data (varies by provider)
- **Response**: 
  ```json
  {
    "success": true,
    "leadId": "uuid",
    "isNew": true
  }
  ```

### GET /api/integrations/email/test
- **Purpose**: Test endpoint availability
- **Auth**: None
- **Response**: Setup instructions and supported providers

## Next Steps

1. Choose your email provider (SendGrid recommended)
2. Set up DNS records
3. Configure webhook
4. Test with sample email
5. Add salesman emails to their profiles
6. Start receiving leads automatically!

## Support

For issues or questions:
- Check server logs: `pm2 logs salesmate-ai`
- Test webhook: `/api/integrations/email/test`
- Contact support with error logs
