# $Id: Makefile,v 1.23 2005-05-01 12:04:33 igouy-guest Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
ERLFLAGS := -noshell
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GHCOPTS  := -fasm
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 12,24,32 

include ../../Make.footer
