# $Id: Makefile,v 1.6 2004-09-13 01:24:10 bfulgham Exp $
include ../../Make.header

TEST    := regsub
TITLE   := Regular Expression Substitution

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,12,14

include ../../Make.footer
