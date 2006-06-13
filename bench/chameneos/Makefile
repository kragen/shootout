# $Id: Makefile,v 1.8 2006-06-13 03:47:48 bfulgham Exp $
include ../../Make.header

TEST    := chameneos
TITLE   := Thread rendezvous

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OCAMLOPTS  := -thread   unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GXXLDOPTS := $(GXXLDOPTS) -lpthread
GCCOPTS :=  $(GCCOPTS)-lpthread
ICCOPTS := $(ICCOPTS) -lpthread

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,100000,1000000

include ../../Make.footer
