# $Id: Makefile,v 1.18 2004-08-11 15:09:06 bfulgham Exp $
include ../../Make.header

TEST    := spellcheck
TITLE   := Spell Checker
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h

#XLABEL  := N (number of copies of input data)

setup:
	@[ -d tmp ] || mkdir -p tmp
	@[ -f tmp/Usr.Dict.Words ] || (cd tmp ; ln -s ../Usr.Dict.Words . )


ERLFLAGS := -noinput
MLTONDEPS := ../../Include/mlton-src/basic.sml \
		../../Include/mlton-src/hash-table.sml

GCCOPTS := -I ../../Include

CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,7,10 \
	  --ignore spellcheck.nice \
	  --ignore spellcheck.erlang \
	  --ignore spellcheck.gcj \
	  --ignore spellcheck.hipe \
	  --inputfile Input --geninput

include ../../Make.footer
