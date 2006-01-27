# $Id: Makefile,v 1.3 2006-01-27 02:33:58 igouy-guest Exp $
include ../../Make.header

TEST    := recursive
TITLE   := naive recursive functions

#XLABEL  := N (number of iterations)

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic

OO2COPTS := -A --no-rtc
POLYOPTS := -q

GFORTH_FLAGS := -d 8M -r 8M
GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision -optc-ffast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3,7,11

include ../../Make.footer
