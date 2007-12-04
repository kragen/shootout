# $Id: Makefile,v 1.15 2007-12-04 06:32:38 bfulgham Exp $
include ../../Make.header

TEST    := nsievebits
TITLE   := Sieve (Bit) Test

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -nr -h 10m -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr -h 10m

BIGFORTH_FLAGS := -d 4M
BIGLOOOPTS := -farithmetic
ERLFLAGS := -noinput
GHCOPTS := -fbang-patterns
GPLCOPTS := --fast-math
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M


RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 9,10,11 --ignore nsievebits.bigforth

include ../../Make.footer
