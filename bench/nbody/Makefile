# $Id: Makefile,v 1.26 2007-12-04 06:32:38 bfulgham Exp $
include ../../Make.header

TEST    := nbody
TITLE   := N-Body orbit simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -nr -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

MB_CLRTS := -nr
MZSCHEMEOPTS := -qu
OBJCOPTS := -std=gnu99
OCAMLOPTS := -inline 10
#OCAMLBOPTS := 
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fbang-patterns -fexcess-precision -fallow-overlapping-instances -package mtl
OBJCOPTS := -std=gnu99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200000,2000000,20000000 \
	  --ndiff "-abserr 1.0e-8"

include ../../Make.footer
