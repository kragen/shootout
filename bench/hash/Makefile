# $Id: Makefile,v 1.1 2004-05-19 18:09:56 bfulgham Exp $
include ../../Make.header

TEST    := hash
TITLE   := Hash (Associative Array) Access

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := /usr/local/smlnj/src/smlnj-lib/Util/hash-string.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table-rep.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table-sig.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table.sml

GHCOPTS := -package data -O2
MB_GHCRTS  := +RTS -K10000000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 20000,40000,60000,80000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
