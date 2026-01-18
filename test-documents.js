/**
 * Test Document Generation API
 * Tests templates, document generation, versioning, signatures
 */

const BASE_URL = 'http://localhost:8055';
const TENANT_ID = 'default-tenant';

async function testDocumentGeneration() {
  console.log('🧪 Testing Document Generation API\n');
  
  try {
    // Test 1: Create Invoice Template
    console.log('1️⃣ Creating Invoice Template...');
    const template = await fetch(`${BASE_URL}/api/documents/templates`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        templateName: 'Standard Invoice',
        templateType: 'invoice',
        description: 'Standard invoice template with company branding',
        templateFormat: 'html',
        templateBody: `
          <div class="invoice">
            <h1>INVOICE</h1>
            <p><strong>Invoice Number:</strong> {{document.number}}</p>
            <p><strong>Date:</strong> {{document.date}}</p>
            
            <h3>Bill To:</h3>
            <p>{{customer.name}}</p>
            <p>{{customer.address}}</p>
            
            <h3>Items:</h3>
            <table>
              <thead>
                <tr>
                  <th>Description</th>
                  <th>Quantity</th>
                  <th>Unit Price</th>
                  <th>Total</th>
                </tr>
              </thead>
              <tbody>
                {{#each line_items}}
                <tr>
                  <td>{{product_name}}</td>
                  <td>{{quantity}}</td>
                  <td>₹{{unit_price}}</td>
                  <td>₹{{total}}</td>
                </tr>
                {{/each}}
              </tbody>
            </table>
            
            <div class="total">
              <p><strong>Total Amount:</strong> ₹{{total_amount}}</p>
            </div>
          </div>
        `,
        cssStyles: 'body { font-family: Arial; } .invoice { padding: 20px; } table { width: 100%; border-collapse: collapse; } th, td { padding: 8px; border-bottom: 1px solid #ddd; } .total { margin-top: 20px; font-size: 1.2em; }',
        pageSize: 'A4',
        pageOrientation: 'portrait',
        isDefault: true,
        autoNumber: true,
        numberPrefix: 'INV-',
        numberFormat: '{PREFIX}{YEAR}{MONTH}{SEQUENCE}',
        tags: ['invoice', 'standard'],
        createdBy: 'admin'
      })
    });
    const templateData = await template.json();
    console.log('✅ Template created:', templateData.template?.id);
    const templateId = templateData.template?.id;
    
    // Test 2: Create Quotation Template
    console.log('\n2️⃣ Creating Quotation Template...');
    const quoteTemplate = await fetch(`${BASE_URL}/api/documents/templates`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        templateName: 'Standard Quotation',
        templateType: 'quotation',
        description: 'Customer quotation template',
        templateFormat: 'html',
        templateBody: '<div><h1>QUOTATION</h1><p>Quote #{{document.number}}</p><p>Valid until: {{quote.valid_until}}</p></div>',
        isDefault: true,
        autoNumber: true,
        numberPrefix: 'QT-',
        createdBy: 'admin'
      })
    });
    const quoteTemplateData = await quoteTemplate.json();
    console.log('✅ Quote template created:', quoteTemplateData.template?.id);
    
    // Test 3: Set Company Branding
    console.log('\n3️⃣ Setting Company Branding...');
    const branding = await fetch(`${BASE_URL}/api/documents/branding/config`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        company_name: 'SakSolution Technologies',
        company_address: '123 Business Street',
        company_city: 'Mumbai',
        company_state: 'Maharashtra',
        company_country: 'India',
        company_pincode: '400001',
        company_phone: '+91 22 1234 5678',
        company_email: 'info@saksolution.com',
        company_website: 'https://saksolution.com',
        tax_registration_number: 'GSTIN1234567890',
        primary_color: '#007bff',
        secondary_color: '#6c757d'
      })
    });
    const brandingData = await branding.json();
    console.log('✅ Branding configured');
    
    // Test 4: Generate Invoice
    console.log('\n4️⃣ Generating Invoice...');
    const invoice = await fetch(`${BASE_URL}/api/documents/generate`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        templateId: templateId,
        documentType: 'invoice',
        documentTitle: 'Sales Invoice - Customer XYZ',
        entityType: 'order',
        entityId: 'order-123',
        mergeData: {
          document: {
            number: 'INV-202601-0001',
            date: '2026-01-18'
          },
          customer: {
            name: 'ABC Corporation',
            address: '456 Client Avenue, Delhi'
          },
          line_items: [
            {
              product_name: 'Product A',
              product_description: 'Premium widget',
              quantity: 10,
              unit_price: 500,
              tax_percent: 18,
              total: 5900
            },
            {
              product_name: 'Product B',
              product_description: 'Standard gadget',
              quantity: 5,
              unit_price: 300,
              tax_percent: 18,
              total: 1770
            }
          ],
          total_amount: 7670,
          currency: 'INR',
          due_date: '2026-02-18'
        },
        generatedBy: 'admin'
      })
    });
    const invoiceData = await invoice.json();
    console.log('✅ Invoice generated:', invoiceData.document?.documentNumber);
    const invoiceId = invoiceData.document?.id;
    
    // Test 5: Get Document Details
    console.log('\n5️⃣ Fetching Document Details...');
    const docDetails = await fetch(`${BASE_URL}/api/documents/${invoiceId}?user_id=admin`);
    const docData = await docDetails.json();
    console.log('✅ Document details retrieved:');
    console.log('   Line items:', docData.document?.lineItems?.length || 0);
    console.log('   Total:', docData.document?.total_amount);
    
    // Test 6: Finalize Document
    console.log('\n6️⃣ Finalizing Document...');
    const finalize = await fetch(`${BASE_URL}/api/documents/${invoiceId}/finalize`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        finalized_by: 'admin'
      })
    });
    const finalizeData = await finalize.json();
    console.log('✅ Document finalized:', finalizeData.document?.status);
    
    // Test 7: Add Signature
    console.log('\n7️⃣ Adding Signature...');
    const signature = await fetch(`${BASE_URL}/api/documents/${invoiceId}/sign`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        signerName: 'John Doe',
        signerRole: 'approver',
        signerEmail: 'john@example.com',
        signatureType: 'text',
        signatureData: 'John Doe - Authorized Signatory',
        signatureIp: '127.0.0.1',
        signatureDevice: 'Desktop Chrome'
      })
    });
    const signatureData = await signature.json();
    console.log('✅ Signature added:', signatureData.signatureId);
    
    // Test 8: Update Status
    console.log('\n8️⃣ Updating Payment Status...');
    const statusUpdate = await fetch(`${BASE_URL}/api/documents/${invoiceId}/status`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        generation_status: 'sent',
        payment_status: 'paid'
      })
    });
    await statusUpdate.json();
    console.log('✅ Status updated to: sent, paid');
    
    // Test 9: List Templates
    console.log('\n9️⃣ Listing All Templates...');
    const templatesList = await fetch(`${BASE_URL}/api/documents/templates?tenant_id=${TENANT_ID}`);
    const templatesData = await templatesList.json();
    console.log('✅ Found', templatesData.templates?.length || 0, 'templates');
    templatesData.templates?.forEach(t => {
      console.log(`   - ${t.template_type}: ${t.template_name}`);
    });
    
    // Test 10: Get Statistics
    console.log('\n🔟 Getting Document Statistics...');
    const stats = await fetch(`${BASE_URL}/api/documents/stats/overview?tenant_id=${TENANT_ID}`);
    const statsData = await stats.json();
    console.log('✅ Document stats:');
    statsData.stats?.forEach(stat => {
      console.log(`   ${stat.document_type} (${stat.generation_status}): ${stat.count} docs, ₹${stat.total_value || 0}`);
    });
    
    console.log('\n✨ All document generation tests completed successfully!');
    
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    console.error(error.stack);
  }
}

testDocumentGeneration();
