const Database = require('better-sqlite3');

const dbPath = process.env.SQLITE_DB || 'local-database.db';
const table = process.env.TABLE || 'tenants';

const db = new Database(dbPath, { readonly: true });
const cols = db.prepare(`PRAGMA table_info(${table})`).all();

console.log(cols.map(c => c.name).join('\n'));
