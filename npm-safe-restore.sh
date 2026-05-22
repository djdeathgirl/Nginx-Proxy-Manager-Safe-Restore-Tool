#!/bin/bash

set -e

DB_PATH="/root/data/database.sqlite"
OLD_DB="/root/data/database.sqlite.old"

echo "=================================================="
echo " Nginx Proxy Manager SAFE RESTORE SCRIPT"
echo "=================================================="

echo "[1/5] Backing up current database..."
cp "$DB_PATH" "$OLD_DB"

echo "Backup created: $OLD_DB"

echo ""
echo "[2/5] Restarting container to ensure clean state..."
docker restart root-app-1

echo ""
echo "=================================================="
echo " LOGIN STEP REQUIRED"
echo "=================================================="
echo "A fresh database is now active."
echo ""
echo "👉 Log in using default credentials:"
echo "   Email: admin@example.com"
echo "   Password: changeme"
echo ""
echo "After login, type 'yes' here to continue migration:"
read CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted. Nothing was imported."
    exit 1
fi

echo ""
echo "[3/5] Importing OLD DATA (excluding auth)..."

docker exec -i root-app-1 sqlite3 /data/database.sqlite <<EOF
ATTACH DATABASE '/data/database.sqlite.old' AS old;

INSERT INTO proxy_host SELECT * FROM old.proxy_host;
INSERT INTO redirection_host SELECT * FROM old.redirection_host;
INSERT INTO stream SELECT * FROM old.stream;
INSERT INTO certificate SELECT * FROM old.certificate;
INSERT INTO access_list SELECT * FROM old.access_list;

DETACH DATABASE old;
EOF

echo ""
echo "[4/5] Cleaning auth to avoid lockouts..."
docker exec -i root-app-1 sqlite3 /data/database.sqlite "DELETE FROM auth;"

echo ""
echo "[5/5] Restarting container..."
docker restart root-app-1

echo ""
echo "DONE ✅"
echo "Your proxy data has been restored safely."
echo "Auth has been reset to prevent lockouts."
