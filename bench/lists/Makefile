# $Id: Makefile,v 1.15 2004-08-11 15:09:03 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.guile \
	  --ignore lists.gcj \
	  --ignore lists.ghc \
	  --ignore lists.nice

include ../../Make.footer
