# $Id: Makefile,v 1.9 2004-08-11 15:09:04 bfulgham Exp $
include ../../Make.header

TEST    := methcall
TITLE   := Method Calls

LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,400000,700000,1000000 \
	  --ignore methcall.xemacs \
	  --ignore methcall.gcj \
	  --ignore methcall.nice

include ../../Make.footer
