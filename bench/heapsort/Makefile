# $Id: Makefile,v 1.1 2004-05-19 18:10:07 bfulgham Exp $
include ../../Make.header

TEST    := heapsort
TITLE   := Heapsort

SE_OPTS := -case_insensitive
LOCDEPS := --dep=se:../Include/randomnumber.e

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore heapsort.icon \
	  --ignore heapsort.bigforth \
	  --ignore heapsort.njs \
	  --ignore heapsort.rep \
          --range 1000,20000,40000,60000,80000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
