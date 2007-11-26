# $Id: Makefile,v 1.3 2007-11-26 03:37:08 igouy-guest Exp $
include ../../Make.header

TEST    := meteor
TITLE   := Meteor Puzzle Solver

CLEANOPTS := $(CLEANOPTS) -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-IL StdLib

GHCOPTS := -funfolding-use-threshold=32 -O2 -optc-O3


RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 0

include ../../Make.footer
