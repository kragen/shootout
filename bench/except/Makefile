# $Id: Makefile,v 1.6 2004-06-25 07:57:49 bfulgham Exp $
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
	  --ignore except.gij \
	  --ignore except.gcj \
	  --ignore except.kaffe \
	  --ignore except.sablevm \
          --range 50000,100000,150000,200000

include ../../Make.footer
