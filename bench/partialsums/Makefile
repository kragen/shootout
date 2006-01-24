# $Id: Makefile,v 1.1 2006-01-24 04:16:26 igouy-guest Exp $
include ../../Make.header

TEST    := partialsums
TITLE   := naive summation of series

#XLABEL  := N (number of iterations)

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision -optc-ffast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000

include ../../Make.footer
