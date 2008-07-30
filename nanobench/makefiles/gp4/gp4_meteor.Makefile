# The Computer Language Benchmarks Game
# $Id: gp4_meteor.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := meteor
TITLE   := Meteor Puzzle Solver

CLEANOPTS := $(CLEANOPTS) -IL StdLib


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 2098


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
