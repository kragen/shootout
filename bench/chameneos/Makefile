# $Id: Makefile,v 1.4 2006-01-03 20:16:48 igouy-guest Exp $
include ../../Make.header

TEST    := chameneos
TITLE   := Thread rendezvous

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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,100000,1000000

include ../../Make.footer
