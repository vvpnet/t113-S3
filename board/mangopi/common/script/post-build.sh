BOARD_DIR="$(dirname $0)"

rm $1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $1/etc/resolv.conf
echo "nameserver 4.2.2.4" >> $1/etc/resolv.conf

echo "none		/sys/kernel/debug		debugfs	defaults	0	0" >> $1/etc/fstab

if test -e $BINARIES_DIR/rootfs.cpio.xz ; then
	cp $BOARD_DIR/kernel_initrd.its $BINARIES_DIR/kernel.its
else 
	cp $BOARD_DIR/kernel.its $BINARIES_DIR/kernel.its
fi

echo "$BRD end"
