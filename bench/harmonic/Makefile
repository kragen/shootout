# $Id: Makefile,v 1.2 2005-03-17 22:06:44 ekarttun-guest Exp $
include ../../Make.header

TEST    := harmonic
TITLE   := Partial sum of Harmonic series

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision -fasm

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6000000,8000000,10000000

include ../../Make.footer
