# The Computer Language Benchmarks Game
# $Id: debian_recursive.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := recursive
TITLE   := naive recursive functions


BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -d 8M -r 8M
BIGFORTH_FLAGS := -m 32M -s 16M -r 8M
GHCOPTS := -optc-O2 -optc-mfpmath=sse -optc-msse2
BIGFORTH_FLAGS := -m 32M -s 16M -r 8M
JDKFLAGS := -Xss32m
PNETFLAGS := -S 64 
GROOVYFLAGS := $(GROOVYFLAGS) -Xss32m
JRUBYFLAGS := $(JRUBYFLAGS) -J-Xss32m


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 5,6,7


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
