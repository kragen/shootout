# $Id: Makefile,v 1.12 2006-07-16 15:37:36 bfulgham Exp $
include ../../Make.header

TEST    := revcomp
TITLE   := Reverse Complement DNA sequence

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr -h 40m -s 1m
 
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS :=  -A --no-rtc
POLYOPTS := -q
GFORTH_FLAGS := -m 16M
GNATOPTS := -fno-unroll-loops

GPLCOPTS := --fast-math
PARROTOPTS := -Oc -Cj

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 25000,250000,2500000 \
	  --inputfile ../../website/desc/revcomp-input.txt \
	  --uniqueinput

include ../../Make.footer
