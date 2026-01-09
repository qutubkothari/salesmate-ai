require('dotenv').config();

const { createClient } = require('@supabase/supabase-js');

const USE_LOCAL_DB = process.env.USE_LOCAL_DB === 'true';

// Use Supabase instead of direct PostgreSQL
let supabase;

if (USE_LOCAL_DB) {
  // Reuse the Supabase-compatible wrapper backed by local SQLite.
  // This prevents boot failures when SUPABASE_URL is not configured.
  ({ supabase } = require('../services/config'));
} else {
  const supabaseUrl = process.env.SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    console.error('❌ Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY');
    throw new Error('supabaseUrl is required. Configure Supabase or set USE_LOCAL_DB=true for local mode.');
  }

  supabase = createClient(supabaseUrl, supabaseKey);
}

// Export a pool-like interface for compatibility
module.exports = {
  query: async (text, params) => {
    // Parse SQL to get table name (basic implementation)
    // This is a simplified adapter - you may need to enhance it
    console.log('Query:', text, params);
    throw new Error('Direct SQL queries not supported with Supabase. Use supabase client instead.');
  },
  supabase: supabase
};