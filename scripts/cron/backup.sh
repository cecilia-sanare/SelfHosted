#!/bin/bash
set -euo pipefail

if [ -f ../../.env ]; then 
    export $(cat ../../.env | xargs)
fi

SERVER=$1
SERVER_SHORTHAND=${SERVER/minecraft-/}
SERVER_BACKUP_DIR=${BACKUP_DIR}${SERVER_SHORTHAND}
SERVER_LATEST_DIR=${LATEST_DIR}${SERVER_SHORTHAND}

mkdir -p $SERVER_BACKUP_DIR

../tools/mcrcon.sh $SERVER "say Starting server backup, performance may degrade~"

../tools/mcrcon.sh $SERVER "save-off"

../tools/mcrcon.sh $SERVER "save-all"

tar -cvpzf $SERVER_BACKUP_DIR/server-$(date +%F-%H-%M).tar.gz $SERVER_LATEST_DIR

../tools/mcrcon.sh $SERVER "save-on"

../tools/mcrcon.sh $SERVER "say Backup complete!"

## Delete older backups

find $SERVER_BACKUP_DIR/ -type f -mtime +7 -name '*.gz' -delete