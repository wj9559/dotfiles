#!/usr/bin/env bash

# detail="http://www.eyepetizer.net/detail.html?vid=$id"
# day_date_number=$(echo "($(date --date=2017$1 +%s) + 32400) * 1000" | bc)
# night_date_number=$(echo "($(date --date=2017$1 +%s) + 75600) * 1000" | bc)
# apiUrl="http://baobab.kaiyanapp.com/api/v4/tabs/selected?date=$date_number"

_usage() {
echo "\
Usage: eyepetizer.sh [OPTION]
download or directly play the eyepetizer selected videos.
  download      download video
  play          Directly play the video
  debug         output video id.

  -h, --help    display this help and exit"
}
[[ $1 == "-h" || $1 == "--help" ]] && _usage && exit

checkfile="$HOME/videos/eyepetizer.list"
apiUrl="http://baobab.kaiyanapp.com/api/v4/tabs/selected"
tmpdir="$HOME/Desktop/eyepetizer"
PLAYER=mpv

_download(){
    wget --continue --quiet "$1" -O $tmpdir/$(echo "$1" | cut -d= -f2 | cut -d\& -f1).mp4
}
_play(){
    $PLAYER "$1" &>/dev/null
}
_debug(){
    echo "$1"
}

_selected(){
    for id in $(curl -s "$apiUrl" | jq '.itemList[] | select(.type == "video").data.id'); do
        if ! grep -qw $id $checkfile; then
            idList+="$id "
        fi
    done
}
_geturl(){
    echo "http://baobab.kaiyanapp.com/api/v1/playUrl?vid=$1&editionType=default&source=ucloud"
}

_selected
for id in $idList; do
    _${1:-download} "$(_geturl $id)"
    if [[ $1 != debug && $? == 0 ]]; then
        echo $id >> $checkfile
    fi
done

notify-send --app-name=eyepetizer.sh "over"
