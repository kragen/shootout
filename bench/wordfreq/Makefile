# $Id: Makefile,v 1.6 2004-06-18 08:08:22 dbr-guest Exp $
include ../../Make.header

TEST    := wordfreq
TITLE   := Word Frequency
SE_OPTS := -case_insensitive
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore wordfreq.bash \
	  --ignore wordfreq.mawk \
	  --ignore wordfreq.cmucl

include ../../Make.footer
