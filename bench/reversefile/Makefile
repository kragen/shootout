# $Id: Makefile,v 1.5 2004-06-18 08:08:22 dbr-guest Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore reversefile.clean \
	  --ignore reversefile.stalin

include ../../Make.footer
