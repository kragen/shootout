# $Id: Makefile,v 1.19 2004-10-11 04:47:25 bfulgham Exp $
include ../../Make.header

TEST    := echo
TITLE   := Echo Client/Server
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS  := -fglasgow-exts -package net -package concurrent -package lang
MB_GHCRTS  := +RTS -M200m -K20m
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
POLYOPTS := -q

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --ignore echo.guile \
	  --ignore echo.csharp \
	  --ignore echo.gcl \
	  --ignore echo.nice \
	  --ignore echo.oz \
	  --ignore echo.poplisp \
	  --range 40000,70000,100000,150000

include ../../Make.footer
