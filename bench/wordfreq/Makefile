# $Id: Makefile,v 1.10 2004-07-01 05:24:02 bfulgham Exp $
include ../../Make.header

TEST    := wordfreq
TITLE   := Word Frequency
SE_OPTS := -case_insensitive
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h
CLEANOPTS := -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore wordfreq.bash \
	  --ignore wordfreq.csharp \
	  --ignore wordfreq.erlang \
	  --ignore wordfreq.hipe \
	  --ignore wordfreq.mawk \
#	  --ignore wordfreq.cmucl \
	  --ignore wordfreq.sbcl

include ../../Make.footer
