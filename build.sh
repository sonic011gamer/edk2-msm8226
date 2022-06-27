#!/bin/bash
# based on the instructions from edk2-platform
set -e
. build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -s -n 0 -a ARM -t GCC5 -p MSM8909Pkg/Devices/y560.dsc
gzip -c < workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd >MSM8909_UEFI.fd.gz
cat MSM8909_UEFI.fd.gz device_specific/huawei-y560.dtb > zImage-dtb
mkbootimg --kernel zImage-dtb --ramdisk workspace/empty --base 0x80000000 --pagesize 2048 -o uefi.img
