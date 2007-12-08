# $Id: Makefile,v 1.12 2007-12-08 03:58:38 bfulgham Exp $
include ../../Make.header

TEST    := raytracer
TITLE   := Ray Tracer

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
#CHICKENOPTS := -O3 -d0 -C "-Os -fomit-frame-pointer -fno-strict-aliasing" -vk -unsafe-libraries

GCCOPTS := -std=c99 -ffast-math -lm
GDCOPTS := -ffast-math -lm

BIGLOOOPTS := -farithmetic

IFCOPTS	:= -u -what
MB_CLRTS := -nr
OCAMLOPTS := -inline 100
#OCAMLBOPTS := 
OO2COPTS := -A --no-rtc
PHPOPTS := -q -d max_execution_time=600
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 20,40,80,160

include ../../Make.footer
