# $Id: Makefile,v 1.26 2005-02-19 17:05:39 bfulgham Exp $
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
	  --ignore moments.mercury \
	  --ignore moments.stalin \
	  --inputfile ../../website/moments-input.txt --geninput

include ../../Make.footer
