# $Id: Makefile,v 1.9 2004-08-10 15:16:13 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 4,5,6,7,8 \
	--ignore ackermann.bash \
	--ignore ackermann.tcl

include ../../Make.footer
