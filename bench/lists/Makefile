# $Id: Makefile,v 1.7 2004-06-15 05:45:40 bfulgham Exp $
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
	  --ignore lists.mercury \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
