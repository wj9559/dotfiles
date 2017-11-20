#!/usr/bin/env bash

Protocol=https
URL=plus.google.com

if [[ $1 == "-i" || $1 == "--incognito" ]]; then
    chromium --incognito "${@:2}" --app="$Protocol://$URL" &> /dev/null &
else
    chromium "$@" --app="$Protocol://$URL" &> /dev/null &
fi
