# $Id: Makefile,v 1.31 2006-05-17 04:30:40 bfulgham Exp $
include ../../Make.header

TEST    := hash
TITLE   := Hash (Associative Array) Access

LOCDEPS := --dep=gcc:../Include/simple_hash.h

CYCOPTS := -I../../Include/cyclone
GHCOPTS := -package data
MB_GHCRTS  := +RTS -K10000000
NHC98OPTS := -package base
MB_NHCRTS := +RTS -H40M
HUGS_FLAGS := -h10000000

ERLFLAGS := -noinput
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -h 10000000
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 40000,60000,80000,100000

include ../../Make.footer
