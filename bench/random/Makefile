# $Id: Makefile,v 1.15 2004-10-05 02:29:34 bfulgham Exp $
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
POLYOPTS := -q

#	  --ignore random.bigforth,random.icon,random.rep,random.njs \

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore random.bash,random.bigforth,random.njs,random.csharp,random.nhc98 \
	  --range 9000,300000,600000,900000

include ../../Make.footer
