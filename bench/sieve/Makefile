# $Id: Makefile,v 1.10 2004-08-11 15:09:05 bfulgham Exp $
include ../../Make.header

TEST    := sieve
TITLE   := Sieve of Eratosthenes
GXXOPTS := $(GXXOPTS) -fno-exceptions

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 1,300,600,900 \
	  --ignore sieve.bash,sieve.gcj,sieve.nice

include ../../Make.footer
