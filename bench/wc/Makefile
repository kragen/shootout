# $Id: Makefile,v 1.15 2004-09-30 07:39:46 bfulgham Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

GHCOPTS := -O2 -package lang
MB_GHCRTS  := +RTS -M200m -K10m
STALINOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,1500,2000,2500 \
	  --ignore wc.csharp \
	  --ignore wc.gnat \
	  --ignore wc.rep \
	  --inputfile Input --geninput

include ../../Make.footer
