# $Id: Makefile,v 1.34 2006-01-13 12:57:01 ekarttun-guest Exp $
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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 7,8,9

include ../../Make.footer
