# $Id: Makefile,v 1.13 2004-08-12 16:26:43 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MLTONDEPS := ../../Include/mlton-src/basic.sml
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,3000,5000,7000

include ../../Make.footer
