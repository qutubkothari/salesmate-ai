const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('\n📦 Available Products in Database:\n');
console.log('='.repeat(80));

const products = db.prepare('SELECT name, sku, price, stock_quantity, category, description FROM products').all();

if (products.length === 0) {
  console.log('No products found!');
} else {
  products.forEach((p, i) => {
    console.log(`\n${i + 1}. ${p.name}`);
    console.log(`   SKU: ${p.sku}`);
    console.log(`   Price: ₹${p.price}`);
    console.log(`   Stock: ${p.stock_quantity} units`);
    console.log(`   Category: ${p.category || 'N/A'}`);
    if (p.description) {
      console.log(`   Description: ${p.description.substring(0, 60)}...`);
    }
  });
  
  console.log('\n' + '='.repeat(80));
  console.log(`\nTotal: ${products.length} products\n`);
  
  console.log('🧪 Test Queries:');
  console.log('─'.repeat(80));
  products.forEach((p, i) => {
    if (i < 3) { // Show first 3
      console.log(`• "What is the price of ${p.name}?"`);
      console.log(`• "I want to order ${p.name}"`);
      console.log(`• "Show me ${p.category || p.name}"`);
    }
  });
  console.log('');
}

db.close();
