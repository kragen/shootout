# $Id: Makefile,v 1.17 2004-10-05 02:29:20 bfulgham Exp $
include ../../Make.header

TEST    := heapsort
TITLE   := Heapsort

SE_OPTS := -case_insensitive
LOCDEPS := --dep=se:../Include/randomnumber.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MONOOPTS := --unsafe
OO2COPTS := -A --no-rtc
POLYOPTS := -q
MB_NHCRTS := +RTS -H40M

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
