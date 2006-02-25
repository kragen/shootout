# $Id: Makefile,v 1.14 2006-02-25 20:31:14 jisom-guest Exp $
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
GHCOPTS  := -fexcess-precision
GPLCOPTS := --fast-math

GCCOPTS := -D_ISOC9X_SOURCE -mfpmath=sse -msse2 -lm

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200,400,600

include ../../Make.footer
