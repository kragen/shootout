# $Id: Makefile,v 1.22 2004-11-07 22:41:41 bfulgham Exp $
include ../../Make.header

TEST    := ackermann
TITLE   := Ackermann's Function

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
POLYOPTS := -q
NLOPTS   := -s 100000

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 6,7,8,9,10 \
	--ignore ackermann.bash \
	--ignore ackermann.ciao \
	--ignore ackermann.csharp \
	--ignore ackermann.elastic \
	--ignore ackermann.gawk \
	--ignore ackermann.gcj \
	--ignore ackermann.gforth \
	--ignore ackermann.gij \
	--ignore ackermann.gprolog \
	--ignore ackermann.hugs \
	--ignore ackermann.icon \
	--ignore ackermann.kaffe \
	--ignore ackermann.perl \
	--ignore ackermann.psyco \
	--ignore ackermann.python \
	--ignore ackermann.rep \
	--ignore ackermann.ruby \
	--ignore ackermann.slang \
	--ignore ackermann.tcl

include ../../Make.footer
