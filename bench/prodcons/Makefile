# $Id: Makefile,v 1.20 2004-11-10 06:59:16 bfulgham Exp $
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
	  --range 30000,70000,100000,150000

include ../../Make.footer
