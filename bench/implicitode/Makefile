# $Id: Makefile,v 1.1 2005-04-03 15:01:52 loisel-guest Exp $
include ../../Make.header

TEST    := implicitode
TITLE   := Implicit ordinary differential equation solver

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

BIGLOOOPTS := -farithmetic
MB_CLRTS := -nr
OCAMLOPTS  := -inline 10
#OCAMLBOPTS := 
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 5,10,20,50

include ../../Make.footer
