# $Id: Makefile,v 1.6 2004-06-30 07:29:01 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

GHCOPTS := -fglasgow-exts

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --ignore nestedloop.csharp \
	  --range 4,8,12,16

include ../../Make.footer
