# $Id: Makefile,v 1.20 2005-03-02 06:24:27 bfulgham Exp $
include ../../Make.header

TEST    := heapsort
TITLE   := Heapsort

SE_OPTS := -case_insensitive
LOCDEPS := --dep=se:../Include/randomnumber.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MONOOPTS := --unsafe
OO2COPTS := -A 
POLYOPTS := -q
MB_NHCRTS := +RTS -H40M

ERLFLAGS := -noinput
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore heapsort.elastic \
	  --ignore heapsort.stalin \
          --range 20000,40000,60000,80000,100000

include ../../Make.footer
