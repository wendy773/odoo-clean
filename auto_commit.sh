#!/bin/bash
cd /opt/odoo/odoo

# Step 1: 拉取远程更新（确保在任何更改之前执行）
git pull --rebase origin 17.0

# Step 2: 添加所有变更
git add .

# Step 3: 提交（带时间戳）
git commit -m "Auto commit at $(date)"

# Step 4: 推送到远程
git push origin 17.0
