# $Id: Makefile,v 1.1 2004-05-19 18:10:33 bfulgham Exp $
include ../../Make.header

TEST    := matrix
TITLE   := Matrix Multiplication

GCCOPTS := -funroll-loops
GXXOPTS := -funroll-loops

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore matrix.mawk,matrix.gawk \
	  --range 1,100,200,300 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
