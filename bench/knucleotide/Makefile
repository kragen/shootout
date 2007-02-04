# $Id: Makefile,v 1.20 2007-02-04 16:54:06 bfulgham Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-l /usr/lib/clean/lib/ExtendedArith/gmp.o \
		-I ../Include/clean -I ../../Include/clean

MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
DLANGOPTS := ../../Include/dlang/hashtable.d
BIGFORTHOPTS := -d 8M
GFORTH_FLAGS := -m 8M
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M

GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 2500,25000,250000 \
	  --inputfile ../../website/desc/knucleotide-input.txt \
	  --uniqueinput

include ../../Make.footer
