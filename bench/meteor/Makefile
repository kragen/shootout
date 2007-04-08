# $Id: Makefile,v 1.2 2007-04-08 00:04:07 bfulgham Exp $
include ../../Make.header

TEST    := meteor
TITLE   := Meteor Puzzle Solver

CLEANOPTS := $(CLEANOPTS) -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-IL StdLib


RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 0

include ../../Make.footer
