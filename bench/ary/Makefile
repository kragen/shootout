# $Id: Makefile,v 1.1 2004-05-19 18:09:15 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200000,400000,600000,800000,1000000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
