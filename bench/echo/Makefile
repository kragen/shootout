# $Id: Makefile,v 1.1 2004-05-19 18:09:34 bfulgham Exp $
include ../../Make.header

TEST    := echo
TITLE   := Echo Client/Server
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS  := -package net -package concurrent -package lang

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --commandline 'tcl: ../tclwrapper ../%X %A' \
	  --ignore echo.guile \
	  --range 10000,40000,70000,100000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
