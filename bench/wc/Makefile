# $Id: Makefile,v 1.20 2005-03-17 22:06:45 ekarttun-guest Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

GHCOPTS := -package lang
#MB_GHCRTS  := +RTS -M200m -K10m
MB_GHCRTS  := +RTS -G1
STALINOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,1500,2000,2500 \
	  --ignore wc.gnat \
	  --ignore wc.poly \
	  --inputfile Input --geninput

include ../../Make.footer
