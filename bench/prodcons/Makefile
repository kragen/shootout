# $Id: Makefile,v 1.12 2004-08-10 15:16:16 bfulgham Exp $
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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore prodcons.perl \
	  --ignore prodcons.rep \
	  --range 10000,30000,70000,100000

include ../../Make.footer
