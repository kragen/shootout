# $Id: Makefile,v 1.16 2007-04-08 02:07:28 bfulgham Exp $
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
OCAMLOPTS  := -inline 10
#OCAMLBOPTS := 
OO2COPTS :=  -A --no-rtc
PARROTOPTS := -j
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1500,2500 --ignore spectralnorm.io \
	  --ignore spectralnorm.bigforth

include ../../Make.footer
