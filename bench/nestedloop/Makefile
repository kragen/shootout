# $Id: Makefile,v 1.14 2004-10-05 02:29:30 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

GHCOPTS := -fglasgow-exts

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_NHCRTS := +RTS -H80M
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --ignore nestedloop.csharp \
	  --ignore nestedloop.nice \
	  --range 8,12,16,18

include ../../Make.footer
