# $Id: Makefile,v 1.17 2004-10-11 04:47:31 bfulgham Exp $
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
	  --range 50,100,150,200 \
	  --ignore hash2.csharp \
	  --ignore hash2.bash \
	  --ignore hash2.hugs \
	  --ignore hash2.nhc98 \
	  --ignore hash2.oz \
	  --ignore hash2.poplisp

include ../../Make.footer
