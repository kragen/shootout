# $Id: Makefile,v 1.7 2006-10-03 06:43:50 bfulgham Exp $
include ../../Make.header

TEST    := recursive
TITLE   := naive recursive functions

#XLABEL  := N (number of iterations)

IFCOPTS := -ip
BIGFORTHOPTS := -m 32M -s 16M -r 8M
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GFORTH_FLAGS := -d 8M -r 8M
GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision
PARROTOPTS := -Oc -Cj

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3,7,11

include ../../Make.footer
