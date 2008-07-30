# The Computer Language Benchmarks Game
# $Id: debian_revcomp.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

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
	  --range 25000,250000,2500000 \
	  --data $(DATA_ROOT)/revcomp-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
