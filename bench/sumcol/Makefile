# $Id: Makefile,v 1.33 2007-11-15 06:50:30 igouy-guest Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput -noshell
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
