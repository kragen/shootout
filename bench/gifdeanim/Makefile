# $Id: Makefile,v 1.1 2004-05-19 18:09:54 bfulgham Exp $
include ../../Make.header

TEST    := gifdeanim
TITLE   := GIF Image De-Animator

#XLABEL  := N (number of iterations)

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,16,24,32 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
