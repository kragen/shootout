# The Computer Language Benchmarks Game
# $Id: u64q.site.Makefile,v 1.3 2008-07-31 05:46:13 igouy-guest Exp $


### ROOT DIRS

# MUST set SITE_NAME and local SITE_ROOT

SITE_NAME := u64q
SITE_ROOT := ~/Documents/benchmarksgame

# source in CVS
SOURCE_ROOT := ~/shootout/bench

# nanobench in CVS
NANO_ROOT := ~/shootout/nanobench


### SWEEP DIRS 

# if not empty, somewhere all csv summary files should be put
CSV_SWEEP := $(SITE_ROOT)/_data

# if not empty, somewhere all highlight-ed xml code files should be put
CODE_SWEEP := $(SITE_ROOT)/_code

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
 nsievebits \
 partialsums \



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
 parrot slang octave cyc tcc gwydion regina bigloo cmucl objc \
 neko xds stx proto icon io newlisp iron java14 znn \
 ooc cint gcj icc icpp g95 ifc fbasic rebol bigforth \
 squeak vw rhino sbcl mercury smlnj ruby cal gst yarv oz jruby se gnat \
 chicken groovy fsharp lisaac dlang clean psyco luajit ikarus gforth \




SITE_MAKEFILES := $(MAKE_ROOT)/$(SITE_NAME)

.EXPORT_ALL_VARIABLES:


include $(MAKE_ROOT)/all.Makefile



