# $Id: Makefile,v 1.3 2004-06-06 01:01:39 bfulgham Exp $
include ../../Make.header

TEST    := random
TITLE   := Random Number Generator

SE_OPTS := -case_insensitive
MB_GHCRTS  := +RTS -K16000000
LOCDEPS := --dep=se:../Include/randomnumber.e

STALINOPTS := -s

#	  --ignore random.bigforth,random.icon,random.rep,random.njs \

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore random.bigforth,random.njs \
	  --range 1000,300000,600000,900000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
