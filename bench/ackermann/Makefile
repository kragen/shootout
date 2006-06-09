# $Id: Makefile,v 1.38 2006-06-09 23:27:20 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

ERLFLAGS := -noinput -noshell
GFORTH_FLAGS := -d 2M -r 2M
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
NLOPTS   := -s 100000
GHCOPTS  := -fasm -fglasgow-exts
IFCOPTS := -ip
PARROTOPTS := -Oc -Cj

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 9,10,11 --ignore ackermann.swiprolog

include ../../Make.footer
