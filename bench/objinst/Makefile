# $Id: Makefile,v 1.6 2004-07-27 06:51:23 bfulgham Exp $
include ../../Make.header

TEST    := objinst
TITLE   := Object Instantiation

LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,400000,700000,1000000 \
	  --ignore objinst.csharp \
	  --ignore objinst.nice \
	  --ignore objinst.gcj,objinst.gij \
	  --ignore objinst.xemacs

include ../../Make.footer
