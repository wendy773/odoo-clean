#!/bin/bash

# ===== CONFIGURATION =====
DB_NAME="laboyglass"
DB_USER="laboyglassau"
BACKUP_DIR="db_backup"
DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_FILE="$BACKUP_DIR/odoo_${DATE}.sql"

# ===== CREATE BACKUP DIRECTORY IF NEEDED =====
mkdir -p $BACKUP_DIR

# ===== PERFORM DATABASE BACKUP =====
echo "[INFO] Backing up database..."
sudo -u postgres pg_dump $DB_NAME > $BACKUP_FILE

if [ $? -ne 0 ]; then
    echo "[ERROR] Database backup failed. Aborting."
    exit 1
fi

# ===== CLEAN OLD BACKUPS (> 7 days) =====
echo "[INFO] Cleaning old backups..."
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -delete

# ===== GIT COMMIT AND PUSH =====
echo "[INFO] Committing changes to Git..."
git status --short
git add .
git commit -m "Auto commit and DB backup at $DATE"
git push origin main

# ===== DONE =====
echo "[INFO] Backup and commit completed."
