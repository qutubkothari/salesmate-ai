#!/bin/bash
cd /var/www/salesmate-ai
find services/ -name "*.js" -type f -exec sed -i "s/from('conversations')/from('conversations_new')/g" {} \;
find services/ -name "*.js" -type f -exec sed -i "s/from('orders')/from('orders_new')/g" {} \;
find services/ -name "*.js" -type f -exec sed -i "s/from('customer_profiles')/from('customer_profiles_new')/g" {} \;
pm2 restart salesmate-ai
echo "All tables updated to _new suffix"
