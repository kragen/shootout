# $Id: Makefile,v 1.5 2005-03-30 07:30:52 bfulgham Exp $
include ../../Make.header

TEST    := nsieve
TITLE   := Sieve Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 8M
MB_CLRTS := -nr -h 80000000
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput -noshell -h 200000000
GPLCOPTS := --fast-math
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
