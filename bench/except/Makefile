# $Id: Makefile,v 1.1 2004-05-19 18:09:44 bfulgham Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 50000,100000,150000,200000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
