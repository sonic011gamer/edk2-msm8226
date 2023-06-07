#!/bin/bash
# based on the instructions from edk2-platform
set -e
. build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -j$(nproc) -s -n 0 -a ARM -t GCC5 -p MSM8909Pkg/Devices/y560.dsc
cd BootShim
make UEFI_BASE=0x80200000 UEFI_SIZE=0x00100000
rm BootShim.elf
cd ..
cat BootShim/BootShim.bin workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd > workspace/bootpayload.bin
gzip -c < workspace/bootpayload.bin >MSM8909_UEFI.fd.gz
mkbootimg --kernel MSM8909_UEFI.fd.gz --kernel_offset 0x00008000 --dtb device_specific/saana.dtb --ramdisk workspace/empty --base 0x80000000 --pagesize 2048 --cmdline "" --output workspace/Y560.img