# The Computer Language Benchmarks Game
# $Id: u64q_nbody.Makefile,v 1.2 2008-08-03 20:08:11 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := nbody
TITLE   := N-Body orbit simulation


COPTS := -mfpmath=sse -msse2 
OCAMLOPTS := -inline 3
CLEANOPTS := $(CLEANOPTS) -nr
GCCOPTS = -lm
GHCOPTS := -funbox-strict-fields -fbang-patterns -optc-O2


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 500000,5000000,50000000 \
	  --ndiff "-abserr 1.0e-8"


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
