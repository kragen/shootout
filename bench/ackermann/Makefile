# $Id: Makefile,v 1.14 2004-09-13 13:58:30 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 6,7,8,9,10 \
	--ignore ackermann.bash \
	--ignore ackermann.csharp \
	--ignore ackermann.elastic \
	--ignore ackermann.objc \
	--ignore ackermann.ruby \
	--ignore ackermann.tcl

include ../../Make.footer
