# $Id: Makefile,v 1.4 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := matrix
TITLE   := Matrix Multiplication

GCCOPTS := -funroll-loops
GXXOPTS := -funroll-loops

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore matrix.mawk,matrix.gawk \
	  --range 1,100,200,300

include ../../Make.footer
