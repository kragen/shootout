# $Id: Makefile,v 1.1 2004-05-19 18:10:56 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --range 4,8,12,16 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
