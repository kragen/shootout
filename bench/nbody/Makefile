# $Id: Makefile,v 1.8 2005-04-01 23:59:20 chris00-guest Exp $
include ../../Make.header

TEST    := nbody
TITLE   := N-Body orbit simulation

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

BIGLOOOPTS := -farithmetic
MB_CLRTS := -nr
OCAMLOPTS := -ffast-math -inline 3
#OCAMLBOPTS := 
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 600000,800000,1000000

include ../../Make.footer
