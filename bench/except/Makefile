# $Id: Makefile,v 1.17 2004-10-21 13:04:14 dbr-guest Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000

ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
POLYOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	--ignore except.csharp \
	--range 100000,150000,200000,250000

include ../../Make.footer
