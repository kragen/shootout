# $Id: Makefile,v 1.1 2004-12-20 07:22:32 bfulgham Exp $
include ../../Make.header

TEST    := nbody
TITLE   := N-Body orbit simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 600000,800000,1000000

include ../../Make.footer
