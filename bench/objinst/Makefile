# $Id: Makefile,v 1.10 2004-08-12 16:27:15 bfulgham Exp $
include ../../Make.header

TEST    := objinst
TITLE   := Object Instantiation

ERLFLAGS := -noinput
LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,400000,700000,1000000 \
	  --ignore objinst.xemacs

include ../../Make.footer
