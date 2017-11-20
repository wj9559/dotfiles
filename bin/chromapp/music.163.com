#!/usr/bin/env bash

URL="https://music.163.com"

if [[ $1 == "-i" || $1 == "--incognito" ]]; then
    chromium --incognito "${@:2}" --app="$URL" &> /dev/null &
else
    chromium "$@" --app="$URL" &> /dev/null &
fi
