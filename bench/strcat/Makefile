# $Id: Makefile,v 1.8 2004-06-30 07:29:02 bfulgham Exp $
include ../../Make.header

TEST    := strcat
TITLE   := String Concatenation

OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS := -package lang
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000,40000 \
	  --sampledelay 0.1 \
	  --ignore strcat.bash \
	  --ignore strcat.csharp \
	  --ignore strcat.elastic \
	  --ignore strcat.ghc2.ghc \
	  --ignore strcat.guile2.guile \
	  --ignore strcat.gij \
	  --ignore strcat.se \
	  --ignore strcat.smlnj2.smlnj \
	  --ignore strcat.xemacs2.xemacs

include ../../Make.footer
