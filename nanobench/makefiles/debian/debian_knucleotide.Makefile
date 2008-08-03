# The Computer Language Benchmarks Game
# $Id: debian_knucleotide.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := knucleotide
TITLE   := K-Nucleotide sequence analysis


BIGLOOOPTS := -farithmetic
CLEANOPTS := $(CLEANOPTS) -gcm -h 64m
BIGFORTH_FLAGS := -d 8M
GFORTH_FLAGS := -m 8M
#DLANGOPTS := ../../Include/dlang/hashtable.d
DLANGOPTS := ../../Include/dlang/simple_hash.d
GNATOPTS := -static -E -gnatf -gnatU -gnatwcdfijklmopruvz -gnati1 -gnatT4 -fPIC -gnatn -Wuninitialized -gnatA


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 10000,100000,1000000 \
	  --data $(DATA_ROOT)/knucleotide-input.txt \


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile