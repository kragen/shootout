# $Id: Makefile,v 1.9 2004-08-11 15:08:58 bfulgham Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,24,32 \
	  --ignore fibo.bash \
	  --ignore fibo.gcj \
	  --ignore fibo.nice 

include ../../Make.footer
