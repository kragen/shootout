# $Id: Makefile,v 1.8 2005-05-15 06:34:26 bfulgham Exp $
include ../../Make.header

TEST    := fasta
TITLE   := FASTA DNA sequences

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
OCAMLOPTS  := -inline 3
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000

include ../../Make.footer
