#!/bin/bash

SERVER=$1
shift
COMMAND=$@

docker exec $SERVER mc-send-to-console "$@"