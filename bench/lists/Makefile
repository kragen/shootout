# $Id: Makefile,v 1.8 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.cmucl \
	  --ignore lists.ghc \
	  --ignore lists.guile \
	  --ignore lists.mercury

include ../../Make.footer
