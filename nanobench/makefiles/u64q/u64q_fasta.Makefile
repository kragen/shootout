# The Computer Language Benchmarks Game
# $Id: u64q_fasta.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := fasta
TITLE   := FASTA DNA sequences


COPTS := -mfpmath=sse -msse2 
BIGLOOOPTS := -farithmetic
CLEANOPTS := $(CLEANOPTS) -nr
OCAMLOPTS  := -inline 3
JRUBYFLAGS := $(JRUBYFLAGS) -J-Xmx480m
GHCOPTS := -optc-mfpmath=sse -optc-msse2


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 250000,2500000,25000000


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
