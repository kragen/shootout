# $Id: Makefile,v 1.23 2005-03-25 07:59:09 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput -noshell
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_GHCRTS  := +RTS -H10M
MB_NHCRTS := +RTS -H20M -RTS
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400,700,1000,8000 \
	  --ignore sumcol.bash \
	  --ignore sumcol.bigloo \
	  --ignore sumcol.stalin \
	  --inputfile ../../website/desc/sumcol-input.txt --geninput

include ../../Make.footer
