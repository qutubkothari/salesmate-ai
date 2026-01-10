require('dotenv').config();

// Re-export from services/config.js to maintain compatibility
// This file is legacy and some old code still imports from here
const config = require('../services/config');

// Export both db (for local SQLite) and supabase (for Supabase mode)
module.exports = {
  supabase: config.supabase,
  db: config.db,
  
  // Pool-like interface for compatibility (legacy)
  query: async (text, params) => {
    if (config.db) {
      // Local SQLite mode
      try {
        const stmt = config.db.prepare(text);
        return { rows: stmt.all(params) };
      } catch (error) {
        console.error('SQLite query error:', error);
        throw error;
      }
    } else {
      // Supabase mode
      console.log('Query:', text, params);
      throw new Error('Direct SQL queries not supported with Supabase. Use supabase client instead.');
    }
  }
};