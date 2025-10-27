#!/bin/bash
#!/bin/sh
set -e

if [ "$dodebug" = "true" ]; then
  echo "Enabling debug symbols, traceable stack frames, and debug logging/checks"
  wccbuildopts="$buildopts -d2 -of+ -dDEBUG_ENABLED=1"
  nasmbuildopts="-g -dDEBUG_ENABLED=1"
fi

buildopts=""

make -j $(nproc) -f Makefile.gnu main.exe EXTERNOPT="$buildopts $@" NASMOPT="$nasmbuildopts" WCCOPTS="$wccbuildopts"

make -j $(nproc) -f Makefile.gnu main16.exe EXTERNOPT="$buildopts $@" NASMOPT="$nasmbuildopts" WCCOPTS="$wccbuildopts"

cp main.exe ../dist
cp main16.exe ../dist
