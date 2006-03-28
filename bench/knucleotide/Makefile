# $Id: Makefile,v 1.14 2006-03-28 16:41:36 bfulgham Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-l /usr/lib/clean/lib/ExtendedArith/gmp.o \
		-I ../Include/clean -I ../../Include/clean

MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 8M
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 2500,25000,250000 \
	  --inputfile ../../website/desc/knucleotide-input.txt \
	  --uniqueinput

include ../../Make.footer
