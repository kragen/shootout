# $Id: Makefile,v 1.3 2004-06-16 04:38:25 bfulgham Exp $
include ../../Make.header

TEST    := hash2
TITLE   := Hashes Part II

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/sml-src/hash-string.sml \
             ../../Include/sml-src/hash-table-rep.sml \
             ../../Include/sml-src/hash-table-sig.sml \
             ../../Include/sml-src/hash-table.sml

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10,50,100,150 \
	  --ignore hash2.bash,hash2.se \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
