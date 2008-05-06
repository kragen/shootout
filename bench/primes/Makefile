# $Id: 
include ../../Make.header

TEST    := primes
TITLE   := Prime Function

CLEANOPTS := $(CLEANOPTS) -nr -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv

OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,1000,10000

include ../../Make.footer
