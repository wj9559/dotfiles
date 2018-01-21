#!/usr/bin/env bash
#cut/join videos using ffmpeg without quality loss

_usage() {
echo "\
Usage: $0 c[ut] [start]  [second] FILE
  eg.  $0 cut   10       80       example.mp4
  eg.  $0 c     00:00:10 00:01:20 example.mp4

Usage: $0 j[oin] FILE_TYPE
  eg.  $0 join   avi
  eg.  $0 j      mp4"
}
[[ $1 == "-h" || $1 == "--help" ]] && _usage && exit
[[ $# == 0 ]] && _usage && exit

case "$1" in
c|cut)
    [[ -z $4 ]] && _usage && exit
    fname=${4%.*}
    ftype=${4##*.}
    ftime=$(echo $2_$3 | tr : -)
    ffmpeg -ss $2 -t $3 -safe -1 -i $4 -acodec copy -vcodec copy $fname.$ftime.$ftype -v fatal
    ;;

j|join)
    [[ -z $2 ]] && _usage && exit
    tmpfile=$(randomstr)
    for f in $(ls -v *.$2); do
        echo "file '$f'" >> $tmpfile
    done
    vi $tmpfile
    ffmpeg -f concat -safe -1 -i $tmpfile -acodec copy -vcodec copy output.$(date +%Y%m%d%H%M%S).$2 -v fatal
    rm $tmpfile
    ;;
*)
    echo "wrong arguments";;
esac
