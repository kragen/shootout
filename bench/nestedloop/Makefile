# $Id: Makefile,v 1.2 2004-06-13 00:16:44 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include -I ../../Include

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --range 4,8,12,16 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
