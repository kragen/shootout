# $Id: Makefile,v 1.1 2004-05-19 18:12:59 bfulgham Exp $
include ../../Make.header

TEST    := spellcheck
TITLE   := Spell Checker
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h

#XLABEL  := N (number of copies of input data)

setup:
	@[ -d tmp ] || mkdir -p tmp
	@[ -f tmp/Usr.Dict.Words ] || (cd tmp ; ln -s ../Usr.Dict.Words . )


MLTONDEPS := /usr/local/smlnj/src/smlnj-lib/Util/hash-string.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table-rep.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table-sig.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table.sml

GCCOPTS := -I ../../Include

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,7,10 \
	  --ignore spellcheck.se \
	  --inputfile Input --geninput \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
