# The Computer Language Benchmarks Game
# $Id: debian_nsievebits.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := nsievebits
TITLE   := Sieve (Bit) Test


MB_CLRTS := -nr
CLEANOPTS := $(CLEANOPTS) -nr -h 10m
BIGFORTH_FLAGS := -d 4M
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
OCAMLOPTS := bigarray.cmxa
OCAMLBOPTS := bigarray.cma
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M

GPLCOPTS := --fast-math


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 9,10,11


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
