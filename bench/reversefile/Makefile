# $Id: Makefile,v 1.3 2004-06-13 00:16:51 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore reversefile.clean \
	  --ignore reversefile.stalin \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
