# $Id: Makefile,v 1.2 2007-03-06 04:59:02 bfulgham Exp $
include ../../Make.header

TEST    := magicsquares
TITLE   := Magic Squares

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -lm
GHCOPTS := -funbox-strict-fields
MB_GHCRTS := -H20m

MB_CLRTS := -nr
MZSCHEMEOPTS := -qu
OBJCOPTS := -std=gnu99
OCAMLOPTS := -inline 10
#OCAMLBOPTS := 
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision -fallow-overlapping-instances -package mtl
OBJCOPTS := -std=gnu99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 3,4,5 

include ../../Make.footer
