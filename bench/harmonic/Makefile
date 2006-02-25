# $Id: Makefile,v 1.12 2006-02-25 20:31:14 jisom-guest Exp $
include ../../Make.header

TEST    := harmonic
TITLE   := Partial sum of Harmonic series

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv

BIGLOOOPTS := -farithmetic
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
