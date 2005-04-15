# $Id: Makefile,v 1.1 2005-04-15 06:01:29 igouy-guest Exp $
include ../../Make.header

TEST    := health
TITLE   := healthcare simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
OCAMLOPTS  := -inline 3
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1000,1500

include ../../Make.footer
