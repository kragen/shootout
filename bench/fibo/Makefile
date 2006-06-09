# $Id: Makefile,v 1.26 2006-06-09 23:27:20 bfulgham Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv

BIGLOOOPTS := -farithmetic
ERLFLAGS := -noshell
MZSCHEMEOPTS := -qu
OO2COPTS := --no-rtc
POLYOPTS := -q

GHCOPTS  := -fasm
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 12,24,32 

include ../../Make.footer
