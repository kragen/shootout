# $Id: Makefile,v 1.19 2004-10-07 07:18:15 bfulgham Exp $
include ../../Make.header

TEST    := regexmatch
TITLE   := Regular Expression Matching
GXXOPTS   := $(GXXOPTS) -I/usr/local/include
GXXLDOPTS := $(GXXLDOPTS) -lzregx -lpcre
GCCOPTS   := $(GCCOPTS) -lpcre
OCAMLOPTS := str.cmxa pcre.cmxa -I +pcre
OCAMLBOPTS := str.cma pcre.cma -I +pcre
OO2COPTS := -A --no-rtc
GHCOPTS := -package text
ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-l /usr/lib/libpcre.a
MB_CLRTS := -nr
POLYOPTS := -q

CMUCL_SRCS := ../../Include/meta.lisp
SBCL_SRCS := ../../Include/meta.lisp


# N is # of iter

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 100,6000,9000,12000 \
	  --ignore regexmatch.bigloo \
	  --ignore regexmatch.csharp \
	  --ignore regexmatch.g++ \
	  --ignore regexmatch.gcj \
	  --ignore regexmatch.gij \
	  --ignore regexmatch.hugs \
	  --ignore regexmatch.java \
	  --ignore regexmatch.kaffe \
	  --ignore regexmatch.nice \
	  --ignore regexmatch.ocaml \
	  --ignore regexmatch.ocamlb \
	  --ignore regexmatch.sablevm \
	  --inputfile Input

include ../../Make.footer
