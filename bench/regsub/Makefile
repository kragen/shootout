# $Id: Makefile,v 1.2 2004-06-16 04:38:29 bfulgham Exp $
include ../../Make.header

TEST    := regsub
TITLE   := Regular Expression Substitution

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,8,12 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
