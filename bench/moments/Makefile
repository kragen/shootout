# $Id: Makefile,v 1.9 2004-06-17 03:38:05 sweeks Exp $
include ../../Make.header

TEST    := moments
TITLE   := Statistical Moments

GCCOPTS := -lm

#XLABEL  := N (number of copies of input data)

MLTONDEPS := ../../Include/mlton-src/basic.sml \
	     ../../Include/mlton-src/insertion-sort.sml \
	     ../../Include/mlton-src/quick-sort.sml

MB_GHCRTS  := +RTS -K2046000

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h10000000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,50,100,150 \
	  --inputfile Input --geninput \
	  --ignore moments.erlang \
	  --ignore moments.hipe \
	  --ignore moments.stalin \
	  --ignore moments.gawk,moments.mawk \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
