# $Id: Makefile,v 1.17 2007-04-08 00:04:07 bfulgham Exp $
include ../../Make.header

TEST    := nsieve
TITLE   := Sieve Test

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -nr -h 10m -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv


BIGFORTHOPTS := -d 8M
BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 8M
MB_CLRTS := -nr -h 10m 
OO2COPTS := -A --no-rtc
POLYOPTS := -q
PHPOPTS := -d memory_limit=400M

ERLFLAGS := -noinput -noshell -h 200000000
GHCOPTS := -fbang-patterns
GPLCOPTS := --fast-math
MZSCHEMEOPTS := -qu
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

SWIOPTS = -q -G0 -g main -t halt

GCCOPTS := $(GCCOPTS) -std=c99
ICCOPTS := $(ICCOPTS) -std=c99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
