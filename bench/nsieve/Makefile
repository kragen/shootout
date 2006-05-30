# $Id: Makefile,v 1.11 2006-05-30 21:50:15 igouy-guest Exp $
include ../../Make.header

TEST    := nsieve
TITLE   := Sieve Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv


BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 8M
MB_CLRTS := -nr -h 10m 
OO2COPTS := -A --no-rtc
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M

ERLFLAGS := -noinput -noshell -h 200000000
GPLCOPTS := --fast-math
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

SWIOPTS = -q -G0 -g main -t halt

GCCOPTS := $(GCCOPTS) -std=c99
ICCOPTS := $(ICCOPTS) -std=c99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
