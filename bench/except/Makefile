# $Id: Makefile,v 1.12 2004-08-16 08:00:10 bfulgham Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000

ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore except.nice \
          --range 50000,100000,150000,200000

include ../../Make.footer
