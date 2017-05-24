#!/usr/bin/env bash

_usage() {
echo "\
Usage: transfer.sh [FILE]"
}
[[ $1 == "-h" || $1 == "--help" ]] && _usage && exit
[[ $# == 0 ]] && _usage && exit

file=$1
basefile=$(basename "$file" | tr -s '\\/|`;"?~!@#$^&*()<>[]{}'"'[:blank:]" _)

if tty -s; then 
    if [ ! -r $file ]; then
        echo "File $file doesn't exists." >&2
        exit 2
    fi
    
    if [ -d $file ]; then
        tarfile=$(mktemp -t transferXXX.tar)
        tar -chf $tarfile $file
        curl --progress-bar --upload-file "$tarfile" "https://transfer.sh/$basefile.tar"
        rm $tarfile
    else
        curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile"
    fi
else 
    curl --progress-bar --upload-file "-" "https://transfer.sh/$basefile"
fi
