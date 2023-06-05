#!/bin/bash
set -e
sudo apt update
sudo apt install -y build-essential uuid-dev iasl git nasm crossbuild-essential-armel crossbuild-essential-armhf bc mkbootimg
curdir="$PWD"
cd ..
git clone https://github.com/tianocore/edk2.git -b edk2-stable202302 --recursive
git clone https://github.com/tianocore/edk2-platforms.git
cd "$curdir"
git submodule init
chmod +x firstrun.sh && ./firstrun.sh
chmod +x build.sh && ./build.sh
