# $Id: Makefile,v 1.5 2004-06-15 05:45:39 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,3000,5000,7000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
