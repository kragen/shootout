# $Id: Makefile,v 1.4 2004-07-31 09:19:05 bfulgham Exp $
include ../../Make.header

TEST    := regsub
TITLE   := Regular Expression Substitution

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,8,12

include ../../Make.footer
