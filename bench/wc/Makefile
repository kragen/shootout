# $Id: Makefile,v 1.2 2004-05-26 00:47:05 bfulgham Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

GHCOPTS := -package lang
MB_GHCRTS  := +RTS -M200m -K10m

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1000,1500,2000 \
	  --ignore wc.rep \
	  --ignore wc.gnat \
	  --inputfile Input --geninput \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
