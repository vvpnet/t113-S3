#!/bin/bash
set -e
OUTPUT="${@: -1}"
SPL="$OUTPUT/images/sunxi-spl.bin"
UBOOT="$OUTPUT/images/u-boot.img"
KERNEL="$OUTPUT/images/kernel.itb"
ROOTFS="$OUTPUT/images/rootfs.ubifs"
if test ! -e "$ROOTFS"; then
	echo "Usage: write-nand.sh -sukr OUTPUT_DIR"
	echo " -f formats the NAND"
	echo " -s writes sunxi-spl.bin"
	echo " -u writes u-boot.img"
	echo " -k writes kernel.itb"
	echo " -r writes rootfs.ubifs"
	exit 1
fi
UBI_ATTACHED=false
function ubiattach() {
	if ! $UBI_ATTACHED; then
		ssh root@t113 "ubiattach -p /dev/mtd1 || true"
	fi
	UBI_ATTACHED=true
}
while getopts ":fsukr" opt; do
	case ${opt} in
	f)
		echo "Formatting NAND"
		ssh root@t113 "ubidetach -p /dev/mtd1 || true"
		ssh root@t113 "echo Y > /sys/module/ubi/parameters/fm_autoconvert"
		ssh root@t113 "ubiformat /dev/mtd1 --yes"
		ubiattach
		ssh root@t113 "ubimkvol /dev/ubi0 --vol_id 0 -t static --name uboot --size 4MiB"
		ssh root@t113 "ubimkvol /dev/ubi0 --vol_id 1 -t static --name kernel --size 16MiB"
		ssh root@t113 "ubimkvol /dev/ubi0 --vol_id 2 --name root --size 128MiB"
		;;
	s)
		echo "Flashing SPL"
		scp "$SPL" root@t113:/root/spl.bin
		ssh root@t113 "flash_erase /dev/mtd0 0 0"
		ssh root@t113 "nandwrite -s 0x00000 -N -m /dev/mtd0 spl.bin || true"
		ssh root@t113 "nandwrite -s 0x20000 -N -m /dev/mtd0 spl.bin || true"
		ssh root@t113 "nandwrite -s 0x40000 -N -m /dev/mtd0 spl.bin || true"
		ssh root@t113 "nandwrite -s 0x60000 -N -m /dev/mtd0 spl.bin || true"
		;;
	u)
		echo "Flashing U-Boot"
		ubiattach
		cat "$UBOOT" | ssh root@t113 "ubiupdatevol /dev/ubi0_0 -s $(stat -c%s "$UBOOT") -"
		;;
	k)
		echo "Flashing kernel"
		ubiattach
		cat "$KERNEL" | ssh root@t113 "ubiupdatevol /dev/ubi0_1 -s $(stat -c%s "$KERNEL") -"
		;;
	r)
		echo "Flashing rootfs"
		ubiattach
		cat "$ROOTFS" | ssh root@t113 "ubiupdatevol /dev/ubi0_2 -s $(stat -c%s "$ROOTFS") -"
		;;
	?)
		echo "Invalid option: -${OPTARG}."
		exit 1
		;;
	esac
done
