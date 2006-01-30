# $Id: Makefile,v 1.12 2006-01-30 01:34:38 ekarttun-guest Exp $
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
PARROTOPTS := -j
POLYOPTS := -q

ERLFLAGS := -noinput
GHCOPTS  := -fexcess-precision
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200,400,600

include ../../Make.footer
