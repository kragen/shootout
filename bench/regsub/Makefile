# $Id: Makefile,v 1.3 2004-06-18 08:08:22 dbr-guest Exp $
include ../../Make.header

TEST    := regsub
TITLE   := Regular Expression Substitution

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,8,12

include ../../Make.footer
