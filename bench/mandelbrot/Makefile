# $Id: Makefile,v 1.9 2005-08-25 19:07:12 chris00-guest Exp $
include ../../Make.header

TEST    := mandelbrot
TITLE   := Mandelbrot Sets

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr
OCAMLOPTS := -inline 40
#OCAMLBOPTS := 

OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200,400,600

include ../../Make.footer
