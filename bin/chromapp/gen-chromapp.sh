#!/usr/bin/env bash
# author: wujian(github.com/wj9559)

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_usage() {
echo "\
Usage: gen-chromapp.sh [filename] [URL] [protocol]
gen chromapp
  l, --list    display the chromapp list
  h, --help    display this help and exit"
exit 0
}

case $1 in
l|--list      ) ls $BASEDIR | grep -v gen-chromapp.sh && exit;;
""|h|--help   ) _usage;;
esac

[[ $# -lt 2 ]] && echo "gen-chromapp.sh --help" && exit 2

FILENAME=$BASEDIR/$1
URL=$2
Protocol=${3:-http}
[[ $Protocol == s ]] && Protocol=https

cat << !EOF! > $FILENAME
#!/usr/bin/env bash

Protocol=$Protocol
URL=$URL

if [[ \$1 == "-i" || \$1 == "--incognito" ]]; then
    chromium --incognito \${@:2} --app="\$Protocol://\$URL" &>/dev/null &
else
    chromium \$@ --app="\$Protocol://\$URL" &>/dev/null &
fi
!EOF!

chmod 755 $FILENAME
