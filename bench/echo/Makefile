# $Id: Makefile,v 1.13 2004-08-10 15:16:14 bfulgham Exp $
include ../../Make.header

TEST    := echo
TITLE   := Echo Client/Server
OCAMLOPTS := unix.cmxa
OCAMLBOPTS := unix.cma

GHCOPTS  := -fglasgow-exts -package net -package concurrent -package lang
MB_GHCRTS  := +RTS -M200m -K20m
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
RUNTESTS := $(MINIBENCH) --conf ./Minibench.conf \
	  --ignore echo.guile \
	  --ignore echo.oz \
	  --range 10000,40000,70000,100000

include ../../Make.footer
