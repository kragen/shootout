# $Id: Makefile,v 1.10 2004-08-12 16:27:28 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,400,700,1000 \
	  --inputfile Input --geninput \
	  --ignore sumcol.csharp  \
	  --ignore sumcol.stalin 

include ../../Make.footer
