# The Computer Language Benchmarks Game
# $Id: u64q_revcomp.Makefile,v 1.3 2008-08-07 14:03:52 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := revcomp
TITLE   := Reverse Complement DNA sequence


CLEANOPTS := $(CLEANOPTS) -nr -h 40m -s 1m
BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 16M
BIGFORTH_FLAGS := -d 32M
GHCOPTS := -funfolding-use-threshold=32 -optc-O3
GROOVYFLAGS := $(GROOVYFLAGS) -Xmx256m
PHPOPTS := -d memory_limit=256M


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 250000,2500000,25000000 \
	  --data ../revcomp-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
