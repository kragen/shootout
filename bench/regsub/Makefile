# $Id: Makefile,v 1.5 2004-08-04 07:39:54 bfulgham Exp $
include ../../Make.header

TEST    := regsub
TITLE   := Regular Expression Substitution

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,8,12

include ../../Make.footer
