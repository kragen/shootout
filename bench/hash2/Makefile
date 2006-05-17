# $Id: Makefile,v 1.21 2006-05-17 04:30:40 bfulgham Exp $
include ../../Make.header

TEST    := hash2
TITLE   := Hashes Part II

LOCDEPS := --dep=gcc:../Include/simple_hash.h

CYCOPTS := -I../../Include/cyclone
ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
OO2COPTS := -A --no-rtc
NHC98OPTS := -package base
MB_NHCRTS := +RTS -H40M
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 50,100,150,200 

include ../../Make.footer
