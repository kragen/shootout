# $Id: Makefile,v 1.21 2006-06-15 05:27:22 igouy-guest Exp $
include ../../Make.header

TEST    := nbody
TITLE   := N-Body orbit simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

MB_CLRTS := -nr
MZSCHEMEOPTS := -qu
OCAMLOPTS := -ffast-math -inline 10
#OCAMLBOPTS := 
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision -fallow-overlapping-instances -package mtl -optc-ffast-math
OBJCOPTS := -std=gnu99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10000,100000,1000000

include ../../Make.footer
