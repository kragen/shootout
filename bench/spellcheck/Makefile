# $Id: Makefile,v 1.3 2004-06-13 00:16:52 bfulgham Exp $
include ../../Make.header

TEST    := spellcheck
TITLE   := Spell Checker
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h

#XLABEL  := N (number of copies of input data)

setup:
	@[ -d tmp ] || mkdir -p tmp
	@[ -f tmp/Usr.Dict.Words ] || (cd tmp ; ln -s ../Usr.Dict.Words . )


MLTONDEPS := ../../Include/sml-src/hash-string.sml \
             ../../Include/sml-src/hash-table-rep.sml \
             ../../Include/sml-src/hash-table-sig.sml \
             ../../Include/sml-src/hash-table.sml

GCCOPTS := -I ../../Include

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include -I ../../Include

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,7,10 \
	  --ignore spellcheck.se \
	  --ignore spellcheck.erlang \
	  --ignore spellcheck.clean \
	  --inputfile Input --geninput \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
