# $Id: Makefile,v 1.6 2004-07-31 09:19:02 bfulgham Exp $
include ../../Make.header

TEST    := matrix
TITLE   := Matrix Multiplication

GCCOPTS := -funroll-loops
GXXOPTS := -funroll-loops

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore matrix.mawk,matrix.gawk,matrix.csharp \
	  --range 1,100,200,300

include ../../Make.footer
