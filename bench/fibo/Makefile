# $Id: Makefile,v 1.17 2005-02-02 18:57:29 ekarttun-guest Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GHCOPTS  := -fasm
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 12,24,32 --ignore fibo.poly 

include ../../Make.footer
