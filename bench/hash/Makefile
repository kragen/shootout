# $Id: Makefile,v 1.26 2004-11-23 08:08:43 bfulgham Exp $
include ../../Make.header

TEST    := hash
TITLE   := Hash (Associative Array) Access

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/mlton-src/basic.sml \
		../../Include/mlton-src/hash-table.sml

GHCOPTS := -package data -O2
MB_GHCRTS  := +RTS -K10000000
NHC98OPTS := -package base
MB_NHCRTS := +RTS -H40M
HUGS_FLAGS := -h10000000

ERLFLAGS := -noinput
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 40000,60000,80000,100000 \
	  --ignore hash.nhc98 \
	  --ignore hash.elastic

include ../../Make.footer
