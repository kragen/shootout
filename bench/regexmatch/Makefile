# $Id: Makefile,v 1.2 2004-05-25 03:50:52 bfulgham Exp $
include ../../Make.header

TEST    := regexmatch
TITLE   := Regular Expression Matching
GXXOPTS   := $(GXXOPTS) -I/usr/local/include
GXXLDOPTS := $(GXXLDOPTS) -lzregx -lpcre
GCCOPTS   := $(GCCOPTS) -lpcre
OCAMLOPTS := str.cmxa pcre.cmxa
OCAMLBOPTS := str.cma pcre.cma
GHCOPTS := -package text

CMUCL_SRCS := ../../Include/meta.lisp


# N is # of iter

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 1,3000,6000,9000 \
	  --ignore regexmatch.bigloo \
	  --ignore regexmatch.g++ \
	  --inputfile Input \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
