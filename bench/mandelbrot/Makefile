# $Id: Makefile,v 1.21 2007-12-08 03:58:37 bfulgham Exp $
include ../../Make.header

TEST    := mandelbrot
TITLE   := Mandelbrot Sets

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -nr -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -nr
MZSCHEMEOPTS := -qu
OCAMLOPTS := -inline 40
#OCAMLBOPTS := 

OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GHCOPTS  := -fglasgow-exts -fbang-patterns -funbox-strict-fields -optc-O2 -optc-msse2 -optc-march=athlon-xp
GPLCOPTS := --fast-math

GCCOPTS := -D_ISOC9X_SOURCE -mfpmath=sse -march=athlon-xp -lm
GDCOPTS := -mfpmath=sse -march=athlon-xp -lm

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400,600,3000 --ignore mandelbrot.bigforth

include ../../Make.footer
