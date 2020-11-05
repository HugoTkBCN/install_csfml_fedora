#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

dnf install -y cmake make libX11-devel-1.6.12-1.fc33.x86_64 mesa-libGL-devel systemd-devel openal-soft-devel libvorbis-devel flac-devel libXrandr-devel SFML SFML-devel

yum -y install qt-devel cmake

SFML_SOURCE_URL="http://www.sfml-dev.org/files/SFML-2.5.1-sources.zip"
CSFML_SOURCE_URL="http://www.sfml-dev.org/files/CSFML-2.5-sources.zip"

CSFML_ZIP="CSFML.zip"
SFML_ZIP="SFML.zip"

echo "Download SFML Sources"
curl -Lo "$SFML_ZIP" $SFML_SOURCE_URL
echo "Download CSFML Sources"
curl -Lo "$CSFML_ZIP" $CSFML_SOURCE_URL

echo "Unzip SFML"
unzip -qq -o $SFML_ZIP
echo "Unzip CSFML"
unzip -qq -o $CSFML_ZIP

mv SFML-* SFML
mv CSFML-* CSFML

SFML_PATH="$(realpath SFML)"
CSFML_PATH="$(realpath CSFML)"

echo "SFML Compilation"
cd SFML
cmake .
make
cd ..

echo "CSFML Compilation"
cd CSFML
cmake -DSFML_ROOT="$SFML_PATH" -DSFML_INCLUDE_DIR="$SFML_PATH/include" -DCMAKE_MODULE_PATH="$SFML_PATH/cmake/Modules" .
LD_LIBRARY_PATH="$SFML_PATH/lib"
make
make install
cd ..

echo "/usr/local/lib/" > /etc/ld.so.conf.d/csfml.conf

# Update the Dynamic Linker Run Time Bindings
ldconfig

# Clean
rm -rf "$CSFML_ZIP" "$CSFML_PATH" "$SFML_ZIP" "$SFML_PATH"

echo "# GDM configuration storage
#
# See /usr/share/gdm/gdm.schemas for a list of available options.



[daemon]
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=false



# Enabling automatic login
#  AutomaticLoginEnable = true
#  AutomaticLogin = user1



# Enabling timed login
#  TimedLoginEnable = true
#  TimedLogin = user1
#  TimedLoginDelay = 10
DefaultSession=gnome-xorg.desktop
[security]



[xdmcp]



[chooser]



[debug]
# Uncomment the line below to turn on debugging
# More verbose logs
# Additionally lets the X server dump core if it crashes
#Enable=true" > /etc/gdm/custom.conf
