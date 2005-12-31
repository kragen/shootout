# $Id: Makefile,v 1.27 2005-12-31 16:45:26 bfulgham Exp $
include ../../Make.header

TEST    := heapsort
TITLE   := Heapsort

SE_OPTS := -case_insensitive
LOCDEPS := --dep=se:../Include/randomnumber.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv \
		-I /usr/lib/clean/lib/StdLib
MONOOPTS := --unsafe
OO2COPTS := -A --no-rtc 
POLYOPTS := -q
MB_NHCRTS := +RTS -H40M
GHCOPTS := -fexcess-precision

ERLFLAGS := -noinput -noshell
RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 20000,40000,60000,80000,100000

include ../../Make.footer
