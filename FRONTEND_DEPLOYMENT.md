# Frontend Integration and Deployment Guide

## Overview

This guide covers deploying the complete frontend integration for Salesmate with the following components:

1. **API Client SDK** (`clients/SalesateAPIClient.js`) - Reusable JavaScript client for all backend APIs
2. **Manager Dashboard** (`clients/ManagerDashboard.jsx`) - React components for web managers
3. **React Native Integration** (`REACT_NATIVE_INTEGRATION_GUIDE.md`) - Complete guide for FSM mobile app
4. **Web Dashboard** (`public/dashboard.html`) - Standalone HTML dashboard

## Quick Start

### 1. Copy API Client to Web Server

```bash
# Copy SalesateAPIClient.js to public folder
cp clients/SalesateAPIClient.js public/

# Now it's available at: https://your-domain/SalesateAPIClient.js
```

### 2. Access Web Dashboard

The HTML dashboard is ready to use immediately:

```
https://your-domain/dashboard.html
```

**Default Test Credentials:**
- Email: manager@test.com
- Password: test@123

### 3. Deploy with Node.js Server

If you want to serve with Node.js + Express:

```bash
# Add to your Node.js route handlers
app.use(express.static('public'));

# Restart PM2
pm2 restart sak-api
```

### 4. For React Integration (Optional)

If integrating with an existing React app:

```bash
npm install
npm install react react-dom recharts
```

Then import in your React app:

```jsx
import ManagerDashboard from './clients/ManagerDashboard.jsx';

export default function App() {
  return <ManagerDashboard />;
}
```

## Components Overview

### API Client (SalesateAPIClient.js)

**40+ methods for:**
- Authentication (login, logout, getCurrentUser)
- Visits (create, complete, update location, add images)
- Orders (create, confirm, update, search)
- Targets (get, record achievements)
- Dashboard (overview, analytics, alerts)
- Customers (search, create, update)

**Usage:**

```javascript
// Browser
<script src="https://your-domain/SalesateAPIClient.js"></script>
<script>
  const api = new SalesateAPIClient('https://api.saksolution.com', token);
  const visits = await api.getSalesmanVisits(salesmanId);
</script>

// Node.js
const SalesateAPIClient = require('./clients/SalesateAPIClient.js');
const api = new SalesateAPIClient('https://api.saksolution.com', token);
```

### Manager Dashboard (clients/ManagerDashboard.jsx)

**4 React Components:**

1. **TeamOverview**
   - Real-time team statistics
   - Top performers list
   - At-risk salesmen alerts
   - Team member table

2. **Analytics**
   - 7, 30, 90 day trends
   - Daily performance breakdown
   - Completion rates
   - Revenue analysis

3. **Alerts**
   - Critical alerts (targets missed)
   - Warning alerts (low performance)
   - Info alerts (achievements)

4. **ManagerDashboard**
   - Tab-based navigation
   - Auto-refresh every 60 seconds
   - Responsive layout

**Integration:**

```jsx
import React from 'react';
import ManagerDashboard from './clients/ManagerDashboard.jsx';
import SalesateAPIClient from './clients/SalesateAPIClient.js';

export default function App() {
  const token = localStorage.getItem('authToken');
  const api = new SalesateAPIClient('https://api.saksolution.com', token);
  
  return <ManagerDashboard api={api} />;
}
```

### Web Dashboard (dashboard.html)

**Standalone HTML + JavaScript dashboard**

Features:
- No build process required
- Login/logout
- Three tabs: Overview, Analytics, Alerts
- Real-time metrics
- Auto-refresh every 60 seconds
- Mobile responsive

**Deploy:**

```bash
# Copy to web server
cp public/dashboard.html /var/www/salesmate/

# Access at
https://your-domain/dashboard.html
```

### React Native Integration Guide

See `REACT_NATIVE_INTEGRATION_GUIDE.md` for:
- 6 complete code examples
- Authentication flow
- Visit creation and completion
- Order management
- Target tracking
- Offline support
- Error handling

## Deployment Steps

### Step 1: Verify Backend is Running

```bash
# SSH to Hostinger VPS
ssh root@72.62.192.228

# Check PM2 status
pm2 status
# Should show sak-api, sak-web, salesmate-ai, etc. running

# Check API health
curl https://salesmate.saksolution.com/api/health
# Should return 200 OK
```

### Step 2: Copy Frontend Files

```bash
# From your local machine
scp clients/SalesateAPIClient.js root@72.62.192.228:/var/www/salesmate/public/
scp public/dashboard.html root@72.62.192.228:/var/www/salesmate/public/

# Or from VPS directly
cd /var/www/salesmate
ls public/  # Verify files copied
```

### Step 3: Update Public Folder Permissions

```bash
# SSH to VPS
ssh root@72.62.192.228

# Set permissions
cd /var/www/salesmate
chmod -R 755 public/
```

### Step 4: Test Access

```bash
# From your browser
https://salesmate.saksolution.com/dashboard.html
```

**Should see:**
- Login form
- Ability to login with manager credentials
- Dashboard with statistics
- Three tabs: Overview, Analytics, Alerts

### Step 5: Optional - Set Up React Development Server

If you want a development server for React apps:

```bash
# Create a new React app
cd /var/www/salesmate
npx create-react-app dashboard-web

# Copy files
cp clients/SalesateAPIClient.js dashboard-web/public/
cp clients/ManagerDashboard.jsx dashboard-web/src/

# Install dependencies
cd dashboard-web
npm install react-dom recharts

# Start development
npm start
```

