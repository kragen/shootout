# $Id: Makefile,v 1.18 2004-10-08 06:04:01 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MLTONDEPS := ../../Include/mlton-src/basic.sml
ERLFLAGS := -noinput
MB_NHCRTS := +RTS -H40M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
JREOPTS := -hotspot -da

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore ary.bash \
	  --ignore ary.csharp \
	  --range 3000,5000,7000,9000

include ../../Make.footer
