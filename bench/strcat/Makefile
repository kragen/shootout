# $Id: Makefile,v 1.1 2004-05-19 18:13:33 bfulgham Exp $
include ../../Make.header

TEST    := strcat
TITLE   := String Concatenation

OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS := -package lang

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,20000,30000,40000 \
	  --sampledelay 0.1 \
	  --ignore strcat.bash \
	  --ignore strcat.ghc2.ghc \
	  --ignore strcat.guile2.guile \
	  --ignore strcat.java2.java \
	  --ignore strcat.se \
	  --ignore strcat.smlnj2.smlnj \
	  --ignore strcat.xemacs2.xemacs \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
