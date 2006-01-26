# $Id: Makefile,v 1.2 2006-01-26 23:51:55 igouy-guest Exp $
include ../../Make.header

TEST    := recursive
TITLE   := naive recursive functions

#XLABEL  := N (number of iterations)

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic

OO2COPTS := -A --no-rtc
POLYOPTS := -q

GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision -optc-ffast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3,7,11

include ../../Make.footer
