#!/bin/bash
cd /var/www/salesmate-ai

echo "=== Salesman data for 8484830022 ==="
sqlite3 -header -column local-database.db "SELECT * FROM salesmen WHERE phone LIKE '%8484830022%' LIMIT 1;"

echo -e "\n=== Visit count ==="
sqlite3 local-database.db "SELECT COUNT(*) as total_visits FROM visits WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11';"

echo -e "\n=== Customer count ==="
sqlite3 local-database.db "SELECT COUNT(*) as total_customers FROM customer_profiles_new WHERE tenant_id='aaaaaaaa-bbbb-cccc-dddd-000000000001';"

echo -e "\n=== Targets ==="
sqlite3 -header -column local-database.db "SELECT * FROM salesman_targets WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11' LIMIT 3;"

echo -e "\n=== Expenses ==="
sqlite3 local-database.db "SELECT COUNT(*) as total_expenses FROM salesman_expenses WHERE salesman_id='27a44053-3f43-4ba3-9213-2dae0870de11';"

echo -e "\n=== Sample customers ==="
sqlite3 -header -column local-database.db "SELECT id, business_name, phone, city FROM customer_profiles_new WHERE tenant_id='aaaaaaaa-bbbb-cccc-dddd-000000000001' LIMIT 5;"
