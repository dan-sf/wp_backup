#!/bin/bash

#-------------------------------------------
# WP backup script: Maintained by Dan Fowler
# Website: dsfcode.com
# Version 1.0.0
#-------------------------------------------

# This script creates a compressed backup archive of the given directory and the given MySQL table

# Set your WP site and backup vars
DATE=$(date +"%Y-%m-%d-%H%M"); STORE=10;
SITE="site.com"; FILE="$SITE.$DATE.tar.gz"; TRANS='s;home/user_name;;';
BACKUP_DIR="/home/user_name/backups"; WP_DIR="/home/user_name/public_html/";

# MySQL database info
DB_USER="user_name"; DB_PASS="database_password";
DB_NAME="wordpress_db_name"; DB_FILE="site.com.$DATE.sql";

# MySQL dump and backup creation
mysqldump -u$DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/$DB_FILE;
tar -czf $BACKUP_DIR/$FILE --transform $TRANS $WP_DIR $BACKUP_DIR/$DB_FILE &> /dev/null;
rm $BACKUP_DIR/$DB_FILE;

# If backups exist only store $STORE backups at a time removing the oldest backup
if ls $BACKUP_DIR/$SITE.*.tar.gz &> /dev/null
then
     BNUM=`ls $BACKUP_DIR/$SITE.*.tar.gz | wc -l`;
     BRM=`ls $BACKUP_DIR/*.tar.gz | sort | head -1`;
     [[ $BNUM > $STORE ]] && rm $BRM;
fi

