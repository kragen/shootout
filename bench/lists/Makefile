# $Id: Makefile,v 1.5 2004-06-13 00:16:42 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include -I ../../Include

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.ghc \
	  --ignore lists.mercury \
	  --ignore lists.oz \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
