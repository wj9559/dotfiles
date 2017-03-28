#!/usr/bin/env bash

_usage(){
echo "Usage: transfer.sh /path/to/file"
}
[[ $# == 0 || $1 == "-h" || $1 == "--help" ]] && _usage && exit

file=$1
tmpfile=$(mktemp -t transferXXX)

if tty -s; then 
    basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 
    if [ ! -e $file ]; then
        echo "File $file doesn't exists."
        return 1
    fi
    
    if [ -d $file ]; then
        zipfile=$( mktemp -t transferXXX.zip )
        cd $(dirname $file) && zip -r -q - $(basename $file) > $zipfile
        curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" > $tmpfile
        rm -f $zipfile
    else
        curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" > $tmpfile
    fi
else 
    curl --progress-bar --upload-file "-" "https://transfer.sh/$file" > $tmpfile
fi

cat $tmpfile
rm -f $tmpfile
