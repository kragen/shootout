# $Id: Makefile,v 1.15 2006-10-04 19:44:57 igouy-guest Exp $
include ../../Make.header

TEST    := revcomp
TITLE   := Reverse Complement DNA sequence

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr -h 40m -s 1m

BIGFORTHOPTS := -d 32M
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS :=  -A --no-rtc
POLYOPTS := -q
GFORTH_FLAGS := -m 16M
BIGFORTH_FLAGS := -d 32M
GNATOPTS := -fno-unroll-loops

GPLCOPTS := --fast-math
PARROTOPTS := -Oc -Cj
PHPOPTS := -d memory_limit=64M

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000 \
	  --inputfile ../../website/desc/revcomp-input.txt \
	  --uniqueinput

include ../../Make.footer
