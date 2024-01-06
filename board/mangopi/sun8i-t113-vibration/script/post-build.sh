BOARD_DIR="$(dirname $0)"

rm $1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $1/etc/resolv.conf
echo "nameserver 4.2.2.4" >> $1/etc/resolv.conf

echo "none              /sys/kernel/debug               debugfs defaults        0       0" >> $1/etc/fstab

cp $BOARD_DIR/kernel.its $BINARIES_DIR/kernel.its
(cd $BINARIES_DIR; $HOST_DIR/bin/mkimage -f kernel.its kernel.itb; rm kernel.its)

echo "$BRD end"
