# $Id: Makefile,v 1.18 2007-04-07 17:10:51 bfulgham Exp $
include ../../Make.header

TEST    := pidigits
TITLE   := Digits of Pi

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I /usr/lib/clean/lib/ArgEnv \
		-I /usr/lib/clean/lib/ExtendedArith \
                -I /usr/lib/clean/src/libraries/ExtendedArith/ExtendedArith \
                -l /usr/lib/clean/lib/ExtendedArith/gmp.o \
		-l -lgmp \
		-I ../../Include/clean

BIGLOOOPTS := -farithmetic
DLANGOPTS := -L-lgmp -I../../Include/dlang/gmp4d ../../Include/dlang/gmp4d/gmp.d ../../Include/dlang/gmp4d/gmppool.d ../../Include/dlang/gmp4d/mpz.d 
MB_CLRTS := -nr
MONOOPTS := -r:Mono.Security
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
OCAMLOPTS := nums.cmxa
OCAMLBOPTS := nums.cma

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GCCOPTS := $(GCCOPTS) -lgmp
GXXLDOPTS := $(GXXLDOPTS) -lgmp
ICCOPTS := $(ICCOPTS) -lgmp

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 600,800,1000

include ../../Make.footer
