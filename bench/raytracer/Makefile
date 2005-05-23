# $Id: Makefile,v 1.3 2005-05-23 09:32:27 chris00-guest Exp $
include ../../Make.header

TEST    := raytracer
TITLE   := Ray Tracer

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -std=c99 -ffast-math -lm

BIGLOOOPTS := -farithmetic
MB_CLRTS := -nr
OCAMLOPTS := -ffast-math -inline 3
#OCAMLBOPTS := 
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 64,128,256

include ../../Make.footer
