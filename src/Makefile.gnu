
# MAIN.EXE makefile (taken from fastdoom code)

# --------------------------------------------------------------------------
#
#      4r  use 80486 timings and register argument passing
#       c  compile only
#      d1  include line number debugging information
#      d2  include full sybolic debugging information
#      ei  force enums to be of type int
#       j  change char default from unsigned to signed
#      oa  relax aliasing checking
#      od  do not optimize
#  oe[=#]  expand functions inline, # = quads (default 20)
#      oi  use the inline library functions
#      om  generate inline 80x87 code for math functions
#      ot  optimize for time
#      ox  maximum optimization
#       s  remove stack overflow checks
#     zp1  align structures on bytes
#      zq  use quiet mode
#  /i=dir  add include directories
#
# --------------------------------------------------------------------------

# Build options for 486DX/SX
#CCOPTS = $(EXTERNOPT) -omaxtnrih -ol+ -oe=32 -zp4 -4r -ei -j -zq -zc $(WCCOPTS)

# Build options for 386DX/SX
CCOPTS = $(EXTERNOPT) -omaxtnrih -ol+ -oe=32 -zp4 -3r -ei -j -zq -zc $(WCCOPTS)

# Build options for Pentium
#CCOPTS = $(EXTERNOPT) -omaxtnrih -ol+ -oe=32 -zp4 -5r -ei -j -zq -zc $(WCCOPTS)

# Build options for profiling (Pentium required)
#CCOPTS = $(EXTERNOPT) -omaxtnrih -ol+ -oe=32 -zp4 -5r -ei -j -zq -zc -et $(WCCOPTS)

NASMOPTS = $(EXTERNOPT) $(NASMOPT)

GLOBOBJS = \
 main.obj

main.exe : $(GLOBOBJS)
	wcl386 main.c -fe=main.exe -zp4 -3r -ei -j -zq -zc -ol+ -oe=32 -l=dos4g	

main16.exe : $(GLOBOBJS)
	wcl main.c -fe=main16.exe

%.obj : %.c
	wcc386 $(CCOPTS) $^ -fo=$@

%.obj : %.asm
	nasm -g $(NASMOPTS) -Oxv -f coff $^ -o $@

DELCMD=rm -f

clean:
	pwd
	-$(DELCMD) *.exe
	-$(DELCMD) *.map
	-$(DELCMD) *.err
	-$(DELCMD) *.obj
	-$(DELCMD) *.sym
	-$(DELCMD) *.EXE
	-$(DELCMD) *.MAP
	-$(DELCMD) *.ERR
	-$(DELCMD) *.OBJ
	-$(DELCMD) *.SYM
