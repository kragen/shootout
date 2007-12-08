# $Id: Makefile,v 1.31 2007-12-08 03:58:38 bfulgham Exp $
include ../../Make.header

TEST    := regexmatch
TITLE   := Regular Expression Matching
CYCOPTS  := -lpcre
GXXOPTS   := $(GXXOPTS) -I/usr/local/include
GXXLDOPTS := $(GXXLDOPTS) -lregexx -lpcre
GCCOPTS   := $(GCCOPTS) -lpcre
GDCOPTS   := $(GDCOPTS) -lpcre
OCAMLOPTS := str.cmxa
OCAMLBOPTS := str.cma
OO2COPTS := -A --no-rtc
GHCOPTS := -package text -fno-full-laziness
ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv \
		-l /usr/lib/libpcre.a
MB_CLRTS := -nr
MZSCHEMEOPTS := -qu
POLYOPTS := -q

CMUCL_SRCS := ../../Include/meta.lisp
SBCL_SRCS := ../../Include/meta.lisp


# N is # of iter

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
          --range 100,6000,9000,12000 \
	  --inputfile ../../website/desc/regexmatch-input.txt

include ../../Make.footer

