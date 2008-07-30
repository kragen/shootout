# The Computer Language Benchmarks Game
# $Id: u64q_partialsums.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := partialsums
TITLE   := naive summation of series


BIGLOOOPTS := -farithmetic
GNATOPTS := -lm
GCCOPTS := -lm  
GHCOPTS := -fbang-patterns


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 25000,250000,2500000 \
	  --ndiff "-abserr 1.0e-8"


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
