# $Id: Makefile,v 1.1 2004-05-19 18:09:09 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 4,5,6,7,8 \
	--ignore ackermann.tcl \
	--ignore ackermann.bash \
	--title "$(TITLE)" $(TEST).*

include ../../Make.footer
