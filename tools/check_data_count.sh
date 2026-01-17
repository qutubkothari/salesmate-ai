#!/bin/bash
cd /var/www/salesmate-ai
sqlite3 local-database.db <<EOF
SELECT 'Customers: ' || COUNT(*) FROM customer_profiles_new WHERE tenant_id='aaaaaaaa-bbbb-cccc-dddd-000000000001';
SELECT 'Visits: ' || COUNT(*) FROM visits WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11';
SELECT 'Targets: ' || COUNT(*) FROM salesman_targets WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11';
SELECT 'Expenses: ' || COUNT(*) FROM salesman_expenses WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11';
SELECT 'Attendance: ' || COUNT(*) FROM salesman_attendance WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11';
EOF
