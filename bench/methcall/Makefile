# $Id: Makefile,v 1.7 2004-08-04 07:39:53 bfulgham Exp $
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
	  --ignore methcall.csharp \
	  --ignore methcall.xemacs

include ../../Make.footer
