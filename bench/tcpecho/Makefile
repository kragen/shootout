# $Id: Makefile,v 1.3 2005-04-01 00:32:33 bfulgham Exp $
include ../../Make.header

TEST    := tcpecho
TITLE   := 64 byte reply to TCP/IP request

#XLABEL  := N (number of iterations)

BIGLOOOPTS := -farithmetic
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
GHCOPTS := -fexcess-precision
GPLCOPTS := --fast-math
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6,8,10

include ../../Make.footer
