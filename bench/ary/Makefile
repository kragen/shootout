# $Id: Makefile,v 1.16 2004-09-13 01:23:33 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MLTONDEPS := ../../Include/mlton-src/basic.sml
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
JREOPTS := -hotspot -da

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore ary.bash \
	  --ignore ary.csharp \
	  --range 3000,5000,7000,9000

include ../../Make.footer
