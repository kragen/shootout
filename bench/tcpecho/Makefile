# $Id: Makefile,v 1.2 2005-03-17 22:06:45 ekarttun-guest Exp $
include ../../Make.header

TEST    := tcpecho
TITLE   := 64 byte reply to TCP/IP request

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

BIGLOOOPTS := -farithmetic
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

ERLFLAGS := -noinput
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 6,8,10

include ../../Make.footer
