# $Id: Makefile,v 1.12 2004-08-12 16:27:30 bfulgham Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

GHCOPTS := -package lang
MB_GHCRTS  := +RTS -M200m -K10m
STALINOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1000,1500,2000 \
	  --ignore wc.csharp \
	  --ignore wc.gnat \
	  --ignore wc.rep \
	  --ignore wc.stalin \
	  --inputfile Input --geninput

include ../../Make.footer
