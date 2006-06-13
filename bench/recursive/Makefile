# $Id: Makefile,v 1.5 2006-06-13 03:47:49 bfulgham Exp $
include ../../Make.header

TEST    := recursive
TITLE   := naive recursive functions

#XLABEL  := N (number of iterations)

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GFORTH_FLAGS := -d 8M -r 8M
GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision -optc-ffast-math
PARROTOPTS := -Oc -Cj

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3,7,11

include ../../Make.footer
