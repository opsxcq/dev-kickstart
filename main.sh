#!/bin/bash

if [ -z "$1" ]
then
    echo '[+] No iso image specified, using install.iso image by default'
    IMAGE='install.iso'
else
    echo '[+] Using the iso file '$1
    IMAGE='/iso/'$1
fi

echo '[+] Checking image file'
ls -lh $IMAGE

echo '[+] Starting libvirtd service'
service libvirtd start

echo '[+] Installing the operating system'
virt-install --name linux-build-test --ram 1024 --noreboot \
    --disk path=./disk.qcow2,size=10 \
    --vcpus 1 --os-type linux --os-variant generic --network bridge=virbr0,mac=52:54:00:7c:a1:64 \
    --nographics --console pty,target_type=serial \
    --initrd-inject=vm.ks --extra-args "ks=file:/vm.ks console=ttyS0,115200n8 serial" \
    --location=$IMAGE

echo '[+] Optimizing the disk image'
time qemu-img convert -c -O qcow2 disk.qcow2 disk-final.qcow2
mv disk-final.qcow2 disk.qcow2



bash
