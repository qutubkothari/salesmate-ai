#!/bin/bash
# Quick fix for Hostinger - run this to deploy and restart

cd /var/www/salesmate-ai
git pull origin main
pm2 restart salesmate-ai
pm2 logs salesmate-ai --lines 20
