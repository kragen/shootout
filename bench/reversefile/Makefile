# $Id: Makefile,v 1.17 2004-09-13 01:24:10 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput
CLEANOPTS := -nr -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 10,15,20,25 \
	  --inputfile Input --geninput \
	  --ignore reversefile.csharp \
	  --ignore reversefile.gnat \
	  --ignore reversefile.stalin

include ../../Make.footer
