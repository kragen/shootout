# $Id: Makefile,v 1.4 2004-06-13 00:16:44 bfulgham Exp $
include ../../Make.header

TEST    := moments
TITLE   := Statistical Moments

GCCOPTS := -lm

#XLABEL  := N (number of copies of input data)

#MLTONDEPS := /usr/local/smlnj/src/smlnj-lib/Util/array-sort-sig.sml \
#             /usr/local/smlnj/src/smlnj-lib/Util/array-qsort.sml
MLTONDEPS := ../../Include/sml-src/array-sort-sig.sml \
	     ../../Include/sml-src/array-qsort.sml

MB_GHCRTS  := +RTS -K2046000

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include -I ../../Include
MB_CLRTS := -h 10000000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,50,100,150 \
	  --inputfile Input --geninput \
	  --ignore moments.stalin \
	  --ignore moments.gawk,moments.mawk \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
