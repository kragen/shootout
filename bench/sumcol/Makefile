# $Id: Makefile,v 1.4 2004-06-18 08:08:22 dbr-guest Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,400,700,1000 \
	  --inputfile Input --geninput \
	  --ignore sumcol.stalin

include ../../Make.footer
