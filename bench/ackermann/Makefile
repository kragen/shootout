# $Id: Makefile,v 1.17 2004-09-24 07:40:03 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
NLOPTS   := -s 100000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 6,7,8,9,10 \
	--ignore ackermann.bash \
	--ignore ackermann.ciao \
	--ignore ackermann.csharp \
	--ignore ackermann.elastic \
	--ignore ackermann.gawk \
	--ignore ackermann.gcj \
	--ignore ackermann.gij \
	--ignore ackermann.gst \
	--ignore ackermann.perl \
	--ignore ackermann.ruby \
	--ignore ackermann.tcl

include ../../Make.footer
