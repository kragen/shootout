# The Computer Language Benchmarks Game
# $Id: u64q_knucleotide.Makefile,v 1.2 2008-07-31 05:46:13 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis


GCCOPTS := -include Include/simple_hash.h
BIGLOOOPTS := -farithmetic
CLEANOPTS := $(CLEANOPTS) -gcm -h 64m
BIGFORTH_FLAGS := -d 16M
GFORTH_FLAGS := -m 16M
#DLANGOPTS := Include/dlang/hashtable.d
DLANGOPTS := Include/dlang/simple_hash.d
GNATOPTS := -static -E -gnatf -gnatU -gnatwcdfijklmopruvz -gnati1 -gnatT4 -fPIC -gnatn -Wuninitialized -gnatA


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 10000,100000,1000000 \
	  --data $(DATA_ROOT)/knucleotide-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
