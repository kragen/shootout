# $Id: Makefile,v 1.4 2005-05-01 12:04:34 igouy-guest Exp $
include ../../Make.header

TEST    := revcomp
TITLE   := Reverse Complement DNA sequence

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr
 
BIGLOOOPTS := -farithmetic
OO2COPTS :=  -A --no-rtc
POLYOPTS := -q
GNATOPTS := -fno-unroll-loops

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000 \
	  --inputfile ../../website/desc/revcomp-input.txt \
	  --uniqueinput

include ../../Make.footer
