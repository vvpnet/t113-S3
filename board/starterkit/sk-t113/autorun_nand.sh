BRD=

/usr/sbin/flashcp /mnt/$BRD/awboot-boot.bin /dev/mtd0
/usr/sbin/flashcp /mnt/$BRD/sun8i-t113-sk.dtb /dev/mtd1
/usr/sbin/flashcp /mnt/$BRD/zImage /dev/mtd2

/usr/sbin/flash_erase /dev/mtd3 0 0
/usr/sbin/flashcp /mnt/$BRD/rootfs.ubi /dev/mtd3

reboot
