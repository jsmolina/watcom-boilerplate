#!/bin/bash
#!/bin/sh
set -e

if [ "$dodebug" = "true" ]; then
  echo "Enabling debug symbols, traceable stack frames, and debug logging/checks"
  wccbuildopts="$buildopts -d2 -of+ -dDEBUG_ENABLED=1"
  nasmbuildopts="-g -dDEBUG_ENABLED=1"
fi

buildopts=""

make -j $(nproc) -f Makefile.gnu clean_objs
make -j $(nproc) -f Makefile.gnu build32 EXE=main32.exe EXTERNOPT="$buildopts $@" NASMOPT="$nasmbuildopts" WCCOPTS="$wccbuildopts"
mv main.exe ../dist/main32.exe

make -j $(nproc) -f Makefile.gnu clean_objs
make -j $(nproc) -f Makefile.gnu build16 EXE=main16.exe EXTERNOPT="$buildopts $@" NASMOPT="$nasmbuildopts" WCCOPTS="$wccbuildopts"
mv main.exe ../dist/main16.exe

