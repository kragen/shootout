# $Id: Makefile,v 1.5 2005-04-19 00:30:25 bfulgham Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 8M
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000 \
	  --inputfile ../../website/desc/knucleotide-input.txt \
	  --uniqueinput

include ../../Make.footer
