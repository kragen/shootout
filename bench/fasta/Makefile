# $Id: Makefile,v 1.17 2007-12-04 06:32:38 bfulgham Exp $
include ../../Make.header

TEST    := fasta
TITLE   := FASTA DNA sequences

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -nr -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
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
	  --range 250000,2500000,25000000 --ignore fasta.bigforth-2.bigforth,fasta.bigforth

include ../../Make.footer
