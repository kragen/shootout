# $Id: Makefile,v 1.22 2005-03-25 07:59:08 bfulgham Exp $
include ../../Make.header

TEST    := random
TITLE   := Random Number Generator

SE_OPTS := -case_insensitive
MB_GHCRTS  := +RTS -K16000000
LOCDEPS := --dep=se:../Include/randomnumber.e

STALINOPTS := -s
ERLFLAGS := -noinput -noshell

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 9000,300000,600000,900000 \
	  --ignore random.poly \
	  --ignore random.elastic

include ../../Make.footer
