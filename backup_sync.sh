#!/bin/bash

#------------------------------------------------
# WP backup sync script: Maintained by Dan Fowler
# Website: dsfcode.com
# Version 1.0.0
#------------------------------------------------

USER="user_name"; DOMAIN="site.com";
L_DIR="/Users/user_name/Path/to/backup/";
S_DIR="/home/user_name/backups/site.com.*.tar.gz";

# Get the most recent backup
BAKUP=`ssh -p 2222 $USER@$DOMAIN "ls $S_DIR" | sort | tail -1`;

# Sync the backup locally
rsync -ae 'ssh -p 2222' $USER@$DOMAIN:$BAKUP $L_DIR;

