# $Id: Makefile,v 1.14 2004-07-31 09:19:11 bfulgham Exp $
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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore wordfreq.csharp \
	  --ignore wordfreq.erlang \
	  --ignore wordfreq.gst \
	  --ignore wordfreq.hipe \
	  --ignore wordfreq.mawk

include ../../Make.footer
