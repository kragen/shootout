# $Id: Makefile,v 1.3 2004-05-23 07:46:30 bfulgham Exp $
include ../../Make.header

TEST    := lists
TITLE   := List Processing

LOCDEPS := --dep=se:../Include/doubly_linked_list.e

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,4,8,12,16 \
	  --ignore lists.ghc \
	  --ignore lists.mercury \
	  --ignore lists.mlton \
	  --ignore lists.oz \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
