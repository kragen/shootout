# The Computer Language Benchmarks Game
# $Id: gp4_mandelbrot.Makefile,v 1.2 2008-08-05 14:37:47 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := mandelbrot
TITLE   := Mandelbrot Sets


CLEANOPTS := $(CLEANOPTS) -nr
OCAMLOPTS := -inline 40

GCCOPTS := -D_ISOC9X_SOURCE -mfpmath=sse -msse2 -lm
GHCOPTS  := -fbang-patterns -funbox-strict-fields -optc-O2 -optc-mfpmath=sse -optc-msse2


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	--range 800,1600,3200 \
	--binarycmp


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
