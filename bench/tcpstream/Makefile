# $Id: Makefile,v 1.5 2005-04-01 00:32:33 bfulgham Exp $
include ../../Make.header

TEST    := tcpstream
TITLE   := 400K reply to TCP/IP request

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 30,40,50

include ../../Make.footer
