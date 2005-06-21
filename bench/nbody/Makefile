# $Id: Makefile,v 1.13 2005-06-21 05:15:30 ekarttun-guest Exp $
include ../../Make.header

TEST    := nbody
TITLE   := N-Body orbit simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

MB_CLRTS := -nr
OCAMLOPTS := -ffast-math -inline 3
#OCAMLBOPTS := 
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fno-excess-precision -fglasgow-exts -fallow-overlapping-instances

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,100000,1000000

include ../../Make.footer
