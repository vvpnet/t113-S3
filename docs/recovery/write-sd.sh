#!/bin/bash
set -e
if test ! -e $1/images/sdcard.img; then
	echo "Usage: write-sd.sh OUTPUT_DIR"
	exit 1
fi
ssh root@t113 "dd of=/dev/mmcblk0 bs=8M" < $1/images/sdcard.img
