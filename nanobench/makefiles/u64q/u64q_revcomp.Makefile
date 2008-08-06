# The Computer Language Benchmarks Game
# $Id: u64q_revcomp.Makefile,v 1.2 2008-08-06 14:47:59 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := revcomp
TITLE   := Reverse Complement DNA sequence


CLEANOPTS := $(CLEANOPTS) -nr -h 40m -s 1m
BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 16M
BIGFORTH_FLAGS := -d 32M
GHCOPTS := -funfolding-use-threshold=32 -optc-O3
GROOVYFLAGS := $(GROOVYFLAGS) -Xmx256m


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 250000,2500000,25000000 \
	  --data ../revcomp-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
