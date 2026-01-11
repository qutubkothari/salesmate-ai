# SAK-SMS Intelligence Testing Guide

## 🎯 Overview
This guide covers testing all SAK-SMS intelligence features now integrated into Salesmate.

---

## ✅ What's Been Implemented

### 🧠 Backend Services (Phases 1-3)
- **Database Schema**: 10 new tables + 12 new columns
- **Heat Scoring Service**: AI-powered urgency detection (5 levels)
- **Assignment Service**: 4 routing strategies with capacity management
- **REST APIs**: 4 complete endpoints (salesmen, tasks, calls, assignment)
- **Auto-Integration**: Every message → Heat analysis → Auto-assignment

### 🎨 Frontend UI (Phase 4)
- **Heat Badges**: 🔵 COLD → 🟡 WARM → 🟠 HOT → 🔴 VERY_HOT → 🔥 ON_FIRE
- **Heat Filter**: Dropdown to filter conversations by urgency
- **Team Tab**: Full CRUD for salesmen management
- **Tasks Tab**: Overdue/Upcoming/Completed task views
- **Calls Tab**: Call logging with inbound/outbound tracking

---

## 🧪 Testing Checklist

### 1. Heat Scoring Auto-Analysis

#### Test: Send Low-Urgency Message
```
Steps:
1. Open WhatsApp and message your business number
2. Send: "Hi, just browsing your products"
3. Check dashboard → Conversations tab
4. Verify: Conversation shows 🔵 COLD or 🟡 WARM badge

Expected:
- Heat level: COLD or WARM
- No triage escalation
- Badge appears in conversation list
```

#### Test: Send High-Urgency Message
```
Steps:
1. Send WhatsApp message: "URGENT! Need 50 units TODAY. Budget approved."
2. Refresh dashboard
3. Check conversation list

Expected:
- Heat level: 🔴 VERY_HOT or 🔥 ON_FIRE
- Auto-escalated to triage queue
- Heat badge shows red/fire emoji
```

#### Test: Heat Filter
```
Steps:
1. Go to Conversations tab
2. Click heat filter dropdown
3. Select "🔥 On Fire"
4. Verify only high-heat conversations shown

Expected:
- Filter works correctly
- Only ON_FIRE conversations displayed
- Count matches filter
```

---

### 2. Smart Assignment

#### Test: Auto-Assignment for New Conversation
```
Prerequisites:
- At least 1 active salesman added in Team tab

Steps:
1. Create new WhatsApp conversation (use different phone)
2. Send first message
3. Check conversation details
4. Check server logs for "[AUTO_ASSIGNMENT]"

Expected:
- Conversation assigned to salesman automatically
- Assignment shows in conversation card: "Assigned to: Salesman #X"
- Server log: "✅ Assigned to: [Name] (ROUND_ROBIN)"
```

#### Test: Assignment Strategy
```
Steps:
1. Go to Settings or API
2. GET /api/assignment/:tenantId/config
3. Verify current strategy (default: ROUND_ROBIN)

Expected:
- Config shows: { strategy: 'ROUND_ROBIN', auto_assign: true }
```

---

### 3. Team Management Tab

#### Test: Add New Salesman
```
Steps:
1. Go to dashboard → Team tab
2. Click "Add Salesman"
3. Fill in modal:
   - Name: "John Doe"
   - Email: "john@company.com"
   - Phone: "+919876543210"
   - Max Leads: 100
   - Product Skills: "Electronics, Furniture"
   - Language Skills: "English, Hindi"
   - Geographic Zone: "Mumbai"
4. Click "Add Salesman"

Expected:
- Success notification appears
- Salesman appears in team list
- Shows 0 active leads
- Status: Active (green badge)
```

#### Test: View Workload
```
Steps:
1. Assign some conversations to salesman
2. Go to Team tab
3. Check salesman's card

Expected:
- "Active Leads" count updates
- "Monthly Cap" shows max_leads_per_month
- Product/Language/Geographic skills displayed
```

