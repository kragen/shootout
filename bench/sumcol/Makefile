# $Id: Makefile,v 1.5 2004-06-24 07:38:16 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,400,700,1000 \
	  --inputfile Input --geninput \
	  --ignore sumcol.stalin \
	  --ignore sumcol.csharp

include ../../Make.footer
