# $Id: Makefile,v 1.13 2004-11-10 06:47:57 bfulgham Exp $
include ../../Make.header

TEST    := matrix
TITLE   := Matrix Multiplication

GCCOPTS := -funroll-loops
GXXOPTS := -funroll-loops

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10,200,400,600

include ../../Make.footer
