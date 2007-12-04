# $Id: Makefile,v 1.26 2007-12-04 06:32:38 bfulgham Exp $
include ../../Make.header

TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -gcm -h 64m -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGFORTHOPTS := -d 8M
BIGLOOOPTS := -farithmetic
DLANGOPTS := ../../Include/dlang/hashtable.d
#ERLFLAGS := -noinput
GFORTH_FLAGS := -m 8M
GHCOPTS := -fglasgow-exts -fbang-patterns -funbox-strict-fields
GPLCOPTS := --fast-math
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,100000,1000000 \
	  --inputfile ../../website/desc/knucleotide-input.txt \
	  --ignore knucleotide.bigforth-2.bigforth \
	  --uniqueinput

include ../../Make.footer
