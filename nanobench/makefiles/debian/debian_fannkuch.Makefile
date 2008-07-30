# The Computer Language Benchmarks Game
# $Id: debian_fannkuch.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := fannkuch
TITLE   := Fannkuch Function


BIGLOOOPTS := -farithmetic
CLEANOPTS := $(CLEANOPTS) -nr -h 32k -s 32k

OO2COPTS := -A --no-rtc
GHCOPTS  := -fparr


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 9,10,11


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
