# $Id: Makefile,v 1.26 2005-03-17 22:06:45 ekarttun-guest Exp $
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
GHCOPTS  := -package data
POLYOPTS := -q
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --range 4,8,12,16,18

include ../../Make.footer
