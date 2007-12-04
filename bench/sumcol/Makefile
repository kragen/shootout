# $Id: Makefile,v 1.34 2007-12-04 06:32:39 bfulgham Exp $
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
	  --range 400,700,1000,8000 \
	  --inputfile ../../website/desc/sumcol-input.txt --geninput
	  

include ../../Make.footer
