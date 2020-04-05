#!/bin/bash

# crontab
# run every hour
# 0 * * * * <path to this script>

THEHOUR=$(date +%H)

mkdir -p ~/.minetest-backup/.tmp

rsync -avzh --delete ~/.minetest/* ~/.minetest-backup/.tmp/

tar -czf ~/.minetest-backup/minetest-$THEHOUR.tar.gz -C ~/.minetest-backup/.tmp .
