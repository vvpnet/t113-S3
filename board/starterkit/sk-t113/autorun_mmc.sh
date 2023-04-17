BRD=

if $(lsmod | grep -q g_mass_storage); then rmmod -f g_mass_storage; fi
dd if=/mnt/$BRD/sdcard.img of=/dev/mmcblk2 bs=1M && sync
reboot
