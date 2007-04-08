# $Id: Makefile,v 1.20 2007-04-08 00:20:14 bfulgham Exp $
include ../../Make.header

TEST    := pidigits
TITLE   := Digits of Pi

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -IL ExtendedArith -l -lgmp \
		-I /usr/lib/clean/lib/ExtendedArith \
		-I ../../Include/clean

BIGLOOOPTS := -farithmetic
DLANGOPTS := -L-lgmp -I../../Include/dlang/gmp4d ../../Include/dlang/gmp4d/gmp.d ../../Include/dlang/gmp4d/gmppool.d ../../Include/dlang/gmp4d/mpz.d 
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
