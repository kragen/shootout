# $Id: Makefile,v 1.2 2004-05-21 02:59:37 bfulgham Exp $
include ../../Make.header

TEST    := echo
TITLE   := Echo Client/Server
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS  := -fglasgow-exts -package net -package concurrent -package lang
MB_GHCRTS  := +RTS -M200m -K20m

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --commandline 'tcl: ../tclwrapper ../%X %A' \
	  --ignore echo.guile \
	  --range 10000,40000,70000,100000 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
