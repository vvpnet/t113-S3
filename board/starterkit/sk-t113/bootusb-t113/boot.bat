xfel ddr t113-s3
timeout 1

xfel write 0x30000 awboot-fel.bin
xfel write 0x41800000 sun8i-t113-sk.dtb
xfel write 0x45000000 zImage

xfel exec 0x30000
