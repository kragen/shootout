# $Id: Makefile,v 1.3 2004-05-28 02:58:45 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,3000,5000,7000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
