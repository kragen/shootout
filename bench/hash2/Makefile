# $Id: Makefile,v 1.18 2004-11-10 06:36:29 bfulgham Exp $
include ../../Make.header

TEST    := hash2
TITLE   := Hashes Part II

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/mlton-src/basic.sml \
		../../Include/mlton-src/hash-table.sml

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
NHC98OPTS := -package base
MB_NHCRTS := +RTS -H40M
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 50,100,150,200 

include ../../Make.footer