#### Test: Remove Salesman
```
Steps:
1. Click "Remove" on a salesman
2. Confirm deletion

Expected:
- Salesman status changes to "Inactive" (soft delete)
- Still appears in list but grayed out
- Data preserved
```

---

### 4. Tasks Management Tab

#### Test: Create Task
```
Steps:
1. Go to dashboard → Tasks tab
2. Click "Add Task"
3. Fill in modal:
   - Title: "Follow up with hot lead"
   - Description: "Customer interested in bulk order"
   - Priority: "High"
   - Due Date: Tomorrow 10:00 AM
4. Click "Add Task"

Expected:
- Task appears in "Upcoming Tasks" section
- Priority badge shows orange "HIGH"
- Due date displayed correctly
```

#### Test: Complete Task
```
Steps:
1. Find task in list
2. Click green ✓ button

Expected:
- Task moves to "Completed" section
- Success notification
- No longer in upcoming/overdue
```

#### Test: Overdue Tasks
```
Steps:
1. Create task with due date in the past
2. Refresh Tasks tab

Expected:
- Task appears in "Overdue Tasks" section (red border)
- Red exclamation icon
- Sorted by most overdue first
```

---

### 5. Calls Logging Tab

#### Test: Log Inbound Call
```
Steps:
1. Go to dashboard → Calls tab
2. Click "Log Call"
3. Fill in modal:
   - Phone: "+919876543210"
   - Direction: "Inbound (Received)"
   - Outcome: "Interested"
   - Duration: 300 (seconds)
   - Notes: "Customer wants product demo"
4. Click "Log Call"

Expected:
- Call appears in call history table
- Direction shows "📥 INBOUND" (green badge)
- Duration: "5m 0s"
- Inbound count increases in stats
```

#### Test: Call Stats
```
Steps:
1. Log several calls (mix of inbound/outbound)
2. Check stats cards at top

Expected:
- Inbound count correct
- Outbound count correct
- Total duration sums correctly (in minutes)
```

---

### 6. API Endpoint Testing

#### Test: Get Heat Distribution
```bash
# PowerShell
$tenantId = "your-tenant-id"
Invoke-RestMethod -Uri "http://localhost:3000/api/assignment/$tenantId/heat/distribution"

Expected Response:
{
  "success": true,
  "distribution": {
    "COLD": 5,
    "WARM": 12,
    "HOT": 8,
    "VERY_HOT": 3,
    "ON_FIRE": 1
  }
}
```

#### Test: Filter Conversations by Heat
```bash
# Get all ON_FIRE conversations
Invoke-RestMethod -Uri "http://localhost:3000/api/assignment/$tenantId/heat/ON_FIRE"

Expected Response:
{
  "success": true,
  "conversations": [
    { "id": "...", "end_user_phone": "+91...", "heat": "ON_FIRE", ... }
  ]
}
```

#### Test: Manual Assignment
```bash
# Assign conversation to specific salesman
$body = @{ salesman_id = 1 } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/api/assignment/$tenantId/reassign/$conversationId" `
  -Method POST -ContentType "application/json" -Body $body

Expected Response:
{
  "success": true,
  "message": "Conversation reassigned",
  "salesman": { "id": 1, "name": "John Doe" }
}
```

---

## 🔍 Server Log Verification

### Heat Scoring Logs
```
[HEAT_SCORING] Updated heat: VERY_HOT (confidence: 0.85)
```

### Assignment Logs
```
[AUTO_ASSIGNMENT] ✅ Assigned to: John Doe (ROUND_ROBIN)
```

### How to Check Logs
```powershell
# If using PM2 on server
pm2 logs salesmate-ai --lines 100

