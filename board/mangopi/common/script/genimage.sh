#!/usr/bin/env bash

BOARD_DIR="$(dirname $0)"

if test -e $BINARIES_DIR/rootfs.cpio.gz ; then
	cp $BOARD_DIR/kernel_initrd.its $BINARIES_DIR/kernel.its
else 
	cp $BOARD_DIR/kernel.its $BINARIES_DIR/kernel.its
fi

(cd $BINARIES_DIR; $HOST_DIR/bin/mkimage -f kernel.its kernel.itb; rm kernel.its)

if grep -Eq "^BR2_TARGET_AWBOOT_T113=y$" ${BR2_CONFIG}; then
	BRD="sun8i-t113"
	# install -m 0755 $BOARD_DIR/S04gpio $1/etc/init.d/
else
	BRD="unknown"
fi

if grep -Eq "^BR2_TARGET_AWBOOT_T113_BOOT_SDCARD=y$" ${BR2_CONFIG}; then
    DEV="mangopi-dual"
else
    DEV="unknown"
fi


die() {
  cat <<EOF >&2
Error: $@

Usage: ${0} -c GENIMAGE_CONFIG_FILE
EOF
  exit 1
}

# Parse arguments and put into argument list of the script
opts="$(getopt -n "${0##*/}" -o c: -- "$@")" || exit $?
eval set -- "$opts"

GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

while true ; do
	case "$1" in
	-c)
	  GENIMAGE_CFG="${2}";
	  shift 2 ;;
	--) # Discard all non-option parameters
	  shift 1;
	  break ;;
	*)
	  die "unknown option '${1}'" ;;
	esac
done

[ -n "${GENIMAGE_CFG}" ] || die "Missing argument"

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

genimage \
	--rootpath "${ROOTPATH_TMP}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"


# cp $BINARIES_DIR/sdcard.img $BINARIES_DIR/$BRD-$DEV/
