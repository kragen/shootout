# $Id: Makefile,v 1.24 2004-10-07 07:17:56 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
NHC98OPTS := -package base
MB_NHCRTS := +RTS -H10M -RTS
OO2COPTS := -A --no-rtc
GHCOPTS  := -O2 -package data
POLYOPTS := -q
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --range 4,8,12,16,18 \
	  --ignore lists.csharp \
	  --ignore lists.guile \
	  --ignore lists.hugs

include ../../Make.footer
