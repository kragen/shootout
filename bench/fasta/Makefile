# $Id: Makefile,v 1.15 2007-03-06 04:59:02 bfulgham Exp $
include ../../Make.header

TEST    := fasta
TITLE   := FASTA DNA sequences

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OCAMLOPTS  := -inline 3
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GHCOPTS := -fbang-patterns -fexcess-precision
GPLCOPTS := --fast-math
PARROTOPTS := -Cj

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000 --ignore fasta.bigforth-2.bigforth

include ../../Make.footer
