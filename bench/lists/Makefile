# $Id: Makefile,v 1.12 2004-07-31 09:19:01 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.csharp \
	  --ignore lists.guile \
	  --ignore lists.ghc \
	  --ignore lists.nice

include ../../Make.footer
