# $Id: Makefile,v 1.3 2005-05-12 21:49:12 igouy-guest Exp $
include ../../Make.header

TEST    := health
TITLE   := healthcare simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
OCAMLOPTS  := -inline 3
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200,600,1000

include ../../Make.footer
