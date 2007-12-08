# $Id: Makefile,v 1.32 2007-12-08 03:58:39 bfulgham Exp $
include ../../Make.header

TEST    := spellcheck
TITLE   := Spell Checker
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h
MB_NHCRTS := +RTS -H40M
NHC98OPTS := -package base
ERLFLAGS := -noshell

#XLABEL  := N (number of copies of input data)

setup:
	@[ -d tmp ] || mkdir -p tmp
	@[ -f tmp/Usr.Dict.Words ] || (cd tmp ; ln -s ../Usr.Dict.Words . )


CYCOPTS := -I../../Include/cyclone
GCCOPTS := -I ../../Include
GDCOPTS := -I ../../Include
GXXOPTS := -I ../../Include
ICCOPTS := -I ../../Include
ICPPOPTS := -I ../../Include

CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -h 10000000
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,7,10,15 \
	  --inputfile ../../website/desc/spellcheck-input.txt --geninput

include ../../Make.footer
