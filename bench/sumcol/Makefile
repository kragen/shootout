# $Id: Makefile,v 1.31 2007-03-06 04:59:02 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput -noshell
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
GHCOPTS := -fbang-patterns
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
