# $Id: Makefile,v 1.12 2004-08-12 16:27:17 bfulgham Exp $
include ../../Make.header

TEST    := random
TITLE   := Random Number Generator

SE_OPTS := -case_insensitive
MB_GHCRTS  := +RTS -K16000000
LOCDEPS := --dep=se:../Include/randomnumber.e

STALINOPTS := -s
ERLFLAGS := -noinput

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

#	  --ignore random.bigforth,random.icon,random.rep,random.njs \

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore random.bash,random.bigforth,random.csharp,random.njs \
	  --range 1000,300000,600000,900000

include ../../Make.footer
