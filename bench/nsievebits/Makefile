# $Id: Makefile,v 1.14 2007-04-08 00:04:07 bfulgham Exp $
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
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M

GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9

include ../../Make.footer
