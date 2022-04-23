#!/bin/bash
# based on the instructions from edk2-platform
set -e
. build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -s -n 0 -a ARM -t GCC5 -b RELEASE -p MSM8909Pkg/Devices/y560.dsc
gzip -c < workspace/Build/MSM8909Pkg/RELEASE_GCC5/FV/MSM8909PKG_UEFI.fd >uefi-release.img
cat device_specific/huawei-y560.dtb >>uefi-release.img
