const { Client } = require('pg');

const client = new Client({
  connectionString: 'postgresql://postgres:Sak3998515253%23@db.taqkfimlrlkyjbutashe.supabase.co:5432/postgres',
  ssl: { rejectUnauthorized: false }
});

(async () => {
  await client.connect();
  const { rows } = await client.query(
    "select column_name, data_type from information_schema.columns where table_schema='public' and table_name='interactive_messages' order by ordinal_position"
  );
  console.log(rows);
  await client.end();
})();
