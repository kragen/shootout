# $Id: Makefile,v 1.16 2004-08-05 07:07:06 bfulgham Exp $
include ../../Make.header

TEST    := wordfreq
TITLE   := Word Frequency
SE_OPTS := -case_insensitive
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h
CLEANOPTS := -nr -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore wordfreq.csharp \
	  --ignore wordfreq.erlang \
	  --ignore wordfreq.gcj \
	  --ignore wordfreq.hipe \
	  --ignore wordfreq.nice \
	  --ignore wordfreq.mawk

include ../../Make.footer
