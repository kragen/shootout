# $Id: Makefile,v 1.14 2004-09-13 01:23:37 bfulgham Exp $
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
	  --ignore except.csharp \
          --range 100000,150000,200000,250000

include ../../Make.footer
