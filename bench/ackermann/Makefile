# $Id: Makefile,v 1.33 2005-11-06 01:23:45 igouy-guest Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

ERLFLAGS := -noinput -noshell
GFORTH_FLAGS := -d 2M -r 2M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
NLOPTS   := -s 100000
GHCOPTS  := -fasm
IFCOPTS := -ip

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 7,8,9

include ../../Make.footer
