BOARD_DIR="$(dirname $0)"

rm $1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $1/etc/resolv.conf
echo "nameserver 4.2.2.4" >> $1/etc/resolv.conf

echo "none		/sys/kernel/debug		debugfs	defaults	0	0" >> $1/etc/fstab

echo "$BRD end"
