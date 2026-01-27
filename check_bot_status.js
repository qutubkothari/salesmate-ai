const { supabase } = require('./supabaseClient');

async function checkStatus() {
    try {
        // Check tenants
        const { data: tenants, error } = await supabase
            .from('tenants')
            .select('id, name, whatsapp_number, is_active, whatsapp_connected')
            .order('id');
        
        if (error) throw error;
        
        console.log('\n=== TENANT STATUS ===');
        console.log(JSON.stringify(tenants, null, 2));
        
        // Check recent messages
        const { data: messages } = await supabase
            .from('messages')
            .select('*')
            .order('created_at', { ascending: false })
            .limit(5);
        
        console.log('\n=== RECENT MESSAGES ===');
        console.log(JSON.stringify(messages, null, 2));
        
    } catch (err) {
        console.error('Error:', err.message);
    }
    process.exit(0);
}

checkStatus();
