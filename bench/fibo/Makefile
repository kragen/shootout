# $Id: Makefile,v 1.6 2004-07-31 09:19:00 bfulgham Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,24,32 \
	  --ignore fibo.bash \
	  --ignore fibo.csharp

include ../../Make.footer
