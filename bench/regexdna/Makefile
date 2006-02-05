# $Id: Makefile,v 1.4 2006-02-05 23:18:50 chris00-guest Exp $
include ../../Make.header

TEST    := regexdna
TITLE   := Match DNA 8-mers and substitute expanded IUB codes

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr

OCAMLOPTS  := str.cmxa
OCAMLBOPTS := str.cma

BIGLOOOPTS := -farithmetic
OO2COPTS :=  -A --no-rtc
PARROTOPTS := -j
POLYOPTS := -q
GFORTH_FLAGS := -m 16M
GNATOPTS := -fno-unroll-loops

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,300000,500000 \
	  --inputfile ../../website/desc/regexdna-input.txt \
	  --uniqueinput

include ../../Make.footer
