# $Id: Makefile,v 1.17 2004-08-10 15:16:14 bfulgham Exp $
include ../../Make.header

TEST    := hash
TITLE   := Hash (Associative Array) Access

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/mlton-src/basic.sml \
		../../Include/mlton-src/hash-table.sml

GHCOPTS := -package data -O2
MB_GHCRTS  := +RTS -K10000000

ERLFLAGS := -noinput
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 20000,40000,60000,80000 \
	  --ignore hash.elastic \
	  --ignore hash.nice \
	  --ignore hash.oz

include ../../Make.footer
