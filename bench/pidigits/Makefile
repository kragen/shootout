# $Id: Makefile,v 1.7 2005-03-25 07:59:08 bfulgham Exp $
include ../../Make.header

TEST    := pidigits
TITLE   := Digits of Pi

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
DLANGOPTS := -L-lgmp -I../../Include/dlang/gmp4d ../../Include/dlang/gmp4d/gmp.d ../../Include/dlang/gmp4d/gmppool.d ../../Include/dlang/gmp4d/mpz.d 
MB_CLRTS := -nr
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q
OCAMLOPTS := nums.cmxa
OCAMLBOPTS := nums.cma

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,200,300 --ignore pidigits.clean

include ../../Make.footer
