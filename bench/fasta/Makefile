# $Id: Makefile,v 1.6 2005-04-03 13:57:56 chris00-guest Exp $
include ../../Make.header

TEST    := fasta
TITLE   := FASTA DNA sequences

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
OCAMLOPTS  := -inline 3
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 50000,100000,200000

include ../../Make.footer
