# $Id: Makefile,v 1.9 2004-08-11 15:09:10 bfulgham Exp $
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
	  --ignore sumcol.stalin  \
	  --ignore sumcol.gcj \
	  --ignore sumcol.nice

include ../../Make.footer
