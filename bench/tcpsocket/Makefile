# $Id: Makefile,v 1.2 2005-12-04 05:39:36 igouy-guest Exp $
include ../../Make.header

TEST    := tcpsocket
TITLE   := 64 byte, 4K, 4096K replies to TCP/IP request

#XLABEL  := N (number of iterations)

BIGLOOOPTS := -farithmetic
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GPLCOPTS := --fast-math
GHCOPTS := -package network -package unix

RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	  --range 1000,5000,9000

include ../../Make.footer
