# $Id: Makefile,v 1.4 2005-03-17 22:06:45 ekarttun-guest Exp $
include ../../Make.header

TEST    := tcprequest
TITLE   := 4K reply to TCP/IP request

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
	  --range 120,160,200

include ../../Make.footer
