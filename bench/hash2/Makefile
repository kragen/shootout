# $Id: Makefile,v 1.2 2004-05-23 05:50:10 bfulgham Exp $
include ../../Make.header

TEST    := hash2
TITLE   := Hashes Part II

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/sml-src/hash-string.sml \
             ../../Include/sml-src/hash-table-rep.sml \
             ../../Include/sml-src/hash-table-sig.sml \
             ../../Include/sml-src/hash-table.sml

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10,50,100,150 \
	  --ignore hash2.bash,hash2.se \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
