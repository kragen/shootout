# $Id: Makefile,v 1.1 2005-08-19 06:41:45 igouy-guest Exp $
include ../../Make.header

TEST    := tcpsocket
TITLE   := 64 byte, 4K, 4096K replies to TCP/IP request

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
	  --range 400,800,1200

include ../../Make.footer
