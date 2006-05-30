# $Id: Makefile,v 1.7 2006-05-30 21:50:15 igouy-guest Exp $
include ../../Make.header

TEST    := message
TITLE   := IPC Message Count

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2COPTS := -A --no-rtc
POLYOPTS := -q
OCAMLOPTS  := -thread   unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GXXLDOPTS  := $(GXXLDOPTS) -lpthread

GCCOPTS :=  $(GCCOPTS) -lpthread
ICCOPTS := $(ICCOPTS) -lpthread

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,2000,3000

include ../../Make.footer
