Run the emulation with:

  qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel output/images/zImage -dtb output/images/vexpress-v2p-ca9.dtb -drive file=output/images/rootfs.ext2,if=sd,format=raw -append "console=ttyAMA0,115200 root=/dev/mmcblk0" -serial stdio -net nic,model=lan9118 -net user

The login prompt will appear in the terminal that started Qemu. The
graphical window is the framebuffer.

If you want to emulate more cores change "-smp 1" to "-smp 2" for
dual-core or even "smp -4" for a quad-core configuration.

Tested with QEMU 2.12.0

//add for vexpress-fun
1. run linux
qemu-system-arm -M vexpress-a9 \
	-smp 2 -m 1024 \
	-kernel /repo/training/qemu/vexpress-a9/zImage \
	-dtb ./vexpress-v2p-ca9.dtb  \
	-append "console=ttyAMA0,115200 root=/dev/ram0" \
	-serial stdio \
	-net nic,model=lan9118 -net user

2.run uboot with network support
sudo qemu-system-arm -M vexpress-a9 -m 1024 -kernel /repo/training/qemu/vexpress-a9/u-boot -nographic -net nic,model=lan9118 -net tap,ifname=tap0,script=/repo/training/qemu/scripts/qemu-ifup_virbr0

2.1 boot linux by tftp
setenv bootargs 'root=/dev/ram0 console=ttyAMA0'
tftp 0x60003000 uImage
tftp 0x60900000 vexpress-v2p-ca9.dtb
bootm 0x60003000 - 60900000

3.run uboot with SD
sudo qemu-system-arm -M vexpress-a9 -m 1024 -kernel /repo/training/qemu/vexpress-a9/u-boot -nographic -net nic,model=lan9118 -net tap,ifname=tap0,script=/repo/training/qemu/scripts/qemu-ifup_virbr0 -sd /repo/training/qemu/vexpress-a9/sd.ext2

3.1 boot linux
ext2load mmc 0 0x60003000 uImage
ext2load mmc 0 0x60900000 vexpress-v2p-ca9.dtb
setenv bootargs 'root=/dev/ram0 console=ttyAMA0'
bootm 0x60003000 - 60900000

4.run uboot with flash
sudo qemu-system-arm -M vexpress-a9 -m 1024 -kernel /repo/training/qemu/vexpress-a9/u-boot -nographic -net nic,model=lan9118 -net tap,ifname=tap0,script=/repo/training/qemu/scripts/qemu-ifup_virbr0 -pflash /repo/training/qemu/vexpress-a9/flash.bin

4.1 boot linux
cp.b 0x0 0x60900000 0x100000
cp.b 0x100000 0x60003000 0x700000
setenv bootargs 'root=/dev/ram0 console=ttyAMA0'
bootm 0x60003000 - 60900000
