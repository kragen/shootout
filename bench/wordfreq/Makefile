# $Id: Makefile,v 1.1 2004-05-19 18:14:10 bfulgham Exp $
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
	  --ignore wordfreq.lua \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
