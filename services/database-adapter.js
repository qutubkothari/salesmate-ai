/**
 * Database Adapter
 * Unified interface for SQLite and PostgreSQL
 */

const { db } = require('./config');
const postgresService = require('./postgres-service');

class DatabaseAdapter {
  constructor() {
    this.usePostgres = process.env.USE_POSTGRES === 'true';
  }

  /**
   * Execute SELECT query
   */
  async select(query, params = []) {
    if (this.usePostgres && postgresService.isConnected) {
      const pgQuery = this.convertToPostgres(query);
      const result = await postgresService.query(pgQuery, params);
      return result.rows;
    }

    // SQLite fallback
    const stmt = db.prepare(query);
    return params.length > 0 ? stmt.all(...params) : stmt.all();
  }

  /**
   * Execute INSERT/UPDATE/DELETE query
   */
  async execute(query, params = []) {
    if (this.usePostgres && postgresService.isConnected) {
      const pgQuery = this.convertToPostgres(query);
      const result = await postgresService.query(pgQuery, params);
      return { changes: result.rowCount };
    }

    // SQLite fallback
    const stmt = db.prepare(query);
    const result = params.length > 0 ? stmt.run(...params) : stmt.run();
    return { changes: result.changes };
  }

  /**
   * Get single row
   */
  async get(query, params = []) {
    if (this.usePostgres && postgresService.isConnected) {
      const pgQuery = this.convertToPostgres(query);
      const result = await postgresService.query(pgQuery, params);
      return result.rows[0] || null;
    }

    // SQLite fallback
    const stmt = db.prepare(query);
    return params.length > 0 ? stmt.get(...params) : stmt.get();
  }

  /**
   * Convert SQLite query to PostgreSQL compatible
   */
  convertToPostgres(query) {
    let pgQuery = query;

    // Replace datetime('now') with NOW()
    pgQuery = pgQuery.replace(/datetime\('now'\)/gi, 'NOW()');
    
    // Replace AUTOINCREMENT with SERIAL
    pgQuery = pgQuery.replace(/AUTOINCREMENT/gi, 'SERIAL');
    
    // Replace ? placeholders with $1, $2, etc.
    let paramIndex = 1;
    pgQuery = pgQuery.replace(/\?/g, () => `$${paramIndex++}`);

    return pgQuery;
  }

  /**
   * Begin transaction
   */
  async beginTransaction() {
    if (this.usePostgres && postgresService.isConnected) {
      await postgresService.query('BEGIN');
    } else {
      db.prepare('BEGIN').run();
    }
  }

  /**
   * Commit transaction
   */
  async commit() {
    if (this.usePostgres && postgresService.isConnected) {
      await postgresService.query('COMMIT');
    } else {
      db.prepare('COMMIT').run();
    }
  }

  /**
   * Rollback transaction
   */
  async rollback() {
    if (this.usePostgres && postgresService.isConnected) {
      await postgresService.query('ROLLBACK');
    } else {
      db.prepare('ROLLBACK').run();
    }
  }
}

module.exports = new DatabaseAdapter();
