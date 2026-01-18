/**
 * PostgreSQL Service
 * Optional PostgreSQL support with SQLite fallback
 */

const { Pool } = require('pg');

class PostgresService {
  constructor() {
    this.pool = null;
    this.isConnected = false;
    this.enabled = process.env.USE_POSTGRES === 'true';
  }

  /**
   * Initialize PostgreSQL connection pool
   */
  async connect() {
    if (!this.enabled) {
      console.log('[POSTGRES] PostgreSQL disabled, using SQLite');
      return;
    }

    try {
      this.pool = new Pool({
        host: process.env.POSTGRES_HOST || 'localhost',
        port: parseInt(process.env.POSTGRES_PORT || '5432'),
        database: process.env.POSTGRES_DB || 'salesmate',
        user: process.env.POSTGRES_USER || 'postgres',
        password: process.env.POSTGRES_PASSWORD,
        max: parseInt(process.env.POSTGRES_POOL_SIZE || '20'),
        idleTimeoutMillis: 30000,
        connectionTimeoutMillis: 2000,
      });

      // Test connection
      const client = await this.pool.connect();
      await client.query('SELECT NOW()');
      client.release();

      this.isConnected = true;
      console.log('✅ PostgreSQL connected');
    } catch (error) {
      console.error('[POSTGRES] Connection failed:', error.message);
      this.enabled = false;
      this.isConnected = false;
    }
  }

  /**
   * Execute query with automatic fallback
   */
  async query(text, params) {
    if (!this.enabled || !this.isConnected) {
      throw new Error('PostgreSQL not available');
    }

    try {
      const result = await this.pool.query(text, params);
      return result;
    } catch (error) {
      console.error('[POSTGRES] Query error:', error.message);
      throw error;
    }
  }

  /**
   * Get connection pool statistics
   */
  getStats() {
    if (!this.pool) {
      return { enabled: false };
    }

    return {
      enabled: this.enabled,
      connected: this.isConnected,
      totalCount: this.pool.totalCount,
      idleCount: this.pool.idleCount,
      waitingCount: this.pool.waitingCount
    };
  }

  /**
   * Close all connections
   */
  async disconnect() {
    if (this.pool) {
      await this.pool.end();
      this.isConnected = false;
      console.log('[POSTGRES] Disconnected');
    }
  }
}

module.exports = new PostgresService();
