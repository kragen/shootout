# $Id: Makefile,v 1.9 2004-06-19 17:00:18 bfulgham Exp $
include ../../Make.header

TEST    := hash
TITLE   := Hash (Associative Array) Access

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/mlton-src/basic.sml \
		../../Include/mlton-src/hash-table.sml

GHCOPTS := -package data -O2
MB_GHCRTS  := +RTS -K10000000

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h10000000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 20000,40000,60000,80000 \
	  --ignore hash.elastic

include ../../Make.footer
