# $Id: Makefile,v 1.23 2006-06-09 23:27:20 bfulgham Exp $
include ../../Make.header

TEST    := matrix
TITLE   := Matrix Multiplication

ERLFLAGS := -noinput -noshell
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
OO2COPTS := -A --no-rtc
MZSCHEMEOPTS := -qu
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 10,200,400,600

include ../../Make.footer
