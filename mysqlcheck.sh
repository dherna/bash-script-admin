#!/bin/sh

### MySQL Setup ###
MUSER="root"
MPASS=""
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
MYSQLCHECK="$(which mysqlcheck)"
GZIP="$(which gzip)"
LOGURL="/home/diego/temp"

### Start MySQL Backup ###
# Get all databases name
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
 $MYSQLCHECK -u $MUSER -h $MHOST -p$MPASS --auto-repair $db > $LOGURL/$db.log
done
