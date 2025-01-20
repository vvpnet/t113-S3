BOARD_DIR="$(dirname $0)"

rm $1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $1/etc/resolv.conf
echo "nameserver 4.2.2.4" >> $1/etc/resolv.conf

echo "none		/sys/kernel/debug		debugfs	defaults	0	0" >> $1/etc/fstab

VERSION=$(git describe --tags --always --dirty || echo "unknown")
BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat <<EOF > $TARGET_DIR/etc/os-release
ID=innova_firmware
NAME="InNova Firmware"
VERSION="$VERSION"
VERSION_ID=$VERSION
PRETTY_NAME="InNova Firmware $VERSION"
BUILD_DATE="$BUILD_TIME"
EOF

echo "os-release update version: $VERSION"
echo "$BRD end"
