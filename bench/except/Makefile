# $Id: Makefile,v 1.3 2004-06-16 04:38:24 bfulgham Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore except.java \
          --range 50000,100000,150000,200000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
