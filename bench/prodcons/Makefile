# $Id: Makefile,v 1.10 2004-07-31 09:19:03 bfulgham Exp $
include ../../Make.header

TEST    := prodcons
TITLE   := Producer/Consumer Threads
ERLFLAGS := -noinput
GCCOPTS    := $(GCCOPTS) -lpthread
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
OCAMLBOPTS := $(OCAMLBOPTS) -thread unix.cma threads.cma
OCAMLOPTS  := $(OCAMLOPTS) -thread unix.cmxa threads.cmxa
GHCOPTS    := -package concurrent
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore prodcons.csharp \
	  --ignore prodcons.perl \
	  --ignore prodcons.rep \
	  --range 10000,30000,70000,100000

include ../../Make.footer
