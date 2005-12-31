# $Id: Makefile,v 1.26 2005-12-31 16:45:26 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean -I /usr/lib/clean/lib/ArgEnv \
		-I /usr/lib/clean/lib/stdenv -I /usr/lib/clean/lib/StdLib
ERLFLAGS := -noinput
MB_NHCRTS := +RTS -H40M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
JREOPTS := -hotspot -da
XDSOPTS := ../../Include/xds/Shootout

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3000,5000,7000,9000

include ../../Make.footer
