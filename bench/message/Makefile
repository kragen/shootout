# $Id: Makefile,v 1.2 2005-03-25 07:59:07 bfulgham Exp $
include ../../Make.header

TEST    := message
TITLE   := IPC Message Count

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q
OCAMLOPTS := unix.cmxa -I +threads threads.cmxa
OCAMLBOPTS := unix.cma -I +threads threads.cma

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 50,100,150

include ../../Make.footer
