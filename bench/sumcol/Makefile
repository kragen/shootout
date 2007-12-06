# $Id: Makefile,v 1.35 2007-12-06 15:54:05 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

#ERLFLAGS := -noshell
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
GHCOPTS := -O2 -fasm
MB_GHCRTS  := +RTS -H10M
MB_NHCRTS := +RTS -H20M -RTS
MZSCHEMEOPTS := -uqxA
OO2COPTS := -A --no-rtc
PARROTOPTS := -j
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,11000,21000 \
	  --inputfile ../../website/desc/sumcol-input.txt --geninput \
	  --ignore sumcol.bash
	  

include ../../Make.footer
