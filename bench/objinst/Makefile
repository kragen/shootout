# $Id: Makefile,v 1.12 2004-10-05 02:29:30 bfulgham Exp $
include ../../Make.header

TEST    := objinst
TITLE   := Object Instantiation

ERLFLAGS := -noinput
LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
NHC98OPTS := -package base
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400000,700000,1000000,1500000 \
	  --ignore objinst.csharp \
	  --ignore objinst.xemacs

include ../../Make.footer
