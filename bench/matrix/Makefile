# $Id: Makefile,v 1.10 2004-08-12 16:27:04 bfulgham Exp $
include ../../Make.header

TEST    := matrix
TITLE   := Matrix Multiplication

GCCOPTS := -funroll-loops
GXXOPTS := -funroll-loops

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore matrix.mawk,matrix.gawk \
	  --range 1,100,200,300

include ../../Make.footer
