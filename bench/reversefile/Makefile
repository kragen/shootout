# $Id: Makefile,v 1.22 2005-02-19 17:05:39 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput
CLEANOPTS := -nr -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 20000000
MB_NHCRTS := +RTS -H40M
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 10,15,20,25 \
          --ignore reversefile.gnat \
          --ignore reversefile.stalin \
	  --inputfile ../../website/data/reversefile-input.txt --geninput

include ../../Make.footer
