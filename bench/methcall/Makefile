# $Id: Makefile,v 1.16 2005-03-25 07:59:07 bfulgham Exp $
include ../../Make.header

TEST    := methcall
TITLE   := Method Calls

LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput -noshell
NHC98OPTS := -package base
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,400000,700000,1000000 

include ../../Make.footer
