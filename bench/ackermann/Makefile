# $Id: Makefile,v 1.26 2005-03-04 04:16:28 bfulgham Exp $
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
	     --ignore ackermann.elastic \
	     --ignore ackermann.poly

include ../../Make.footer
