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

# ===== GIT COMMIT AND PUSH =====
echo "[INFO] Committing changes to Git..."
git add .
git commit -m "Auto commit and DB backup at $DATE"
git push origin main

# ===== DONE =====
echo "[INFO] Backup and commit completed."
