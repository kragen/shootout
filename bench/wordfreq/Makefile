# $Id: Makefile,v 1.32 2006-05-17 04:30:41 bfulgham Exp $
include ../../Make.header

TEST    := wordfreq
TITLE   := Word Frequency
SE_OPTS := -case_insensitive
CYCOPTS := -I../../Include/cyclone
GHCOPTS := -package data
GNATOPTS := -fno-unroll-loops
LOCDEPS := --dep=gcc:../Include/simple_hash.h
MB_NHCRTS := +RTS -H40M
NHC98OPTS := -package base
CLEANOPTS := -nr -ou -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr
ERLFLAGS := -noinput -noshell
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 5,10,15,20,25 \
	  --inputfile ../../website/desc/wordfreq-input.txt --geninput 

include ../../Make.footer
