# $Id: Makefile,v 1.3 2004-05-25 07:41:07 bfulgham Exp $
include ../../Make.header

TEST    := regexmatch
TITLE   := Regular Expression Matching
GXXOPTS   := $(GXXOPTS) -I/usr/local/include
GXXLDOPTS := $(GXXLDOPTS) -lzregx -lpcre
GCCOPTS   := $(GCCOPTS) -lpcre
OCAMLOPTS := str.cmxa pcre.cmxa -I +pcre
OCAMLBOPTS := str.cma pcre.cma -I +pcre
GHCOPTS := -package text

CMUCL_SRCS := ../../Include/meta.lisp


# N is # of iter

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 1,3000,6000,9000 \
	  --ignore regexmatch.bigloo \
	  --ignore regexmatch.g++ \
	  --ignore regexmatch.ocaml \
	  --ignore regexmatch.ocamlb \
	  --ignore regexmatch.sablevm \
	  --inputfile Input \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
