# The Computer Language Benchmarks Game
# $Id: gp4_binarytrees.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := binarytrees
TITLE   := Allocate, walk, and free many binary trees


IFCOPTS := $(IFCOPTS) -u -what
BIGLOOOPTS := -farithmetic
CLEANOPTS := $(CLEANOPTS) -h 16m -nr
GCCOPTS := -lm
POLYOPTS := -q
PHPOPTS := -d memory_limit=128M
GHCOPTS := -fexcess-precision -fasm
BIGFORTH_FLAGS := -m 16M


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 12,14,16
 

include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile

