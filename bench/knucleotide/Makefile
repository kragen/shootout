# $Id: Makefile,v 1.2 2005-02-19 17:05:38 bfulgham Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1000,2000 \
	  --inputfile ../../website/data/knucleotide-input.txt \
	  --geninput

include ../../Make.footer
