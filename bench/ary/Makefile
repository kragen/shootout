# $Id: Makefile,v 1.8 2004-07-07 01:42:53 sweeks Exp $
include ../../Make.header

TEST    := ary
TITLE   := Array Access

GHCOPTS := -package lang -fglasgow-exts
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MLTONDEPS := ../../Include/mlton-src/basic.sml

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore ary.csharp \
	  --range 1000,3000,5000,7000

include ../../Make.footer
