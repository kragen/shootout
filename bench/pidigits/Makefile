# $Id: Makefile,v 1.14 2005-12-31 16:45:29 bfulgham Exp $
include ../../Make.header

TEST    := pidigits
TITLE   := Digits of Pi

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o -lgmp \
		-I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv \
		-I /usr/lib/clean/lib/ExtendedArith \
                -I /usr/lib/clean/src/libraries/ExtendedArith/ExtendedArith

BIGLOOOPTS := -farithmetic
DLANGOPTS := -L-lgmp -I../../Include/dlang/gmp4d ../../Include/dlang/gmp4d/gmp.d ../../Include/dlang/gmp4d/gmppool.d ../../Include/dlang/gmp4d/mpz.d 
MB_CLRTS := -nr
MONOOPTS := -r:Mono.Security
OO2COPTS := -A --no-rtc
POLYOPTS := -q
OCAMLOPTS := nums.cmxa
OCAMLBOPTS := nums.cma

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 600,800,1000

include ../../Make.footer
