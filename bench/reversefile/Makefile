# $Id: Makefile,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore reversefile.stalin \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
