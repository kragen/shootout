# The Computer Language Benchmarks Game
# $Id: u64q_mandelbrot.Makefile,v 1.4 2008-08-03 22:24:14 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := mandelbrot
TITLE   := Mandelbrot Sets


CLEANOPTS := $(CLEANOPTS) -nr
OCAMLOPTS := -inline 40

GCCOPTS := -D_ISOC9X_SOURCE -mfpmath=sse -msse2 -lm
GHCOPTS  := -fbang-patterns -funbox-strict-fields -optc-O2 


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	--range 1600,3200,6400 \
	--binarycmp


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
