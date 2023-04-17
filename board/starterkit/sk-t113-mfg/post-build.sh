BOARD_DIR="$(dirname $0)"

install -m 0644 $BOARD_DIR/mdev.conf $1/etc/
install -m 0775 $BOARD_DIR/auto_mount $1/bin/
install -m 0755 $BOARD_DIR/S10mdev $1/etc/init.d/
rm -f $1/etc/init.d/S40network
rm -f $1/etc/init.d/S20urandom
rm -f $1/etc/init.d/S01syslogd
rm -f $1/etc/init.d/S02klogd
rm -f $1/etc/init.d/S02sysctl 

cp $BOARD_DIR/awboot-fel.bin $BINARIES_DIR/
cp $BOARD_DIR/boot.bat $BINARIES_DIR/
cp $BOARD_DIR/boot.sh $BINARIES_DIR/
