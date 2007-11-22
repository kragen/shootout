# $Id: Makefile,v 1.1 2007-11-22 05:49:05 igouy-guest Exp $
include ../../Make.header

TEST    := chameneosredux
TITLE   := Thread rendezvous

#XLABEL  := N (number of iterations)

BIGLOOOPTS := -farithmetic
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
OCAMLOPTS  := -thread unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma
GCCOPTS := -lpthread
MB_GHCRTS := +RTS -K100M -RTS
CALFLAGS := -Dorg.openquark.cal.machine.lecc.concurrent_runtime

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 60000,600000,6000000 \
	  --ndiff "-abserr 60"

include ../../Make.footer
