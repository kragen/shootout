# $Id: Makefile,v 1.6 2004-06-24 07:38:15 bfulgham Exp $
include ../../Make.header

TEST    := sieve
TITLE   := Sieve of Eratosthenes
GXXOPTS := $(GXXOPTS) -fno-exceptions

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 1,300,600,900 \
	  --ignore sieve.bash \
	  --ignore sieve.csharp

include ../../Make.footer
