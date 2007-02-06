# $Id: Makefile,v 1.12 2007-02-06 06:57:50 bfulgham Exp $
include ../../Make.header

TEST    := nsievebits
TITLE   := Sieve (Bit) Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr

BIGFORTH_FLAGS := -d 4M
BIGLOOOPTS := -farithmetic
ERLFLAGS := -noinput
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
