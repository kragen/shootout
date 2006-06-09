# $Id: Makefile,v 1.28 2006-06-09 23:27:20 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
ERLFLAGS := -noinput
NHC98OPTS := -package base
MB_NHCRTS := +RTS -H10M -RTS
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
GHCOPTS  := -package data
POLYOPTS := -q
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --range 4,8,12,16,18

include ../../Make.footer
