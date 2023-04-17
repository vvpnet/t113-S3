BOARD_DIR="$(dirname $0)"

if grep -Eq "^BR2_TARGET_SK_NANO=y$" ${BR2_CONFIG}; then
	BRD="sun8i-t113-nano"
elif grep -Eq "^BR2_TARGET_SK_NANO_LV=y$" ${BR2_CONFIG}; then
	BRD="sun8i-t113-nano-lv"
	install -m 0755 $BOARD_DIR/S04gpio $1/etc/init.d/
else
	BRD="unknown"
fi

if grep -Eq "^BR2_TARGET_SK_BOOT_NAND=y$" ${BR2_CONFIG}; then
    DEV="nand"
elif grep -Eq "^BR2_TARGET_SK_BOOT_EMMC=y$" ${BR2_CONFIG}; then
    DEV="emmc"
elif grep -Eq "^BR2_TARGET_SK_BOOT_MMC0=y$" ${BR2_CONFIG}; then
    DEV="mmc0"
else
    DEV="unknown"
fi

SKDEV=$BRD-$DEV
rm $BINARIES_DIR/*.dtb
cp -f $BUILD_DIR/linux-custom/arch/arm/boot/dts/$SKDEV.dtb $BINARIES_DIR/
cp -f $BINARIES_DIR/$SKDEV.dtb $BINARIES_DIR/sun8i-t113-sk.dtb

AWBOOT=awboot-boot-$DEV
rm $BINARIES_DIR/*.bin
cp -f $BOARD_DIR/$AWBOOT.bin $BINARIES_DIR/
cp -f $BINARIES_DIR/$AWBOOT.bin $BINARIES_DIR/awboot-boot.bin

install -m 0644 $BOARD_DIR/profile.sh $1/etc/profile.d/
install -m 0644 $BOARD_DIR/interfaces $1/etc/network/
install -m 0644 $BOARD_DIR/inittab $1/etc/
install -m 0644 $BOARD_DIR/vsftpd.conf $1/etc/
install -m 0644 $BOARD_DIR/asound.conf $1/etc/
install -m 0755 $BOARD_DIR/S03sound $1/etc/init.d/

# install -m 0644 $BOARD_DIR/a2002011001-e02-8kHz.wav $1/root
test -d $1/etc/usbmount && install -m 0644 $BOARD_DIR/usbmount.conf $1/etc/usbmount/
test -d $1/usr/lib/qt && cp -r $BOARD_DIR/affine $1/root

rm $1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $1/etc/resolv.conf
echo "nameserver 4.2.2.4" >> $1/etc/resolv.conf

cp $BOARD_DIR/flash_nand.bat $BINARIES_DIR/
mkdir -p $BINARIES_DIR/bootusb-$BRD-$DEV
cp -r $BOARD_DIR/bootusb-t113/* $BINARIES_DIR/bootusb-$BRD-$DEV/
rm $BINARIES_DIR/bootusb-$BRD-$DEV/sun8i-t113-sk.dtb
cp -f $BINARIES_DIR/sun8i-t113-sk.dtb $BINARIES_DIR/bootusb-$BRD-$DEV/

mkdir -p $BINARIES_DIR/$BRD-$DEV
rm $BINARIES_DIR/$BRD-$DEV/*

if [ "$DEV" = "nand" ]; then
  cp $BOARD_DIR/autorun_nand.sh $BINARIES_DIR/$BRD-$DEV/autorun.sh
else
  cp $BOARD_DIR/autorun_mmc.sh $BINARIES_DIR/$BRD-$DEV/autorun.sh
fi

sed -i "s/BRD=/BRD=$BRD-$DEV/g" "$BINARIES_DIR/$BRD-$DEV/autorun.sh"

echo "sk end"
