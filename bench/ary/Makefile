# $Id: Makefile,v 1.23 2005-05-08 20:41:19 sweeks Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
MB_NHCRTS := +RTS -H40M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
JREOPTS := -hotspot -da

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3000,5000,7000,9000

include ../../Make.footer
