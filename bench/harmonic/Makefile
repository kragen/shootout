# $Id: Makefile,v 1.7 2005-05-01 12:04:33 igouy-guest Exp $
include ../../Make.header

TEST    := harmonic
TITLE   := Partial sum of Harmonic series

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OCAMLOPTS := -inline 100
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision 

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6000000,8000000,10000000

include ../../Make.footer
