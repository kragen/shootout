# $Id: Makefile,v 1.2 2004-05-25 02:26:33 bfulgham Exp $
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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,7,10 \
	  --ignore spellcheck.se \
	  --ignore spellcheck.erlang \
	  --inputfile Input --geninput \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
