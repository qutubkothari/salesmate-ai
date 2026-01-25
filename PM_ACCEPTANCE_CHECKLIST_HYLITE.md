# Hylite FSM + AI Salesmate — PM Acceptance Checklist

## 1) Lead Capture Sources (All channels)
- [ ] Personal visit → lead created in FSM app with correct branch + salesman.
- [ ] Telephone call → lead created with source=phone, assigned properly.
- [ ] Email (company inbox) → lead created, auto/ manual assignment works.
- [ ] Email (salesman inbox) → auto-assign to that salesman.
- [ ] WhatsApp (company number) → lead created, assignment follows mode.
- [ ] WhatsApp (salesman number) → lead auto-assigned to that salesman.
- [ ] IndiaMart → lead created, assignment follows mode.

## 2) Assignment Modes
- [ ] Manual assignment works (manager selects salesman).
- [ ] Round-robin works with branch filtering.
- [ ] Min/Max per month respected per salesman.
- [ ] Assignment respects multi-branch mapping.
- [ ] Toggle on/off for auto-assign works instantly.

## 3) Smart Assignment & Suggestions
- [ ] AI scoring uses response time + follow-up + closure + repeat order metrics.
- [ ] System suggests increasing allocation for top performers.
- [ ] Suggestions appear in management dashboard with rationale.

## 4) AI Conversation + Lead Qualification
- [ ] Bot responds like a human with context.
- [ ] Product info retrieval works.
- [ ] Website scraping retrieval works.
- [ ] Document scraping retrieval works.
- [ ] Auto-qualify lead and save.
- [ ] Repeat customer is detected and linked to existing contact.

## 5) Salesman Dashboard
- [ ] Sees assigned leads, tasks, follow-ups, reminders.
- [ ] Can update status, notes, meetings.
- [ ] Sees progress metrics (leads, conversions, revenue).

## 6) Management Dashboard
- [ ] Full visibility of all salesmen.
- [ ] Lead assignment, source, branch filters.
- [ ] Bot settings (WhatsApp/Email/IndiaMart) visible and configurable.
- [ ] Reports for conversion, repeat orders, response SLAs.

## 7) Data Integrity & Tenant Isolation
- [ ] No cross-tenant data leakage.
- [ ] Salesman sees only assigned branch/tenant data.

## 8) Performance & Reliability
- [ ] WhatsApp Web session stable.
- [ ] Bot queue handles peak load.
- [ ] No duplicate leads on repeated messages.

## 9) Security & Audit
- [ ] Role-based access for admin vs salesman.
- [ ] Audit logs for assignments and edits.

---

### Required Test Evidence
- Screenshots per module
- API logs for lead creation + assignment
- Sample data for 7 salesmen across 8 branches

### Go/No-Go Criteria
- All items in sections 1–4 must pass before production rollout.
