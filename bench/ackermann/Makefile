# $Id: Makefile,v 1.3 2004-06-16 04:38:24 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 4,5,6,7,8 \
	--ignore ackermann.tcl \
	--ignore ackermann.bash \
	--title "$(TITLE)" $(TEST).*

include ../../Make.footer
