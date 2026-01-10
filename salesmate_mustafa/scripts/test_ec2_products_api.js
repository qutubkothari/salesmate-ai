// Test the products/performance API endpoint
const tenantId = '9cdf48daeab97a66637d3cf9636e4967'; // Demo tenant on EC2

console.log('[TESTING PRODUCTS API ON EC2]');
console.log(`URL: http://13.126.234.92:8081/api/dashboard/products/performance/${tenantId}`);
console.log('\nFetching data...\n');

fetch(`http://13.126.234.92:8081/api/dashboard/products/performance/${tenantId}`)
    .then(response => response.json())
    .then(data => {
        console.log('SUCCESS:', data.success);
        console.log('Products returned:', data.products?.length || 0);
        
        if (data.products && data.products.length > 0) {
            console.log('\nFirst 3 products:');
            data.products.slice(0, 3).forEach(p => {
                console.log(`\n${p.name}:`);
                console.log(`  - Revenue: ₹${p.revenue || 0}`);
                console.log(`  - Total Quantity: ${p.totalQuantity || 0}`);
                console.log(`  - Total Orders: ${p.totalOrders || 0}`);
                console.log(`  - Price: ₹${p.price || 0}`);
            });
        } else {
            console.log('\nNO PRODUCTS RETURNED!');
        }
    })
    .catch(error => {
        console.error('ERROR:', error.message);
    });
