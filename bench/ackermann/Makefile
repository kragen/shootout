# $Id: Makefile,v 1.30 2005-05-14 19:25:26 sgeard-guest Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput -noshell
GFORTH_FLAGS := -d 2M -r 2M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
NLOPTS   := -s 100000
GHCOPTS  := -fasm
IFCOPTS := -ip

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 6,7,8,9,10

include ../../Make.footer
