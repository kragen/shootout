# $Id: Makefile,v 1.8 2004-06-18 08:08:22 dbr-guest Exp $
include ../../Make.header

TEST    := prodcons
TITLE   := Producer/Consumer Threads
GCCOPTS    := $(GCCOPTS) -lpthread
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
OCAMLBOPTS := $(OCAMLBOPTS) -thread unix.cma threads.cma
OCAMLOPTS  := $(OCAMLOPTS) -thread unix.cmxa threads.cmxa
GHCOPTS    := -package concurrent
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore prodcons.mlton2.mlton \
	  --ignore prodcons.perl \
	  --ignore prodcons.rep \
	  --range 10000,30000,70000,100000

include ../../Make.footer
