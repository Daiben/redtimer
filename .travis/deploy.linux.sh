#!/bin/bash

if [ $# -lt 1 -o $# -gt 2 ]; then
  echo "Usage: $0 <output prefix> [<version for .deb and .rpm>]"
  exit 1
fi

export TRAVISDIR=$(cd "$(dirname "$0")"; pwd)
export ROOTDIR=$TRAVISDIR/..
export PREFIX=$1
export VERSION=$2

cd $ROOTDIR

##################### AppImage creation #####################

# Create a new dist folder
rm -rf dist
mkdir -p dist/opt/redtimer

# Include binary and dist files
cp gui/redtimer dist/opt/redtimer
cp gui/icons/clock_red.svg dist/opt/redtimer/redtimer.svg
cp .travis/redtimer.desktop dist/opt/redtimer

# Include SVG icon engine
# @todo Integrate into deploylinuxqt
mkdir -p dist/opt/redtimer/plugins/iconengines
cp -a /opt/qt57/plugins/iconengines/libqsvgicon.so dist/opt/redtimer/plugins/iconengines

# First run
.travis/linuxdeployqt.AppImage dist/opt/redtimer/redtimer -qmldir=gui/qml -verbose=2

# Second run, to include xcbglintegration
.travis/linuxdeployqt.AppImage dist/opt/redtimer/redtimer -qmldir=gui/qml -appimage -bundle-non-qt-libs -verbose=2

mv dist/opt/redtimer.AppImage $PREFIX.AppImage

##################### DEB/RPM creation #####################

if [ -z "$VERSION" ]; then
  export VERSION="0.1-pre0"
  echo "Building dummy version $VERSION"
fi

mkdir -p dist/usr/bin
mkdir -p dist/usr/share/applications
mkdir -p dist/usr/share/icons/hicolor/scalable/apps

ln -sf /opt/redtimer/redtimer dist/usr/bin/redtimer
mv dist/opt/redtimer/redtimer.desktop dist/usr/share/applications
mv dist/opt/redtimer/redtimer.svg dist/usr/share/icons/hicolor/scalable/apps
rm -f dist/opt/redtimer/default.png

fpm -s dir -t deb -n redtimer -v $VERSION -C dist -p $PREFIX.deb
fpm -s dir -t rpm -n redtimer -v $VERSION -C dist -p $PREFIX.rpm