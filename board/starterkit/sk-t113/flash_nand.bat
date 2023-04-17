xfel spinand write 0 awboot-boot.bin

xfel spinand write 0x20000 sun8i-t113-sk.dtb
xfel spinand write 0x40000 zImage

xfel spinand erase 0x840000 0x77c0000
xfel spinand write 0x840000 rootfs.ubi
