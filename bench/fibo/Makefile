# $Id: Makefile,v 1.4 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,24,32 \
	  --ignore fibo.bash

include ../../Make.footer
