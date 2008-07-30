# The Computer Language Benchmarks Game
# $Id: u64q_nsieve.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := nsieve
TITLE   := Sieve Test


BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 16M
CLEANOPTS := $(CLEANOPTS) -nr -h 10m 
PHPOPTS := -d memory_limit=64M
GCCOPTS := -std=c99
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma
BIGFORTH_FLAGS := -d 16M

SWIFLAGS := -q -O -nodebug -G0 -g main 
#JRUBYFLAGS := -J-server -J-Djruby.jit.threshold=0 -O


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 7,8,9


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
