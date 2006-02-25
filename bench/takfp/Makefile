# $Id: Makefile,v 1.12 2006-02-25 20:31:14 jisom-guest Exp $
include ../../Make.header

TEST    := takfp
TITLE   := TAK Function

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic

OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision -optc-ffast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,9,10

include ../../Make.footer
