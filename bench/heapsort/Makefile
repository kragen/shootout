# $Id: Makefile,v 1.4 2004-06-14 07:07:10 bfulgham Exp $
include ../../Make.header

TEST    := heapsort
TITLE   := Heapsort

SE_OPTS := -case_insensitive
LOCDEPS := --dep=se:../Include/randomnumber.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include -I ../../Include


RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore heapsort.bigforth \
	  --ignore heapsort.erlang \
	  --ignore heapsort.hipe \
	  --ignore heapsort.icon \
	  --ignore heapsort.njs \
	  --ignore heapsort.rep \
	  --ignore heapsort.stalin \
          --range 1000,20000,40000,60000,80000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
