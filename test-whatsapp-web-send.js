/**
 * Test WhatsApp Web Direct Send
 * Bot: 918484830021 (connected via WhatsApp Web)
 * Customer: 919537653927
 */

const axios = require('axios');

const BASE_URL = 'https://salesmate.saksolution.com';
const TENANT_ID = '112f12b8-55e9-4de8-9fda-d58e37c75796'; // Has WhatsApp Web connected

async function sendViaWhatsAppWeb() {
    try {
        console.log('Sending via WhatsApp Web API...');
        
        const response = await axios.post(`${BASE_URL}/api/whatsapp-web/send`, {
            tenantId: TENANT_ID,
            phone: '919537653927',
            message: 'Hello! 👋 This is a test message from Salesmate AI via WhatsApp Web.\n\nI received your message "Hi".\n\n✅ WhatsApp Web integration is working!\n✅ All systems operational',
            sessionName: 'default'
        });
        
        console.log('✓ Message sent successfully via WhatsApp Web!');
        console.log('Response:', JSON.stringify(response.data, null, 2));
        
    } catch (error) {
        console.error('✗ Failed to send:', error.response?.data || error.message);
        console.error('Status:', error.response?.status);
    }
}

sendViaWhatsAppWeb();
