#!/bin/bash
set -euo pipefail

SERVER=$1
shift
COMMAND=$@

docker exec $SERVER mc-send-to-console "$@"