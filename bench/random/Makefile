# $Id: Makefile,v 1.27 2006-01-14 03:53:18 ekarttun-guest Exp $
include ../../Make.header

TEST    := random
TITLE   := Random Number Generator

SE_OPTS := -case_insensitive
MB_GHCRTS  := +RTS -K16000000
LOCDEPS := --dep=se:../Include/randomnumber.e

IFCOPTS := -ip
STALINOPTS := -s
ERLFLAGS := -noinput

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GHCOPTS := -fexcess-precision -fglasgow-exts

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 9000,300000,600000,900000 

include ../../Make.footer
