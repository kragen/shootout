# $Id: Makefile,v 1.1 2004-05-19 18:10:01 bfulgham Exp $
include ../../Make.header

TEST    := hash2
TITLE   := Hashes Part II

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := /usr/local/smlnj/src/smlnj-lib/Util/hash-string.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table-rep.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table-sig.sml \
             /usr/local/smlnj/src/smlnj-lib/Util/hash-table.sml

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10,50,100,150 \
	  --ignore hash2.bash,hash2.se \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
