# $Id: Makefile,v 1.1 2004-12-20 07:22:31 bfulgham Exp $
include ../../Make.header

TEST    := fasta
TITLE   := FASTA DNA sequences

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 50000,100000,200000

include ../../Make.footer
