# $Id: Makefile,v 1.3 2004-06-15 05:45:40 bfulgham Exp $
include ../../Make.header

TEST    := nestedloop
TITLE   := Nested Loops

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --ignore nestedloop.bash \
	  --range 4,8,12,16 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
