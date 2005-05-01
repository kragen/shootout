# $Id: Makefile,v 1.6 2005-05-01 12:04:33 igouy-guest Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 8M
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000 \
	  --inputfile ../../website/desc/knucleotide-input.txt \
	  --uniqueinput

include ../../Make.footer
