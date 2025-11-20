/**
 * Desktop Agent - WhatsApp Web Connection Handler
 * Runs on your PC - Handles WhatsApp Web connection locally
 * Communicates with cloud server only for AI processing
 */

const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const axios = require('axios');
const notifier = require('node-notifier');
require('dotenv').config();

// Configuration
const CLOUD_SERVER_URL = process.env.CLOUD_SERVER_URL || 'http://13.62.57.240:8080';
const TENANT_ID = process.env.TENANT_ID || 'default-tenant';
const API_KEY = process.env.API_KEY || '';

// WhatsApp Client with local session storage
const client = new Client({
    authStrategy: new LocalAuth({
        dataPath: './.wwebjs_auth'
    }),
    puppeteer: {
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-accelerated-2d-canvas',
            '--no-first-run',
            '--no-zygote',
            '--single-process',
            '--disable-gpu'
        ]
    }
});

console.log('🚀 Starting Desktop Agent...');
console.log(`📡 Cloud Server: ${CLOUD_SERVER_URL}`);
console.log(`👤 Tenant ID: ${TENANT_ID}`);

// QR Code Event
client.on('qr', (qr) => {
    console.log('\n📱 Scan this QR code with WhatsApp:');
    qrcode.generate(qr, { small: true });
    
    notifier.notify({
        title: 'WhatsApp Desktop Agent',
        message: 'Scan QR code to connect',
        sound: true
    });
});

// Ready Event
client.on('ready', async () => {
    console.log('✅ WhatsApp Web connected successfully!');
    console.log('📞 Phone number:', client.info.wid.user);
    
    notifier.notify({
        title: 'WhatsApp Connected',
        message: `Connected as ${client.info.pushname}`,
        sound: true
    });
    
    // Register with cloud server
    try {
        await axios.post(`${CLOUD_SERVER_URL}/api/desktop-agent/register`, {
            tenantId: TENANT_ID,
            phoneNumber: client.info.wid.user,
            deviceName: require('os').hostname(),
            status: 'online'
        }, {
            headers: { 'x-api-key': API_KEY }
        });
        console.log('✅ Registered with cloud server');
    } catch (error) {
        console.error('❌ Failed to register with cloud server:', error.message);
    }
});

// Authenticated Event
client.on('authenticated', () => {
    console.log('🔐 Authentication successful');
});

// Authentication Failure Event
client.on('auth_failure', (msg) => {
    console.error('❌ Authentication failed:', msg);
    notifier.notify({
        title: 'WhatsApp Authentication Failed',
        message: 'Please restart the agent',
        sound: true
    });
});

// Disconnected Event
client.on('disconnected', (reason) => {
    console.log('❌ WhatsApp disconnected:', reason);
    notifier.notify({
        title: 'WhatsApp Disconnected',
        message: reason,
        sound: true
    });
});

// Message Received Event
client.on('message', async (message) => {
    try {
        const from = message.from;
        const body = message.body;
        const isGroup = from.endsWith('@g.us');
        
        // Ignore group messages
        if (isGroup) return;
        
        console.log(`\n📨 Message from ${from}: ${body}`);
        
        // Send to cloud server for AI processing
        const response = await axios.post(
            `${CLOUD_SERVER_URL}/api/desktop-agent/process-message`,
            {
                tenantId: TENANT_ID,
                from: from,
                message: body,
                timestamp: new Date().toISOString(),
                messageId: message.id._serialized
            },
            {
                headers: { 'x-api-key': API_KEY },
                timeout: 30000 // 30 second timeout
            }
        );
        
        const aiResponse = response.data.reply;
        
        if (aiResponse) {
            console.log(`🤖 AI Response: ${aiResponse.substring(0, 100)}...`);
            
            // Send reply via WhatsApp
            await message.reply(aiResponse);
            console.log('✅ Reply sent');
            
            // Optional: Notify cloud that message was sent
            await axios.post(
                `${CLOUD_SERVER_URL}/api/desktop-agent/message-sent`,
                {
                    tenantId: TENANT_ID,
                    messageId: message.id._serialized,
                    sentAt: new Date().toISOString()
                },
                {
                    headers: { 'x-api-key': API_KEY }
                }
            ).catch(() => {}); // Silent fail
        }
        
    } catch (error) {
        console.error('❌ Error processing message:', error.message);
        
        // Fallback response if cloud is down
        try {
            await message.reply('Sorry, I am temporarily unable to process your message. Please try again in a moment.');
        } catch (e) {
            console.error('❌ Failed to send fallback message:', e.message);
        }
    }
});

// Message Create Event (for sent messages)
client.on('message_create', async (message) => {
    // Track outgoing messages if needed
    if (message.fromMe) {
        console.log(`📤 Sent message to ${message.to}: ${message.body}`);
    }
});

// Error handling
process.on('unhandledRejection', (error) => {
    console.error('❌ Unhandled rejection:', error);
});

process.on('SIGINT', async () => {
    console.log('\n👋 Shutting down gracefully...');
    
    // Notify cloud server
    try {
        await axios.post(`${CLOUD_SERVER_URL}/api/desktop-agent/disconnect`, {
            tenantId: TENANT_ID
        }, {
            headers: { 'x-api-key': API_KEY }
        });
    } catch (error) {
        // Silent fail
    }
    
    await client.destroy();
    process.exit(0);
});

// Health check endpoint (optional local API)
const express = require('express');
const app = express();
const PORT = process.env.LOCAL_PORT || 3001;

app.get('/health', (req, res) => {
    res.json({
        status: 'running',
        connected: client.info ? true : false,
        phoneNumber: client.info ? client.info.wid.user : null,
        tenantId: TENANT_ID
    });
});

app.listen(PORT, () => {
    console.log(`🏥 Health endpoint: http://localhost:${PORT}/health`);
});

// Initialize WhatsApp client
console.log('🔄 Initializing WhatsApp client...');
client.initialize();
