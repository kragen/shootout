# $Id: Makefile,v 1.24 2004-10-05 05:54:14 bfulgham Exp $
include ../../Make.header

TEST    := moments
TITLE   := Statistical Moments

GCCOPTS := -lm

#XLABEL  := N (number of copies of input data)

MLTONDEPS := ../../Include/mlton-src/basic.sml \
	     ../../Include/mlton-src/insertion-sort.sml \
	     ../../Include/mlton-src/quick-sort.sml

MB_GHCRTS  := +RTS -K2M -H45M
MB_NHCRTS  := +RTS -H40M
HUGS_FLAGS := -h10000000

ERLFLAGS := -noinput
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25,75,125,200 \
	  --inputfile Input --geninput \
	  --ignore moments.mercury \
	  --ignore moments.stalin \
	  --ignore moments.csharp \
	  --ignore moments.gawk,moments.mawk 

include ../../Make.footer
