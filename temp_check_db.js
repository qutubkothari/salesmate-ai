const Database = require('better-sqlite3');
const db = new Database('local-database.db');

try {
    const tenants = db.prepare("SELECT id, name FROM tenants WHERE name LIKE '%Hylite%'").all();
    console.log('--- Hylite Tenants ---');
    console.table(tenants);

    if (tenants.length > 0) {
        const tenantId = tenants[0].id;
        const connections = db.prepare("SELECT * FROM whatsapp_connections WHERE tenant_id = ?").all(tenantId);
        console.log('--- Hylite Connections ---');
        console.table(connections);
    } else {
        console.log('No Hylite tenant found.');
    }

    console.log('--- All Connections ---');
    console.table(db.prepare("SELECT tenant_id, session_name, status FROM whatsapp_connections").all());

} catch (err) {
    console.error(err);
}
