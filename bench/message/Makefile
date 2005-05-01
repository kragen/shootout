# $Id: Makefile,v 1.4 2005-05-01 12:04:33 igouy-guest Exp $
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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 50,100,150

include ../../Make.footer
