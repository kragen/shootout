# $Id: Makefile,v 1.4 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --range 4,8,12,16

include ../../Make.footer
