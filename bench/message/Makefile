# $Id: Makefile,v 1.12 2007-12-08 03:58:37 bfulgham Exp $
include ../../Make.header

TEST    := message
TITLE   := IPC Message Count

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-IL StdLib

ERLFLAGS := -noinput
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
OCAMLOPTS  := -thread   unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GXXLDOPTS  := $(GXXLDOPTS) -lpthread

GCCOPTS :=  $(GCCOPTS) -lpthread
GDCOPTS := $(GDCOPTS) -lpthread
ICCOPTS := $(ICCOPTS) -lpthread

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,2000,3000 --ignore message.gcc-2.gcc

include ../../Make.footer
