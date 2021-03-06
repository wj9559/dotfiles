#!/usr/bin/env bash

URL="https://twitter.com"

if [[ $1 == "-i" || $1 == "--incognito" ]]; then
    chromium --incognito "${@:2}" --app="$URL" &> /dev/null &
else
    chromium "$@" --app="$URL" &> /dev/null &
fi
