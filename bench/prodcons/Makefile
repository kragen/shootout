# $Id: Makefile,v 1.17 2004-10-05 02:29:33 bfulgham Exp $
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
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore prodcons.csharp \
	  --ignore prodcons.nice \
	  --ignore prodcons.perl \
	  --ignore prodcons.rep \
	  --range 30000,70000,100000,150000

include ../../Make.footer
