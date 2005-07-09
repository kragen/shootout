# $Id: Makefile,v 1.7 2005-07-09 09:29:43 ekarttun-guest Exp $
include ../../Make.header

TEST    := tcprequest
TITLE   := 4K reply to TCP/IP request

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -package network -package unix

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 120,160,200

include ../../Make.footer
