# $Id: Makefile,v 1.8 2004-07-31 09:19:00 bfulgham Exp $
include ../../Make.header

TEST    := hash2
TITLE   := Hashes Part II

LOCDEPS := --dep=gcc:../Include/simple_hash.h

MLTONDEPS := ../../Include/mlton-src/basic.sml \
		../../Include/mlton-src/hash-table.sml

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10,50,100,150 \
	  --ignore hash2.bash \
	  --ignore hash2.csharp \
	  --ignore hash2.nice \
	  --ignore hash2.oz

include ../../Make.footer
