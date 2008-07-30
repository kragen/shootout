# The Computer Language Benchmarks Game
# $Id: debian.site.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $


### ROOT DIRS

# MUST set SITE_NAME and local SITE_ROOT

SITE_NAME := debian
SITE_ROOT := ~/benchmarksgame

# source in CVS
SOURCE_ROOT := ~/shootout/bench

# nanobench in CVS
NANO_ROOT := ~/shootout/nanobench


### SWEEP DIRS 

# if not empty, somewhere all csv summary files should be put
CSV_SWEEP := $(SITE_ROOT)/data

# if not empty, somewhere all highlight-ed xml code files should be put
CODE_SWEEP := $(SITE_ROOT)/code

# if not empty, somewhere all program log files should be put
LOG_SWEEP := $(CODE_SWEEP)


### OTHER DIRS

# makefiles in CVS
MAKE_ROOT := $(NANO_ROOT)/makefiles

# scripts in CVS
NANO_BIN := $(NANO_ROOT)/bin

# data files in CVS
DATA_ROOT := $(SOURCE_ROOT)/../website/desc



# MUST set which source directories to search

SRC_DIRS := \
 fannkuch \
 knucleotide \
 nsieve \


# binarytrees \
# chameneosredux \
# fannkuch \
# fasta \
# knucleotide \
# mandelbrot \
# meteor \
# nbody \
# nsieve \
# nsievebits \
# partialsums \
# pidigits \
# recursive \
# regexdna \
# revcomp \
# spectralnorm \
# threadring 



# ALLOW these helper file extensions to be available unchanged 
# from the working directory - they will never be measured
ALLOW := \
 sq cm



# ONLY measure files with these extensions 
# if there are none, measure files with any extension not ALLOWed or IGNOREd
ONLY := \



# IGNORE files with these extensions, if there are no ONLY extensions
IGNORE := \
 parrot slang octave cyc tcc gwydion regina \
 neko xds stx proto icon \
 squeak vw rhino sbcl




SITE_MAKEFILES := $(MAKE_ROOT)/$(SITE_NAME)

.EXPORT_ALL_VARIABLES:

.PHONY: benchmarks logs highlight mkcsv $(selected_source_directories) 



all: benchmarks logs highlight




# don't seem able to get both these to work? 
# just one or the highlightother which ever happens first
#benchmarks: SUBMK := benchmarks
#benchmarks: SUBROOT := $(SOURCE_ROOT)
#benchmarks: $(selected_source_directories)

#logs: SUBMK := logs
#logs: SUBROOT := $(SITE_ROOT)
#logs: $(selected_source_directories)

#highlight: SUBMK := highlight
#highlight: SUBROOT := $(SITE_ROOT)
#highlight: $(selected_source_directories)

$(SRC_DIRS):
	-@$(MAKE) -C $(SUBROOT)/$@/log \
		-f $(SITE_MAKEFILES)/Makefile_$(SITE_NAME)_$@ $(SUBMK)




benchmarks: 
	-@for d in $(SRC_DIRS) ; do \
		( $(MAKE) -C $(SOURCE_ROOT)/$$d \
                          -f $(SITE_MAKEFILES)/$(SITE_NAME)_$$d.Makefile ) ; \
		done

mkcsv:
	@$(NANO_BIN)/mkcsv


logs: 
	-@for d in $(SRC_DIRS) ; do \
		( $(MAKE) -C $(SITE_ROOT)/$$d/log \
                          -f $(MAKE_ROOT)/website.Makefile logs) ; \
		done


highlight: 
	-@for d in $(SRC_DIRS) ; do \
		( $(MAKE) -C $(SITE_ROOT)/$$d/code \
			-f $(MAKE_ROOT)/website.Makefile highlight) ; \
		done




