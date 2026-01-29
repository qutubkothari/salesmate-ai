const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(
    process.env.SUPABASE_URL || 'https://taqkfimlrlkyjbutashe.supabase.co',
    process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_KEY
);

(async () => {
    const { data, error } = await supabase
        .from('tenants')
        .select('password, primary_phone')
        .eq('id', '112f12b8-55e9-4de8-9fda-d58e37c75796')
        .single();
    
    if (error) {
        console.error('Error:', error);
    } else {
        console.log('Password:', data?.password);
        console.log('Primary Phone:', data?.primary_phone);
    }
    process.exit(0);
})();
