# $Id: Makefile,v 1.2 2004-05-23 04:36:29 bfulgham Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore except.java \
          --range 50000,100000,150000,200000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
