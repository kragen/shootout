# $Id: Makefile,v 1.5 2004-06-24 07:38:07 bfulgham Exp $
include ../../Make.header

TEST    := except
TITLE   := Exceptions
GHCOPTS := -package lang
MB_GHCRTS  := +RTS -K2046000

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore except.csharp \
	  --ignore except.java \
          --range 50000,100000,150000,200000

include ../../Make.footer
