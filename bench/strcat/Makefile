# $Id: Makefile,v 1.18 2005-03-02 06:24:28 bfulgham Exp $
include ../../Make.header

TEST    := strcat
TITLE   := String Concatenation

OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma
OO2COPTS := -A --no-rtc
POLYOPTS := -q

GHCOPTS := -package lang
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000,40000 \
	  --sampledelay 0.1 \
	  --ignore strcat.poly \
	  --ignore strcat.elastic

include ../../Make.footer
