# $Id: Makefile,v 1.1 2004-12-20 07:22:32 bfulgham Exp $
include ../../Make.header

TEST    := nsieve
TITLE   := Sieve Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
