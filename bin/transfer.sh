#!/usr/bin/env bash

_usage() {
echo "\
Usage: transfer.sh /path/to/file"
}
[[ $1 == "-h" || $1 == "--help" ]] && _usage && exit
[[ $# == 0 ]] && _usage && exit

file=$1
basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 
tmpfile=$(mktemp -t transferXXX)

if tty -s; then 
    if [ ! -r $file ]; then
        echo "File $file doesn't exists." >&2
        exit 2
    fi
    
    if [ -d $file ]; then
        tarfile=$(mktemp -t transferXXX.tar)
        tar -chf $tarfile $file
        curl --progress-bar --upload-file "$tarfile" "https://transfer.sh/$basefile.tar" > $tmpfile
        rm $tarfile
    else
        curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" > $tmpfile
    fi
else 
    curl --progress-bar --upload-file "-" "https://transfer.sh/$basefile" > $tmpfile
fi

cat $tmpfile
rm $tmpfile
