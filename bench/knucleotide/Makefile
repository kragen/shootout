# $Id: Makefile,v 1.3 2005-03-06 05:21:23 bfulgham Exp $
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
	  --inputfile ../../website/desc/knucleotide-input.txt \
	  --geninput

include ../../Make.footer
