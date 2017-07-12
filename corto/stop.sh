#!/usr/bin/env bash
#
# crawler.sh
#
# This script stops running software.
#
if [ -z "$1" ]; then
    if [ -z "$NAME" ]; then
        NAME=crawl;
    fi
else
    NAME=$1
fi

SESSION_INFO=$(tmux ls 2>/dev/null | grep $NAME)
if [[ ${SESSION_INFO} == ${NAME}* ]]; then
    
    tmux kill-session -t $NAME
fi

echo "Stopped"
