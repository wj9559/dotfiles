#!/usr/bin/env bash

beg_date=`date -d "$1" +%s`
end_date=`date -d "$2" +%s`

if [[ -z $2 ]]; then
    echo "\
Usage: $0 YYYYMMDD YYYYMMDD"
    exit
fi
if [[ ${beg_date} > ${end_date} ]]; then
    echo "\
The end_date < beg_date
Please input the right date
eg: $0 20140101 20140301"
    exit
fi

for (( i=$beg_date;i<=$end_date;i=i+86400)); do
    date -d @$i +%Y%m%d
done
