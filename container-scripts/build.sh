#!/bin/bash

set -e

export PATH="/usr/lib/ccache:$PATH"

VERSION="$1"

if [[ "$VERSION" == "" ]]; then
    echo "Please pass a version number parameter"
    exit 1
fi

echo "Checking for wine folder"
if [[ ! -d "/build/wine-git" ]]; then
    echo "Wine folder does not exist"
    exit 1
fi

echo "Creating folders"
mkdir -p /build/{data64,data32}
mkdir -p /build/{data64,data32}/{wine-cfg,build,ccache}
mkdir -p /build/data32/wine-tools

echo "Setting up ccache"
ccache -F 0 && ccache -M 0

ccache --set-config=cache_dir=/build/data64/ccache

echo "Building wine64"
cd /build/data64/wine-cfg

/build/wine-git/configure --enable-win64 --prefix=/build/data64/build

make -j${build_cores} install

cp -a /build/data64/build/* /build/wine-runner-$VERSION/

echo "64bit build complete"

ccache --set-config=cache_dir=/build/data32/ccache

echo "Building wine32-tools"
cd /build/data32/wine-tools

/build/wine-git/configure  --prefix=/build/data32/build/

make -j${build_cores} install

echo "Building wine32"
cd /build/data32/wine-cfg

/build/wine-git/configure --with-wine64=/build/data64/build/ --with-wine-tools=/build/data32/wine-tools --prefix=/build/data32/build/

make -j${build_cores} install

cp -a -n /build/data32/build/* /build/wine-runner-$VERSION/

echo "32bit build complete"
