# $Id: Makefile,v 1.23 2005-03-27 00:36:28 bfulgham Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noshell
GHCOPTS := -package lang
IFCOPTS := -I../../Include/fortran ../../Include/fortran/string.f90
#MB_GHCRTS  := +RTS -M200m -K10m
MB_GHCRTS  := +RTS -G1
STALINOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,1500,2000,2500 \
	  --ignore wc.poly \
	  --inputfile Input --geninput

include ../../Make.footer
