#!/bin/bash

if [ -f ../../.env ]; then 
    export $(cat ../../.env | xargs)
fi

SERVER=$1
SERVER_SHORTHAND=${SERVER/minecraft-/}
SERVER_BACKUP_DIR=${BACKUP_DIR}${SERVER_SHORTHAND}
SERVER_LATEST_DIR=${LATEST_DIR}${SERVER_SHORTHAND}

mkdir -p $SERVER_BACKUP_DIR

../tools/mcrcon.sh $SERVER "save-off"

../tools/mcrcon.sh $SERVER "save-all"

tar -cvpzf $SERVER_BACKUP_DIR/server-$(date +%F-%H-%M).tar.gz $SERVER_LATEST_DIR

../tools/mcrcon.sh $SERVER "save-on"

## Delete older backups

find $SERVER_BACKUP_DIR/ -type f -mtime +7 -name '*.gz' -delete