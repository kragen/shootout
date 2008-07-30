# The Computer Language Benchmarks Game
# $Id: u64q_regexdna.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

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
	  --range 100000,300000,500000 \
	  --data $(DATA_ROOT)/regexdna-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