## Testing

### Test API Client

```javascript
// In browser console
const api = new SalesateAPIClient('https://salesmate.saksolution.com', 'your-token');

// Test authentication
await api.getCurrentUser();

// Test dashboard APIs
const overview = await api.getTeamOverview();
console.log(overview);

const analytics = await api.getAnalytics(7);
console.log(analytics);

const alerts = await api.getAlerts();
console.log(alerts);
```

### Test Dashboard

1. Open https://salesmate.saksolution.com/dashboard.html
2. Login with manager credentials
3. Verify all three tabs load data
4. Verify auto-refresh works (watch timestamp)
5. Verify logout works

### Test React Integration

```jsx
// In React component
const [data, setData] = useState(null);

useEffect(() => {
  const api = new SalesateAPIClient(API_URL, token);
  api.getTeamOverview().then(setData);
}, [token]);

return <ManagerDashboard data={data} />;
```

## Troubleshooting

### Dashboard Won't Load

**Check:**
1. Browser console for errors (F12 → Console)
2. API is running: `curl https://salesmate.saksolution.com/api/health`
3. API token is valid: Try login again
4. CORS is enabled on backend

**Fix:**
```javascript
// Ensure backend has CORS enabled
app.use(cors({
  origin: 'https://salesmate.saksolution.com',
  credentials: true
}));
```

### Login Fails

**Check:**
1. Credentials are correct (manager role required)
2. Manager record exists in database
3. API response in Network tab (F12 → Network)

**Debug:**
```bash
# Check database
sqlite3 local-database.db
SELECT * FROM users WHERE role = 'manager' LIMIT 5;
```

### API Client Methods Not Found

**Check:**
1. File is copied correctly: `ls -la public/SalesateAPIClient.js`
2. Script is loaded: Check Network tab (F12 → Network)
3. Correct API base URL is used

**Fix:**
```html
<!-- Make sure script tag is in HTML -->
<script src="https://salesmate.saksolution.com/SalesateAPIClient.js"></script>
```

### Analytics Data Empty

**Check:**
1. Date range includes data: Use `new Date()` to test
2. Migrations are applied: `pm2 logs sak-api`
3. Scheduler is running: Check PM2 logs

**Fix:**
```bash
# Check migrations
sqlite3 local-database.db ".schema daily_summaries"

# Restart scheduler
pm2 restart sak-api
```

## API Endpoints Reference

All endpoints require JWT authentication header:

```
Authorization: Bearer {token}
```

### Authentication
- `POST /api/auth/login` - Login (no auth required)
- `GET /api/auth/me` - Get current user
- `POST /api/auth/logout` - Logout

### Dashboard
- `GET /api/dashboard/overview` - Team overview
- `GET /api/dashboard/analytics?days=7` - Analytics by days (7, 30, 90)
- `GET /api/dashboard/alerts` - Active alerts
- `GET /api/dashboard/salesman/:id` - Specific salesman details
- `GET /api/dashboard/report` - Full report

### Visits
- `GET /api/visits/salesman/:id` - Get salesman visits
- `POST /api/visits` - Create visit
- `PUT /api/visits/:id` - Update visit
- `POST /api/visits/:id/complete` - Complete visit
- `POST /api/visits/:id/location` - Update location
- `POST /api/visits/:id/images` - Add images

### Orders
- `GET /api/orders/salesman/:id` - Salesman orders
- `POST /api/orders` - Create order
- `PUT /api/orders/:id` - Update order
- `POST /api/orders/:id/confirm` - Confirm order
- `GET /api/orders/customer/:id` - Customer orders

### Targets
- `GET /api/targets/salesman/:id` - Salesman targets
- `POST /api/targets/:id/visit` - Record visit achievement
- `POST /api/targets/:id/order` - Record order achievement

### Customers
- `GET /api/customers/search?q=name` - Search customers
- `GET /api/customers/:id` - Get customer
- `POST /api/customers` - Create customer
- `PUT /api/customers/:id` - Update customer

## Environment Configuration

### Production (Hostinger)

```javascript
const API_URL = 'https://salesmate.saksolution.com';
const REFRESH_INTERVAL = 60000; // 1 minute
```

### Development (Local)

```javascript
const API_URL = 'http://localhost:8055';
const REFRESH_INTERVAL = 10000; // 10 seconds for testing
```

### Testing (VPS)

```javascript
const API_URL = 'https://72.62.192.228:8055';
const REFRESH_INTERVAL = 30000; // 30 seconds
```

## Support

For issues or questions:

1. Check logs: `pm2 logs sak-api`
2. Check database: `sqlite3 local-database.db`
3. Test API directly: Use Postman or curl
4. Review documentation: See `REACT_NATIVE_INTEGRATION_GUIDE.md`

## Next Steps

1. ✅ Copy `SalesateAPIClient.js` to `/var/www/salesmate/public/`
2. ✅ Copy `dashboard.html` to `/var/www/salesmate/public/`
3. ✅ Test dashboard at `https://salesmate.saksolution.com/dashboard.html`
4. ✅ Integrate API client into your React apps
5. ✅ Share React Native guide with mobile team
6. Optional: Set up React development server for enhanced UI

All files are production-ready and tested with the current backend!
