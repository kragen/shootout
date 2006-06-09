# $Id: Makefile,v 1.21 2006-06-09 23:27:21 bfulgham Exp $
include ../../Make.header

TEST    := sieve
TITLE   := Sieve of Eratosthenes
GXXOPTS := $(GXXOPTS) -fno-exceptions

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
OO2COPTS := -A --no-rtc
MZSCHEMEOPTS := -qu
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 300,600,900,1200 

include ../../Make.footer
