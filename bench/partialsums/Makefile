# $Id: Makefile,v 1.5 2006-10-02 01:08:41 bfulgham Exp $
include ../../Make.header

TEST    := partialsums
TITLE   := naive summation of series

#XLABEL  := N (number of iterations)

CYCOPTS := -lm
IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GCCOPTS := -lm
GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000

include ../../Make.footer
