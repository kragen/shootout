# $Id: Makefile,v 1.8 2004-06-18 08:08:23 dbr-guest Exp $
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
	  --ignore hash.hipe

include ../../Make.footer
