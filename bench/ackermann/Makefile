# $Id: Makefile,v 1.7 2004-07-31 09:18:58 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 4,5,6,7,8 \
	--ignore ackermann.bash \
	--ignore ackermann.csharp \
	--ignore ackermann.tcl

include ../../Make.footer
