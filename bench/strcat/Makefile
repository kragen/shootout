# $Id: Makefile,v 1.12 2004-08-11 15:09:07 bfulgham Exp $
include ../../Make.header

TEST    := strcat
TITLE   := String Concatenation

OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma
OO2COPTS := -A --no-rtc

GHCOPTS := -package lang
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000,40000 \
	  --sampledelay 0.1 \
	  --ignore strcat.bash \
	  --ignore strcat.elastic \
	  --ignore strcat.ghc2.ghc \
	  --ignore strcat.guile2.guile \
	  --ignore strcat.gcj \
	  --ignore strcat.gij \
	  --ignore strcat.nice \
	  --ignore strcat.oz \
	  --ignore strcat.xemacs2.xemacs

include ../../Make.footer
