# $Id: Makefile,v 1.2 2005-03-25 07:59:08 bfulgham Exp $
include ../../Make.header

TEST    := process
TITLE   := Process Instantiation Test

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 1000,2000,3000 --ignore process.sablevm

include ../../Make.footer
