# $Id: Makefile,v 1.10 2004-08-11 15:09:04 bfulgham Exp $
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
	  --ignore nestedloop.gcj \
	  --ignore nestedloop.nice \
	  --range 4,8,12,16

include ../../Make.footer