# Local development
# Check terminal where `node index.js` is running
```

---

## 🐛 Troubleshooting

### Issue: Heat badges not showing
**Solution**: 
1. Clear browser cache
2. Refresh dashboard (Ctrl+F5)
3. Check database: `SELECT heat FROM conversations LIMIT 10;`
4. Verify columns exist: `PRAGMA table_info(conversations);`

### Issue: Auto-assignment not working
**Solution**:
1. Check assignment config: `SELECT * FROM assignment_config;`
2. Verify auto_assign = 1
3. Ensure at least 1 active salesman exists: `SELECT * FROM salesman WHERE active = 1;`
4. Check server logs for errors

### Issue: Tasks/Calls tabs empty
**Solution**:
1. Verify API endpoints working:
   ```powershell
   Invoke-RestMethod -Uri "http://localhost:3000/api/tasks/$tenantId"
   Invoke-RestMethod -Uri "http://localhost:3000/api/calls/$tenantId"
   ```
2. Check browser console for errors (F12)
3. Verify tenantId in session storage

### Issue: Modals not closing
**Solution**:
1. Check browser console for JavaScript errors
2. Verify modal has close button: `onclick="this.closest('.fixed').remove()"`
3. Refresh page if stuck

---

## ✨ Success Criteria

### All Tests Pass When:
- ✅ Heat badges appear on all conversations
- ✅ Heat filter successfully filters conversations
- ✅ New conversations auto-assigned to salesmen
- ✅ Team tab shows all salesmen with correct workload
- ✅ Tasks tab shows overdue/upcoming/completed correctly
- ✅ Calls tab logs calls with proper stats
- ✅ All modals open/close smoothly
- ✅ All API endpoints return correct data
- ✅ Server logs show [HEAT_SCORING] and [AUTO_ASSIGNMENT]
- ✅ Database has all 10 new tables populated

---

## 📊 Performance Benchmarks

### Expected Response Times
- Heat analysis per message: < 2 seconds (with AI)
- Assignment decision: < 100ms
- Dashboard page load: < 1 second
- API endpoint response: < 200ms

### Database Performance
```sql
-- Should return < 100ms
SELECT COUNT(*) FROM conversations WHERE heat = 'ON_FIRE';

-- Should return < 50ms
SELECT * FROM salesman WHERE active = 1;

-- Should return < 200ms
SELECT * FROM tasks WHERE status = 'PENDING' AND due_date < datetime('now');
```

---

## 🎉 Next Steps After Testing

1. **If all tests pass**:
   - Deploy to production server
   - Run `.\deploy-to-ec2.ps1` or manual deployment
   - Test on production environment
   - Monitor server logs for 24 hours

2. **If issues found**:
   - Document specific failures
   - Check database schema integrity
   - Review server error logs
   - Fix issues and re-test

3. **Training Team**:
   - Show team how to use heat badges
   - Demonstrate task management
   - Train on call logging
   - Explain assignment strategies

---

## 📝 Test Results Template

```
Date: ___________
Tester: ___________

Heat Scoring:
- Low urgency message: [ ] Pass [ ] Fail
- High urgency message: [ ] Pass [ ] Fail  
- Heat filter: [ ] Pass [ ] Fail

Assignment:
- Auto-assignment: [ ] Pass [ ] Fail
- Strategy verification: [ ] Pass [ ] Fail

Team Management:
- Add salesman: [ ] Pass [ ] Fail
- View workload: [ ] Pass [ ] Fail
- Remove salesman: [ ] Pass [ ] Fail

Tasks:
- Create task: [ ] Pass [ ] Fail
- Complete task: [ ] Pass [ ] Fail
- Overdue display: [ ] Pass [ ] Fail

Calls:
- Log call: [ ] Pass [ ] Fail
- Call stats: [ ] Pass [ ] Fail

Overall: [ ] All Pass [ ] Issues Found

Notes:
_________________________________
_________________________________
```

---

## 🚀 Production Deployment Checklist

Before deploying to production:

- [ ] All tests passed locally
- [ ] Database backup created
- [ ] Environment variables configured
- [ ] API keys valid (OpenAI/Gemini)
- [ ] HTTPS enabled
- [ ] PM2 configured for auto-restart
- [ ] Nginx reverse proxy configured
- [ ] Server logs being monitored
- [ ] Team trained on new features
- [ ] Rollback plan prepared

---

**Testing complete? Great!** 🎉

You now have a fully integrated SAK-SMS intelligence system in Salesmate with professional UI and complete automation!
