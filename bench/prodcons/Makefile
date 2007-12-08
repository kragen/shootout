# $Id: Makefile,v 1.22 2007-12-08 03:58:38 bfulgham Exp $
include ../../Make.header

TEST    := prodcons
TITLE   := Producer/Consumer Threads
ERLFLAGS := -noinput
ICCOPTS    := $(ICCOPTS) -lpthread
GCCOPTS    := $(GCCOPTS) -lpthread
GDCOPTS    := $(GDCOPTS) -lpthread
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
ICPPOPTS   := $(ICPPOPTS) -lpthread
OCAMLBOPTS := $(OCAMLBOPTS) -thread unix.cma threads.cma
OCAMLOPTS  := $(OCAMLOPTS) -thread unix.cmxa threads.cmxa
GHCOPTS    := -package concurrent
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 30000,70000,100000,150000

include ../../Make.footer
