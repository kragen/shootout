# $Id: Makefile,v 1.18 2007-12-06 15:54:05 bfulgham Exp $
include ../../Make.header

TEST    := spectralnorm
TITLE   := Infinite Matrix Determinant Test

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -IL ArgEnv -I ../../Include/clean -IL StdLib
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OBJCOPTS := -lm
OCAMLOPTS  := -inline 10
#OCAMLBOPTS := 
OO2COPTS :=  -A --no-rtc
PARROTOPTS := -j
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,3000,5500 --ignore spectralnorm.io \
	  --ignore spectralnorm.bigforth

include ../../Make.footer
