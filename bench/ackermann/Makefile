# $Id: Makefile,v 1.4 2004-06-18 07:02:44 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 4,5,6,7,8 \
	--ignore ackermann.bash \
	--ignore ackermann.tcl \
	--title "$(TITLE)" $(TEST).*

include ../../Make.footer
