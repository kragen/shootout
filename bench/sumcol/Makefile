# $Id: Makefile,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,400,700,1000 \
	  --inputfile Input --geninput \
	  --ignore sumcol.stalin \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
