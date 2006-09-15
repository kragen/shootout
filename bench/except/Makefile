# $Id: Makefile,v 1.20 2006-09-15 14:53:55 bfulgham Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000
MZSCHEMEOPTS := -qu

ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
POLYOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	--range 100000,150000,200000,250000 --ignore except.sbcl-2.sbcl

include ../../Make.footer
