# $Id: Makefile,v 1.2 2004-05-22 22:02:12 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,3000,5000,7000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
