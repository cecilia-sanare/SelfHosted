#!/bin/bash 
set -euo pipefail

declare -A MODPACKS
MODPACKS["ATM_7_Server_0.4.29"]="https://mediafiles.forgecdn.net/files/3949/730/Server-Files-0.4.29.zip"
MODPACKS["TemmiesOriginsServerMods-0.1.1"]="https://mega.nz/file/sT9QQJbR#bPsoz3BDlOSmcDyeJ4fn7uynS-iu48tRZ6dbIbq9Rw4"
MODPACKS["TemmiesOriginsServerConfig-0.1.1"]="https://mega.nz/file/sLMSADQS#rdNv6NztJxcCif67fLTGSmxTefwuegnp_IA-oP0P4fI"

if [ -f .env ]; then 
    export $(cat .env | xargs)
fi

mkdir -p $BACKUP_DIR $MODPACK_DIR $SCRIPT_DIR
cp -u .env $MINECRAFT_DIR
cp -uR ./scripts/* $SCRIPT_DIR
chown -R minecraft:docker $MODPACK_DIR

cat cron.daily | crontab -

for key in ${!MODPACKS[@]}; do
    outputFile="${MODPACK_DIR}/${key}.zip"
    echo "Checking if $key exists ..."
    if [ ! -f $outputFile ]; then
        modpackUrl=$(./scripts/tools/sanitize.sh ${MODPACKS[${key}]})
        echo "Downloading modpack from: $modpackUrl ..."
        if [[ $modpackUrl == "https://mega.nz"* ]]; then
            (cd $MODPACK_DIR && megadl $modpackUrl)
        else
            curl $modpackUrl --output $outputFile
            chown minecraft:docker $outputFile
        fi
    fi
done

docker-compose up -d --remove-orphans

cp -uR ./configs/infrared/* $INFRARED_DIR