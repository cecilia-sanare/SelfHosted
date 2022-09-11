#!/bin/bash
set -euo pipefail

SERVER=$1
shift
COMMAND=$@

if [ "$(docker ps -aq -f status=running -f name=$SERVER)" ]; then
    docker exec $SERVER mc-send-to-console "$@"
fi