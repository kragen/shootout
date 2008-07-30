# The Computer Language Benchmarks Game
# $Id: gp4_chameneosredux.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := chameneosredux
TITLE   := Thread rendezvous


BIGLOOOPTS := -farithmetic
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
OCAMLOPTS  := -thread unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma
GCCOPTS := -lpthread
ICCOPTS := -lpthread
MB_GHCRTS := +RTS -K100M -RTS
CALFLAGS := -Dorg.openquark.cal.machine.lecc.concurrent_runtime
GHCOPTS := -fbang-patterns -funbox-strict-fields


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 60000,600000,6000000 \
	  --ndiff "-relerr 0.3"


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
