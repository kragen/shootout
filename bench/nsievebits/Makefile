# $Id: Makefile,v 1.3 2005-05-01 12:04:34 igouy-guest Exp $
include ../../Make.header

TEST    := nsievebits
TITLE   := Sieve (Bit) Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
OO2COPTS := -A --no-rtc
POLYOPTS := -q
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
