# $Id: Makefile,v 1.15 2004-10-06 07:26:52 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

GHCOPTS := -fglasgow-exts

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_NHCRTS := +RTS -H60M -RTS
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --ignore nestedloop.csharp \
	  --ignore nestedloop.nice \
	  --range 8,12,16,18

include ../../Make.footer
