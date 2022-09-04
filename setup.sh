#!/bin/bash

declare -A MODPACKS
MODPACKS["ATM_7_Server_0.4.29"]="https://mediafiles.forgecdn.net/files/3949/730/Server-Files-0.4.29.zip"

if [ -f .env ]; then 
    export $(cat .env | xargs)
fi

mkdir -p $MODPACK_DIR

for key in ${!MODPACKS[@]}; do
    outputFile="${MODPACK_DIR}/${key}.zip"
    echo "Checking if $key exists ..."
    if [ ! -f $outputFile ]; then
        echo "Downloading modpack from: ${MODPACKS[${key}]} ..."
        curl ${MODPACKS[${key}]} --output $outputFile
    fi
done

cp -R ./configs/infrared/* $INFRARED_DIR
docker-compose up -d