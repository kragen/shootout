# $Id: Makefile,v 1.4 2004-06-13 00:16:38 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include -I ../../Include

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,3000,5000,7000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
