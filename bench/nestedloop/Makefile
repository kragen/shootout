# $Id: Makefile,v 1.5 2004-06-24 07:38:13 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --ignore nestedloop.csharp \
	  --range 4,8,12,16

include ../../Make.footer
