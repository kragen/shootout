# $Id: Makefile,v 1.25 2005-03-02 06:24:26 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
GFORTH_FLAGS := -d 2M -r 2M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
NLOPTS   := -s 100000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 6,7,8,9,10 \
             --ignore ackermann.ciao \
	     --ignore ackermann.oberon2 \
	     --ignore ackermann.poly

include ../../Make.footer
