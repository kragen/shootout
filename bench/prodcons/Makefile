# $Id: Makefile,v 1.5 2004-06-14 07:07:10 bfulgham Exp $
include ../../Make.header

TEST    := prodcons
TITLE   := Producer/Consumer Threads
GCCOPTS    := $(GCCOPTS) -lpthread
GXXLDOPTS  := $(GXXLDOPTS) -lpthread
OCAMLBOPTS := $(OCAMLBOPTS) -thread unix.cma threads.cma
OCAMLOPTS  := $(OCAMLOPTS) -thread unix.cmxa threads.cmxa
GHCOPTS    := -package concurrent

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore prodcons.erlang \
	  --ignore prodcons.hipe \
	  --ignore prodcons.mlton2.mlton \
	  --ignore prodcons.perl \
	  --ignore prodcons.rep \
	  --range 10000,30000,70000,100000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
