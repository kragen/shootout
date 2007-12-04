# $Id: Makefile,v 1.8 2007-12-04 06:32:38 bfulgham Exp $
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
GHCOPTS := -O2 -fexcess-precision -fbang-patterns

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000 \
	  --ndiff "-abserr 1.0e-8" \
	  --ignore partialsums.bigforth

include ../../Make.footer
