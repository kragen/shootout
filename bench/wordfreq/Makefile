# $Id: Makefile,v 1.20 2004-09-13 01:24:30 bfulgham Exp $
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
	  --range 5,10,15,20,25 \
	  --inputfile Input --geninput \
	  --ignore wordfreq.csharp \
	  --ignore wordfreq.mawk \
	  --ignore wordfreq.nice

include ../../Make.footer
