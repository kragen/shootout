# $Id: Makefile,v 1.22 2007-12-06 15:54:05 bfulgham Exp $
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
OBJCOPTS := -lgmp
OO2COPTS := -A --no-rtc
POLYOPTS := -q
OCAMLOPTS := -I +gmp gmp.cmxa nums.cmxa
OCAMLBOPTS := nums.cma

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GCCOPTS := $(GCCOPTS) -lgmp
GXXLDOPTS := $(GXXLDOPTS) -lgmp
ICCOPTS := $(ICCOPTS) -lgmp

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1500,2500,5000

include ../../Make.footer
