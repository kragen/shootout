# $Id: Makefile,v 1.1 2004-05-19 18:11:33 bfulgham Exp $
include ../../Make.header

TEST    := regsub
TITLE   := Regular Expression Substitution

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 4,8,12 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
