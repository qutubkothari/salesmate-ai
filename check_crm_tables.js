const { Client } = require('pg');

const client = new Client({
  connectionString: 'postgresql://postgres:Sak3998515253%23@db.taqkfimlrlkyjbutashe.supabase.co:5432/postgres',
  ssl: { rejectUnauthorized: false }
});

(async () => {
  await client.connect();
  const tables = await client.query(
    "select table_name from information_schema.tables where table_schema='public' and table_name like 'crm_%' order by table_name"
  );
  console.log('CRM tables:', tables.rows.map(r => r.table_name));
  const users = await client.query('select count(*)::int as count from crm_users');
  console.log('crm_users count:', users.rows[0].count);
  await client.end();
})();
