# $Id: Makefile,v 1.3 2004-06-08 06:29:13 bfulgham Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

GHCOPTS := -package lang
MB_GHCRTS  := +RTS -M200m -K10m
STALINOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1000,1500,2000 \
	  --ignore wc.gnat \
	  --ignore wc.rep \
	  --ignore wc.stalin \
	  --inputfile Input --geninput \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
