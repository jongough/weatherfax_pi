#!/bin/sh  -xe

#
# Build the mingw artifacts inside the Fedora container
#
# Must be different for weatherfax due to portaudio and PVW32con.exe
set -xe

su -c "dnf install -q -y sudo dnf-plugins-core"
sudo dnf builddep -y mingw/fedora/opencpn-deps.spec
rm -rf build; mkdir build; cd build
wget https://downloads.sourceforge.net/project/opencpnplugins/opencpn_packaging_data/PVW32Con.exe
wget https://downloads.sourceforge.net/project/opencpnplugins/opencpn_packaging_data/portaudio-vc12.7z
7za e portaudio-vc12.7z -o../buildwin -y
mv PVW32Con.exe ../buildwin/.
cmake -DCMAKE_TOOLCHAIN_FILE=../mingw/fedora/toolchain.cmake ..
make -j2
make package

