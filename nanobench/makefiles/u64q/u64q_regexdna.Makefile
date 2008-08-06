# The Computer Language Benchmarks Game
# $Id: u64q_regexdna.Makefile,v 1.2 2008-08-06 14:47:59 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := regexdna
TITLE   := Match DNA 8-mers and substitute expanded IUB codes


#XLABEL  := N (number of iterations)

BIGLOOOPTS := -farithmetic
GFORTH_FLAGS := -m 16M
BIGFORTH_FLAGS := -m 64M
ERLFLAGS := -noinput -noshell -run
OCAMLOPTS := str.cmxa
GCCOPTS := -lpcre
ICCOPTS := -lpcre
GHCOPTS  := -package regex-posix -optc-O3 
GXXLDOPTS := -lboost_regex
ICPCOPTS :=  -L/usr/lib -lboost_regex
#DLANGOPTS := -L-lpcre
PHPOPTS := -d memory_limit=64M


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 50000,500000,5000000 \
	  --data ../regexdna-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
