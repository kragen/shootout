# $Id: Makefile,v 1.4 2004-06-15 05:45:40 bfulgham Exp $
include ../../Make.header

TEST    := wordfreq
TITLE   := Word Frequency
SE_OPTS := -case_insensitive
GHCOPTS := -package data
LOCDEPS := --dep=gcc:../Include/simple_hash.h

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1,5,10,15,20 \
	  --inputfile Input --geninput \
	  --ignore wordfreq.bash \
	  --ignore wordfreq.mawk \
	  --ignore wordfreq.cmucl \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
