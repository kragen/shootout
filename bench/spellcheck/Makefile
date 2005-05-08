# $Id: Makefile,v 1.28 2005-05-08 20:41:19 sweeks Exp $
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


GCCOPTS := -I ../../Include
GXXOPTS := -I ../../Include
ICCOPTS := -I ../../Include
ICPPOPTS := -I ../../Include

CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,7,10,15 \
	  --inputfile ../../website/desc/spellcheck-input.txt --geninput

include ../../Make.footer
