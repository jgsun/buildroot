#!/sbin/sh

dd if=/dev/zero of=flash.bin bs=4096 count=2048 # sector size 4K£¬count 2K
dd if=vexpress-v2p-ca9.dtb of=flash.bin conv=notrunc bs=4096 # copy dtb at the beginning
dd if=uImage of=flash.bin conv=notrunc bs=4096 seek=256 # copy uImage at 1M from the beginning
