# $Id: Makefile,v 1.16 2004-07-31 09:19:02 bfulgham Exp $
include ../../Make.header

TEST    := moments
TITLE   := Statistical Moments

GCCOPTS := -lm

#XLABEL  := N (number of copies of input data)

MLTONDEPS := ../../Include/mlton-src/basic.sml \
	     ../../Include/mlton-src/insertion-sort.sml \
	     ../../Include/mlton-src/quick-sort.sml

MB_GHCRTS  := +RTS -K2046000

ERLFLAGS := -noinput
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,50,100,150 \
	  --inputfile Input --geninput \
	  --ignore moments.csharp \
	  --ignore moments.erlang \
	  --ignore moments.hipe \
	  --ignore moments.mercury \
	  --ignore moments.nice \
	  --ignore moments.stalin \
	  --ignore moments.gawk,moments.mawk 

include ../../Make.footer
