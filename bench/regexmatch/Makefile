# $Id: Makefile,v 1.8 2004-06-24 07:38:15 bfulgham Exp $
include ../../Make.header

TEST    := regexmatch
TITLE   := Regular Expression Matching
GXXOPTS   := $(GXXOPTS) -I/usr/local/include
GXXLDOPTS := $(GXXLDOPTS) -lzregx -lpcre
GCCOPTS   := $(GCCOPTS) -lpcre
OCAMLOPTS := str.cmxa pcre.cmxa -I +pcre
OCAMLBOPTS := str.cma pcre.cma -I +pcre
GHCOPTS := -package text
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

CMUCL_SRCS := ../../Include/meta.lisp


# N is # of iter

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 1,3000,6000,9000 \
	  --ignore regexmatch.bigloo \
	  --ignore regexmatch.csharp \
	  --ignore regexmatch.g++ \
	  --ignore regexmatch.gcj \
	  --ignore regexmatch.gij \
	  --ignore regexmatch.sablevm \
	  --inputfile Input

include ../../Make.footer
