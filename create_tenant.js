const { supabase } = require('./services/config');

async function createTenant() {
    const tenantData = {
        id: '45bebb5d-cbab-4338-a3eb-a5b0c4aeea4e',
        business_name: 'SAK Solutions',
        phone_number: '971507055253',
        plan: 'premium',
        api_key: '45bebb5d-cbab-4338-a3eb-a5b0c4aeea4e',
        business_description: 'Technology and Electronics Sales',
        business_hours: '9 AM - 6 PM, Monday to Friday',
        created_at: new Date().toISOString()
    };
    
    console.log('Creating tenant:', tenantData);
    
    const { data, error } = await supabase
        .from('tenants')
        .insert(tenantData)
        .select();
    
    if (error) {
        console.error('Error creating tenant:', error);
        process.exit(1);
    }
    
    console.log('✅ Tenant created successfully:', data);
    process.exit(0);
}

createTenant();
