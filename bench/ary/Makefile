# $Id: Makefile,v 1.9 2004-07-31 09:18:59 bfulgham Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MLTONDEPS := ../../Include/mlton-src/basic.sml
ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore ary.csharp \
	  --range 1000,3000,5000,7000

include ../../Make.footer
