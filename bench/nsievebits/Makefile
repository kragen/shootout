# $Id: Makefile,v 1.2 2005-03-30 07:30:52 bfulgham Exp $
include ../../Make.header

TEST    := nsievebits
TITLE   := Sieve (Bit) Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
