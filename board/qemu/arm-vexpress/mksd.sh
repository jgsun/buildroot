#!/bin/sh

dd if=/dev/zero of=sd.ext2 bs=1M count=8
mkfs.ext2 sd.ext2
mkdir tmpfs
sudo mount -t ext2 sd.ext2 tmpfs/ -o loop
sudo cp uImage vexpress-v2p-ca9.dtb tmpfs #将用uImage和dtb拷到此处
sudo umount tmpfs

