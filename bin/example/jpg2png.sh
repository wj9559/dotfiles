#!/bin/sh
for FROM in `ls -d1 *.png` ; do
	convert $FROM $FROM.png
done
