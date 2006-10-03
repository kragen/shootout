# $Id: Makefile,v 1.10 2006-10-03 00:49:39 igouy-guest Exp $
include ../../Make.header

TEST    := regexdna
TITLE   := Match DNA 8-mers and substitute expanded IUB codes

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr

BIGLOOOPTS := -farithmetic
DLANGOPTS := -L-lpcre
MZSCHEMEOPTS := -qu
OCAMLOPTS  := str.cmxa
OCAMLBOPTS := str.cma
OO2COPTS :=  -A --no-rtc
POLYOPTS := -q
GFORTH_FLAGS := -m 16M
BIGFORTH_FLAGS := -m 64
GNATOPTS := -fno-unroll-loops
GXXLDOPTS := -lboost_regex

#ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,300000,500000 \
	  --inputfile ../../website/desc/regexdna-input.txt \
	  --uniqueinput

include ../../Make.footer
