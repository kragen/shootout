# $Id: Makefile,v 1.13 2004-08-10 15:16:16 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput
CLEANOPTS := -nr -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore reversefile.nice \
	  --ignore reversefile.stalin

include ../../Make.footer
