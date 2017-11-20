#!/usr/bin/env bash
# author: wujian(github.com/wj9559)

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_usage() {
echo "\
Usage: gen-chromapp.sh URL [filename]
Generate a script, runs URL in \"app mode\" with no browser toolbars.
  l, --list    display the chromapp list
  h, --help    display this help and exit"
exit 0
}

case $1 in
l |  --list ) ls $BASEDIR | grep -v $(basename "$0") && exit ;;
""|h|--help ) _usage ;;
esac

URL=$1
if [ $# -eq 1 ]; then
    FILENAME=$BASEDIR/$(echo "$URL" | sed s/^.*:\\/\\/// | tr / _ | head --bytes=255)
else
    FILENAME=$BASEDIR/$2
fi

cat > $FILENAME << EOF
#!/usr/bin/env bash

URL="$URL"

if [[ \$1 == "-i" || \$1 == "--incognito" ]]; then
    chromium --incognito "\${@:2}" --app="\$URL" &> /dev/null &
else
    chromium "\$@" --app="\$URL" &> /dev/null &
fi
EOF

chmod 755 $FILENAME
