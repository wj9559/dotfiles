#!/usr/bin/env bash

_usage() {
echo "\
Usage: transfer.sh FILE
       transfer.sh DIR
       cat FILE | gpg -ac -o- | transfer.sh LINK_NAME"
}
[[ $1 == "-h" || $1 == "--help" ]] && _usage && exit
[[ $# == 0 ]] && _usage && exit

file=$1
basefile=$(basename "$file" | tr -s '\\/|`;"?~!@#$^&*()<>[]{}'"'[:blank:]" _)
api=https://transfer.sh

if tty -s; then 
    if [ ! -r $file ]; then
        echo "File $file doesn't exists." >&2
        exit 2
    fi
    
    if [ -d $file ]; then
        tarfile=$(mktemp -t transferXXX.tar)
        basefile=$basefile.tar
        tar --create --dereference --file=$tarfile $file
        curl --progress-bar --upload-file "$tarfile" "$api/$basefile" | tee >(xclip &>/dev/null)
        rm $tarfile
    else
        curl --progress-bar --upload-file "$file" "$api/$basefile" | tee >(xclip &>/dev/null)
    fi
else 
    curl --progress-bar --upload-file "-" "$api/$basefile" | tee >(xclip &>/dev/null)
fi
