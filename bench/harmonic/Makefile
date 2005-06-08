# $Id: Makefile,v 1.8 2005-06-08 07:55:38 bfulgham Exp $
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
GHCOPTS := -fexcess-precision 
GPLCOPTS := --global-size 175000 --min-size

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6000000,8000000,10000000

include ../../Make.footer
