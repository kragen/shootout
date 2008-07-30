# The Computer Language Benchmarks Game
# $Id: u64q_nbody.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := nbody
TITLE   := N-Body orbit simulation


COPTS := -mfpmath=sse -msse2 
OCAMLOPTS := -inline 3
CLEANOPTS := $(CLEANOPTS) -nr
GCCOPTS = -lm
#GHCOPTS := -funbox-strict-fields -fbang-patterns -optc-O2 -optc-mfpmath=sse -optc-msse2

GHCOPTS := -funbox-strict-fields -fbang-patterns -optc-O2


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 200000,2000000,20000000 \
	  --ndiff "-abserr 1.0e-8"


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
