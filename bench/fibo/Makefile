# $Id: Makefile,v 1.14 2004-10-12 06:10:32 bfulgham Exp $
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
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 12,24,32 \
	  --ignore fibo.csharp \
	  --ignore fibo.bash \
	  --ignore fibo.ciao \
	  --ignore fibo.gprolog

include ../../Make.footer
