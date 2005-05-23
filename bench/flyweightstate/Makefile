# $Id: Makefile,v 1.1 2005-05-23 15:37:06 igouy-guest Exp $
include ../../Make.header

TEST    := flyweightstate
TITLE   := Virtual method calls in state and flyweight patterns

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
# gcc -O3 is detrimental for this test!
GCCOPTS := -O1
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200000,600000,1000000

include ../../Make.footer
