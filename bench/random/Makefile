# $Id: Makefile,v 1.29 2006-06-10 21:22:58 bfulgham Exp $
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
MZSCHEMEOPTS := -qu
POLYOPTS := -q

GHCOPTS := -fexcess-precision -fglasgow-exts

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 9000,300000,600000,900000 

include ../../Make.footer
