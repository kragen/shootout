# $Id: Makefile,v 1.21 2005-02-19 17:05:39 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_GHCRTS  := +RTS -H10M
MB_NHCRTS := +RTS -H20M -RTS
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400,700,1000,8000 \
	  --ignore sumcol.stalin \
	  --inputfile ../../website/data/sumcol-input.txt --geninput

include ../../Make.footer
