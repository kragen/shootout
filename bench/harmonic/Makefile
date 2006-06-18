# $Id: Makefile,v 1.13 2006-06-18 01:53:59 bfulgham Exp $
include ../../Make.header

TEST    := harmonic
TITLE   := Partial sum of Harmonic series

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv

BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -r
OCAMLOPTS := -inline 100
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GHCOPTS := -fexcess-precision 
GPLCOPTS := --global-size 175000 --min-size
XDSOPTS := ../../Include/xds/Shootout.xds

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6000000,8000000,10000000

include ../../Make.footer
