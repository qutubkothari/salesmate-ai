#!/bin/bash
cd /var/www/salesmate-ai
echo "Stopping app..."
pm2 stop salesmate-ai
echo "Backing up corrupt DB..."
cp local-database.db local-database.db.backup_$(date +%s)
echo "Attempting recovery..."
echo ".dump" | sqlite3 local-database.db > recover.sql
if [ -s recover.sql ]; then
    echo "Dumped SQL size: $(wc -c < recover.sql)"
    rm -f new-database.db
    # Filter out rollback statements which happen on error
    grep -v "ROLLBACK;" recover.sql | sqlite3 new-database.db
    
    echo "New DB Integrity Check:"
    STATUS=$(sqlite3 new-database.db "PRAGMA integrity_check;")
    echo "Status: $STATUS"
    
    if [ "$STATUS" == "ok" ]; then
        echo "Replacing corrupt DB with recovered version..."
        mv local-database.db local-database.db.corrupt_orig
        mv new-database.db local-database.db
        echo "Restarting PM2..."
        pm2 restart salesmate-ai
        echo "Recovery Complete."
    else
        echo "Recovery failed: New DB is not OK."
    fi
else
    echo "Dump failed (empty file)."
fi
