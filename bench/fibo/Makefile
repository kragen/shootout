# $Id: Makefile,v 1.22 2005-04-04 14:56:35 bfulgham Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
ERLFLAGS := -noshell
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

GHCOPTS  := -fasm
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 12,24,32 

include ../../Make.footer
