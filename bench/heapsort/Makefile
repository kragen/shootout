# $Id: Makefile,v 1.16 2004-09-13 01:23:45 bfulgham Exp $
include ../../Make.header

TEST    := heapsort
TITLE   := Heapsort

SE_OPTS := -case_insensitive
LOCDEPS := --dep=se:../Include/randomnumber.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MONOOPTS := --unsafe
OO2COPTS := -A --no-rtc

ERLFLAGS := -noinput
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore heapsort.csharp \
	  --ignore heapsort.bigforth \
	  --ignore heapsort.icon \
	  --ignore heapsort.njs \
	  --ignore heapsort.oberon2 \
	  --ignore heapsort.oz \
	  --ignore heapsort.rep \
	  --ignore heapsort.stalin \
          --range 20000,40000,60000,80000,100000

include ../../Make.footer
