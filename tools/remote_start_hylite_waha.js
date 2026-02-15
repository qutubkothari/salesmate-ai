require('dotenv').config();
const axios = require('axios');

const TENANT_ID = '112f12b8-55e9-4de8-9fda-d58e37c75796';

async function main() {
  const baseUrl = process.env.SALES_MATE_BASE_URL || 'http://localhost:8055';

  const connectUrl = `${baseUrl}/api/whatsapp-web/connect`;
  const statusUrl = `${baseUrl}/api/whatsapp-web/status/${TENANT_ID}`;
  const qrUrl = `${baseUrl}/api/whatsapp-web/qr/${TENANT_ID}`;

  console.log('Base URL:', baseUrl);
  console.log('Tenant:', TENANT_ID);

  const connectRes = await axios.post(connectUrl, { tenantId: TENANT_ID }, { timeout: 15000 });
  console.log('Connect:', connectRes.data);

  const sleep = (ms) => new Promise(r => setTimeout(r, ms));

  for (let i = 0; i < 30; i++) {
    const [statusRes, qrRes] = await Promise.all([
      axios.get(statusUrl, { timeout: 15000 }).catch(e => ({ data: { error: e.message } })),
      axios.get(qrUrl, { timeout: 15000 }).catch(e => ({ data: { error: e.message } })),
    ]);

    const apiStatus = statusRes.data;
    const qrData = qrRes.data;
    const qrCode = qrData && qrData.qrCode;

    console.log(`Poll #${i + 1}: status=${apiStatus?.status || apiStatus?.error || 'unknown'} qrStatus=${qrData?.status || qrData?.error || 'unknown'} qrLen=${qrCode ? String(qrCode).length : 0}${qrData?.cached ? ' cached=1' : ''}`);

    if (qrCode && String(qrCode).length > 1000) {
      console.log('QR is ready to scan.');
      return;
    }

    await sleep(2000);
  }

  console.log('Timed out waiting for QR.');
}

main().then(() => process.exit(0)).catch((err) => {
  console.error('ERROR:', err.response?.data || err.message);
  process.exit(1);
});
