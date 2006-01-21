# $Id: Makefile,v 1.36 2006-01-21 20:51:51 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

ERLFLAGS := -noinput -noshell
GFORTH_FLAGS := -d 2M -r 2M
OO2COPTS := -A --no-rtc
POLYOPTS := -q
NLOPTS   := -s 100000
GHCOPTS  := -fasm -fglasgow-exts
IFCOPTS := -ip

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 9,10,11 --ignore ackermann.swiprolog

include ../../Make.footer
