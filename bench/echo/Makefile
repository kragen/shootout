# $Id: Makefile,v 1.8 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := echo
TITLE   := Echo Client/Server
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS  := -fglasgow-exts -package net -package concurrent -package lang
MB_GHCRTS  := +RTS -M200m -K20m

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --ignore echo.guile \
	  --ignore echo.tcl \
	  --ignore echo.oz \
	  --range 10000,40000,70000,100000

include ../../Make.footer
