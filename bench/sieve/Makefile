# $Id: Makefile,v 1.14 2004-10-05 02:29:40 bfulgham Exp $
include ../../Make.header

TEST    := sieve
TITLE   := Sieve of Eratosthenes
GXXOPTS := $(GXXOPTS) -fno-exceptions

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 300,600,900,1200 \
	  --ignore sieve.bash \
	  --ignore sieve.csharp

include ../../Make.footer
