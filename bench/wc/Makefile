# $Id: Makefile,v 1.26 2005-04-16 15:01:05 sgeard-guest Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noshell
GHCOPTS := -package lang
G95OPTS := -combine ../Include/fortran/string.f90
IFCOPTS := ../Include/fortran/string.f90
#MB_GHCRTS  := +RTS -M200m -K10m
MB_GHCRTS  := +RTS -G1
STALINOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,1500,2000,2500 \
	  --inputfile Input --geninput

include ../../Make.footer
