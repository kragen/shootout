# $Id: Makefile,v 1.4 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := objinst
TITLE   := Object Instantiation

LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,400000,700000,1000000 \
	  --ignore objinst.xemacs

include ../../Make.footer
