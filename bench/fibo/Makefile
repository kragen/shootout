# $Id: Makefile,v 1.13 2004-10-05 02:29:14 bfulgham Exp $
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
	  --ignore fibo.ciao 

include ../../Make.footer
