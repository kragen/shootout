# $Id: Makefile,v 1.11 2004-07-11 07:52:31 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.csharp \
	  --ignore lists.guile \
	  --ignore lists.ghc \
	  --ignore lists.nice

include ../../Make.footer
