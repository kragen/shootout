# $Id: Makefile,v 1.6 2005-05-12 21:51:38 sgeard-guest Exp $
include ../../Make.header

TEST    := spectralnorm
TITLE   := Infinite Matrix Determinant Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
MB_CLRTS := -nr
OCAMLOPTS  := -inline 10
#OCAMLBOPTS := 
OO2COPTS :=  -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100,300,500

include ../../Make.footer
