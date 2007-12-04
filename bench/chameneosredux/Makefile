# $Id: Makefile,v 1.4 2007-12-04 06:32:37 bfulgham Exp $
include ../../Make.header

TEST    := chameneosredux
TITLE   := Thread rendezvous

#XLABEL  := N (number of iterations)

BIGLOOOPTS := -farithmetic
CALFLAGS := -Dorg.openquark.cal.machine.lecc.concurrent_runtime
GCCOPTS := -lpthread
GHCOPTS := -fbang-patterns -funbox-strict-fields
MB_GHCRTS := +RTS -K100M -RTS
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
OCAMLOPTS  := -thread unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 60000,600000,6000000 \
	  --ndiff "-relerr 0.3"

include ../../Make.footer
