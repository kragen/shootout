# The Computer Language Benchmarks Game
# $Id: u64q_spectralnorm.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := spectralnorm
TITLE   := Infinite Matrix Determinant Test


GXXOPTS := -mfpmath=sse -msse2
OCAMLOPTS  := -inline 10
CLEANOPTS := $(CLEANOPTS) -IL StdLib
BIGLOOOPTS := -farithmetic
GCCOPTS := -lm
GHCOPTS := -fbang-patterns -optc-O3 -optc-mfpmath=sse -optc-msse2


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 500,3000,5500


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
