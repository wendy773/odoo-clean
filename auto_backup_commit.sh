#!/bin/bash

# 自动备份和提交脚本（适用于 Docker 部署）

echo "[INFO] Backing up database..."

mkdir -p db_backup
docker exec odoo-db pg_dump -U odoo laboyglass > db_backup/odoo_2025-08-06_15-05.sql

if [ $? -ne 0 ]; then
    echo "[ERROR] Database backup failed. Aborting."
    exit 1
fi

echo "[INFO] Cleaning old backups (keep 5)..."
ls -tp db_backup/*.sql | grep -v '/$' | tail -n +6 | xargs -I {} rm -- {} 2>/dev/null

echo "[INFO] Committing changes to Git..."
git add .
git commit -m "Auto commit and DB backup at 2025-08-06_15-05"
git push origin main

echo "[INFO] Backup and commit completed."
