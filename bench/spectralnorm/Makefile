# $Id: Makefile,v 1.9 2006-02-03 01:23:30 ekarttun-guest Exp $
include ../../Make.header

TEST    := spectralnorm
TITLE   := Infinite Matrix Determinant Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/StdLib
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
GHCOPTS := -fexcess-precision -optc-ffast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1500,2500 --ignore spectralnorm.io

include ../../Make.footer
