# $Id: Makefile,v 1.1 2004-05-19 18:10:40 bfulgham Exp $
include ../../Make.header

TEST    := methcall
TITLE   := Method Calls

LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 100000,400000,700000,1000000 \
	  --ignore methcall.xemacs \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
