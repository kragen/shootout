# $Id: Makefile,v 1.1 2004-05-19 18:10:50 bfulgham Exp $
include ../../Make.header

TEST    := moments
TITLE   := Statistical Moments

#XLABEL  := N (number of copies of input data)

MLTONDEPS := /usr/local/smlnj/src/smlnj-lib/Util/array-sort-sig.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/array-qsort.sml

MB_GHCRTS  := +RTS -K2046000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,50,100,150 \
	  --inputfile Input --geninput \
	  --ignore moments.gawk,moments.mawk \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
