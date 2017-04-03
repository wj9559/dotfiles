#!/usr/bin/env bash
#cut/join videos using ffmpeg without quality loss
 
_usage() {
echo "\
Usage: $0 c[ut] [start]  [second] <File>
  eg.  $0 cut   10       80       example.mp4
  eg.  $0 c     00:00:10 00:01:20 example.mp4

Usage: $0 j[oin] <FileType>
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
    ffmpeg -ss $2 -t $3 -i $4 -acodec copy -vcodec copy $fname.$2-$3.$ftype;;

j|join)
    [[ -z $2 ]] && _usage && exit
    tmpfile=$(randomstr)
    for f in $(ls -v *.$2); do
        echo "file '$f'" >> $tmpfile
    done
    ffmpeg -f concat -i $tmpfile -acodec copy -vcodec copy output.$(date +%s).$2
    rm $tmpfile;;
*)
    echo "wrong arguments";;
esac
