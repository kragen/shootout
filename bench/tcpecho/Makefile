# $Id: Makefile,v 1.4 2005-05-01 12:04:35 igouy-guest Exp $
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
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6,8,10

include ../../Make.footer
