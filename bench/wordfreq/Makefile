# $Id: Makefile,v 1.24 2004-11-10 06:40:31 bfulgham Exp $
include ../../Make.header

TEST    := wordfreq
TITLE   := Word Frequency
SE_OPTS := -case_insensitive
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h
MB_NHCRTS := +RTS -H40M
NHC98OPTS := -package base
CLEANOPTS := -nr -ou -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 5,10,15,20,25 \
	  --inputfile Input --geninput

include ../../Make.footer
