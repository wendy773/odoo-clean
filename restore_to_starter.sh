#!/bin/bash

echo "[INFO] Restoring Odoo system to tag: starter..."

# 确保在脚本目录执行
cd "$(dirname "$0")"

# 清除所有未提交的更改
git reset --hard

# 清除未跟踪的文件（如自动生成文件、编译文件等）
git clean -fd

# 切换到 starter 标签
git checkout starter

echo "[SUCCESS] System has been restored to tag 'starter'."
