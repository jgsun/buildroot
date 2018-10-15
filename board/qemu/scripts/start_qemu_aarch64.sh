sudo /repo/work/qemu/aarch64-softmmu/qemu-system-aarch64 -M virt \
	-cpu cortex-a57 -nographic -smp 4 -m 512 \
	-kernel /repo/work/buildroot/output/images/Image \
	-append "root=/dev/ram0 console=ttyAMA0 kmemleak=on loglevel=8" \
	-netdev type=tap,ifname=tap0,id=eth0,script=/repo/work/buildroot/board/qemu/scripts/qemu-ifup_virbr0,queues=2 \
	-device virtio-net-pci,netdev=eth0,mac='00:00:00:01:00:01',vectors=6,mq=on \
#	dyndbg=\"file drivers/of/irq.c +p\"" \
#	-netdev type=tap,ifname=tap1,id=eth1,script=/repo/work/buildroot/board/qemu/scripts/qemu-ifup_virbr0,queues=2 \
#	-device virtio-net-pci,netdev=eth1,mac='00:00:00:01:00:02',vectors=6,mq=on \
