# $Id: Makefile,v 1.11 2004-08-12 16:27:15 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

GHCOPTS := -fglasgow-exts

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --range 4,8,12,16

include ../../Make.footer
