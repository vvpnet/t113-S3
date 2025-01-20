#!/bin/bash
set -e
/data/jookia/projects/vlad/sunxi-tools/sunxi-fel uboot output_recovery/build/uboot-custom/u-boot-sunxi-with-spl.bin || true
fastboot stage output_recovery/images/kernel.itb
fastboot oem run:''
fastboot oem run:'bootm ${loadaddr}'
