# $Id: Makefile,v 1.5 2004-06-15 05:45:40 bfulgham Exp $
include ../../Make.header

TEST    := hash
TITLE   := Hash (Associative Array) Access

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/sml-src/hash-string.sml \
	     ../../Include/sml-src/hash-table-rep.sml \
	     ../../Include/sml-src/hash-table-sig.sml \
	     ../../Include/sml-src/hash-table.sml

GHCOPTS := -package data -O2
MB_GHCRTS  := +RTS -K10000000

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 20000,40000,60000,80000 \
	  --ignore hash.hipe \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
