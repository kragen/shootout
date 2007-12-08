# $Id: Makefile,v 1.35 2007-12-08 03:58:38 bfulgham Exp $
include ../../Make.header

TEST    := moments
TITLE   := Statistical Moments

GCCOPTS := -lm
GDCOPTS := -lm

#XLABEL  := N (number of copies of input data)

MB_GHCRTS  := +RTS -K2M -H45M
MB_NHCRTS  := +RTS -H40M
HUGS_FLAGS := -h10000000

CYCOPTS := -lm
#ERLFLAGS := -noinput
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -h 10000000
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25,75,125,200 \
	  --inputfile ../../website/desc/moments-input.txt --geninput

include ../../Make.footer
