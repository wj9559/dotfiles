#!/usr/bin/env bash
[[ ${0#*/} == ${BASH_SOURCE[0]##*/} ]] && echo "please \"source\" this script, like \"source setClasspath.sh\""
export CLASSPATH=$CLASSPATH:$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" && pwd)
