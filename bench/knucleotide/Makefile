# $Id: Makefile,v 1.25 2007-04-08 00:20:14 bfulgham Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -gcm -h 64m -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
DLANGOPTS := ../../Include/dlang/hashtable.d
#ERLFLAGS := -noinput
BIGFORTHOPTS := -d 8M
GFORTH_FLAGS := -m 8M
GHCOPTS := -fglasgow-exts -fbang-patterns -funbox-strict-fields
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
