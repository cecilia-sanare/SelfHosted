#!/bin/bash
set -euo pipefail

DEBUG=false

SERVER=$1
ESTIMATED_DOWNTIME=${2:-3}

countdown() {
    local seconds=$(($1 % 60))
    local minutes=$((($1 - $seconds) / 60))
    local message="say Stopping server in "

    if [[ $minutes > 0 || $seconds > 0 ]]
    then
        if [[ $minutes > 0 ]]
        then
            message+="$minutes minute\(s\)"

            if [[ $seconds > 0 ]]
            then
                message+=" and "
            fi
        fi

        if [[ $seconds > 0 ]]
        then
            message+="$seconds second\(s\)"
        fi
    else
        message="say Server shutting down..."
    fi

    echo $message
}

../tools/mcrcon.sh $SERVER "say Server will be shutting down momentarily and will be back up in approximately $ESTIMATED_DOWNTIME minutes~"
sleep 10
../tools/mcrcon.sh $SERVER $(countdown $(5 * 60))
sleep 60
../tools/mcrcon.sh $SERVER $(countdown $((4 * 60)))
sleep 60
../tools/mcrcon.sh $SERVER $(countdown $((3 * 60)))
sleep 60
../tools/mcrcon.sh $SERVER $(countdown $((2 * 60)))
sleep 60
../tools/mcrcon.sh $SERVER $(countdown $((1 * 60)))
sleep 30
../tools/mcrcon.sh $SERVER $(countdown 30)
sleep 20

for ((i=10; i >= 0; i--))
do
    ../tools/mcrcon.sh $SERVER $(countdown $i)
    sleep 1
done

docker restart $SERVER