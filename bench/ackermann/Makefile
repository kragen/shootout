# $Id: Makefile,v 1.2 2004-05-27 06:28:38 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 4,5,6,7,8 \
	--ignore ackermann.tcl \
	--ignore ackermann.bash \
	--title "$(TITLE)" $(TEST).*

include ../../Make.footer
