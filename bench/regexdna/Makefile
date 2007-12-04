# $Id: Makefile,v 1.15 2007-12-04 06:32:39 bfulgham Exp $
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
GCCOPTS := -lpcre
MZSCHEMEOPTS := -qu
OCAMLOPTS  := str.cmxa
OCAMLBOPTS := str.cma
OO2COPTS :=  -A --no-rtc
POLYOPTS := -q
GFORTH_FLAGS := -m 16M
GHCOPTS := -funbox-strict-fields -fbang-patterns -package parsec -package regex-posix
BIGFORTHOPTS := -m 64M
GNATOPTS := -fno-unroll-loops
GXXLDOPTS := -lboost_regex

#ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,300000,500000 \
	  --inputfile ../../website/desc/regexdna-input.txt \
	  --uniqueinput --ignore regexdna.erlang --ignore regexdna.hipe

include ../../Make.footer
