# $Id: Makefile,v 1.9 2004-08-11 15:09:03 bfulgham Exp $
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
	  --ignore matrix.mawk,matrix.gawk,matrix.gcj,matrix.nice \
	  --range 1,100,200,300

include ../../Make.footer
