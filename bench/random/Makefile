# $Id: Makefile,v 1.7 2004-06-23 03:38:35 bfulgham Exp $
include ../../Make.header

TEST    := random
TITLE   := Random Number Generator

SE_OPTS := -case_insensitive
MB_GHCRTS  := +RTS -K16000000
LOCDEPS := --dep=se:../Include/randomnumber.e

STALINOPTS := -s

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

#	  --ignore random.bigforth,random.icon,random.rep,random.njs \

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore random.bigforth,random.njs,random.csharp \
	  --range 1000,300000,600000,900000

include ../../Make.footer
