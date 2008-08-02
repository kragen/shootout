# The Computer Language Benchmarks Game
# $Id: gp4.site.Makefile,v 1.6 2008-08-02 04:24:52 igouy-guest Exp $


### ROOT DIRS

# MUST set SITE_NAME and local SITE_ROOT

SITE_NAME := gp4
SITE_ROOT := ~/benchmarksgame

# source in CVS
SOURCE_ROOT := ~/shootout/bench

# nanobench in CVS
NANO_ROOT := ~/shootout/nanobench


### SWEEP DIRS 

# if not empty, somewhere all csv summary files should be put
CSV_SWEEP := $(SITE_ROOT)/Data

# if not empty, somewhere all highlight-ed xml code files should be put
CODE_SWEEP := $(SITE_ROOT)/Code

# if not empty, somewhere all program log files should be put
LOG_SWEEP := $(CODE_SWEEP)


### OTHER DIRS

# makefiles in CVS
MAKE_ROOT := $(NANO_ROOT)/makefiles

# scripts in CVS
NANO_BIN := $(NANO_ROOT)/bin

# data files in CVS
DATA_ROOT := $(SOURCE_ROOT)/../website/desc

# highlight dislikes ~ in NANO_ROOT so subst them with the HOME text
expandedvars := $(subst ~,$(HOME),$(NANO_ROOT))
NANO_HIGHLIGHT := $(addsuffix /highlight/, $(expandedvars) )



# MUST set which source directories to search

SRC_DIRS := \
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
 sq cm mlb



# ONLY measure files with these extensions 
# if there are none, measure files with any extension not ALLOWed or IGNOREd
ONLY := \



# IGNORE files with these extensions, if there are no ONLY extensions
IGNORE := \
 parrot slang octave cyc tcc gwydion regina bigloo cmucl objc guile \
 neko xds stx proto newlisp \
 cmucl bigforth gforth \




SITE_MAKEFILES := $(MAKE_ROOT)/$(SITE_NAME)

.EXPORT_ALL_VARIABLES:


include $(MAKE_ROOT)/all.Makefile

