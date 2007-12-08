# $Id: Makefile,v 1.19 2007-12-08 07:41:35 bfulgham Exp $
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

ERLFLAGS := -noshell +h 20000000
GHCOPTS := -fbang-patterns
GPLCOPTS := --fast-math
MZSCHEMEOPTS := -qu
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma

SWIOPTS = -q -G0 -g main -t halt

GCCOPTS := $(GCCOPTS) -std=c99
ICCOPTS := $(ICCOPTS) -std=c99
TCCOPTS := $(TCCOPTS) -std=c99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,9,10 --ignore nsieve.bigforth

include ../../Make.footer
