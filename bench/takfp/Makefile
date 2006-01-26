# $Id: Makefile,v 1.11 2006-01-26 23:51:55 igouy-guest Exp $
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
PARROTOPTS := -C
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GHCOPTS := -O2 -fexcess-precision -optc-ffast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,9,10

include ../../Make.footer
