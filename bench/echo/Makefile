# $Id: Makefile,v 1.24 2005-03-25 07:59:06 bfulgham Exp $
include ../../Make.header

TEST    := echo
TITLE   := Echo Client/Server
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS  := -fglasgow-exts -package net -package concurrent -package lang
MB_GHCRTS  := +RTS -M200m -K20m
ERLFLAGS := -noinput -noshell
OO2COPTS := -A --no-rtc
POLYOPTS := -q

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --ignore echo.guile \
	  --ignore echo.oz \
	  --range 40000,70000,100000,150000

include ../../Make.footer
