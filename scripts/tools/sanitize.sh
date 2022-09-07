#!/bin/bash

URL=$1

if [[ $URL = https://mega.nz* ]]; then
    URL=${URL/\#/!}
    URL=${URL/file\//\#\!}
fi

echo $URL