# $Id: Makefile,v 1.14 2004-08-12 16:26:53 bfulgham Exp $
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
	  --ignore heapsort.bigforth \
	  --ignore heapsort.csharp \
	  --ignore heapsort.icon \
	  --ignore heapsort.njs \
	  --ignore heapsort.oz \
	  --ignore heapsort.oberon2 \
	  --ignore heapsort.rep \
	  --ignore heapsort.stalin \
          --range 1000,20000,40000,60000,80000

include ../../Make.footer
