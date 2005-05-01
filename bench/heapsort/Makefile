# $Id: Makefile,v 1.25 2005-05-01 12:04:33 igouy-guest Exp $
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
GHCOPTS := -fexcess-precision

ERLFLAGS := -noinput -noshell
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 20000,40000,60000,80000,100000

include ../../Make.footer
