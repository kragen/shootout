# $Id: Makefile,v 1.11 2004-08-11 15:09:11 bfulgham Exp $
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
	  --ignore wc.gcj \
	  --ignore wc.gnat \
	  --ignore wc.nice \
	  --ignore wc.rep \
	  --ignore wc.stalin \
	  --inputfile Input --geninput

include ../../Make.footer
