# $Id: Makefile,v 1.1 2004-05-19 18:10:22 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.ghc \
	  --ignore lists.mercury \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
