# $Id: Makefile,v 1.8 2004-07-11 07:52:32 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

CLEANOPTS := -nr -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore reversefile.csharp \
	  --ignore reversefile.nice \
	  --ignore reversefile.stalin

include ../../Make.footer
