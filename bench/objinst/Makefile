# $Id: Makefile,v 1.7 2004-07-31 09:19:03 bfulgham Exp $
include ../../Make.header

TEST    := objinst
TITLE   := Object Instantiation

ERLFLAGS := -noinput
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
