#!/bin/bash 
set -euo pipefail

declare -A MODPACKS
MODPACKS["ATM_7_Server_0.4.29"]="https://mediafiles.forgecdn.net/files/3949/730/Server-Files-0.4.29.zip"

if [ -f .env ]; then 
    export $(cat .env | xargs)
fi

mkdir -p $BACKUP_DIR $MODPACK_DIR $SCRIPT_DIR
cp .env $MINECRAFT_DIR
cp -R ./scripts/* $SCRIPT_DIR
cp -uv ./modpacks/*.zip $MODPACK_DIR

cat cron.daily | crontab -

for key in ${!MODPACKS[@]}; do
    outputFile="${MODPACK_DIR}/${key}.zip"
    echo "Checking if $key exists ..."
    if [ ! -f $outputFile ]; then
        echo "Downloading modpack from: ${MODPACKS[${key}]} ..."
        curl ${MODPACKS[${key}]} --output $outputFile
        chown minecraft:docker $outputFile
    fi
done

docker-compose up -d --remove-orphans

cp -R ./configs/infrared/* $INFRARED_DIR