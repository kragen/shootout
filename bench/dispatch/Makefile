# $Id: Makefile,v 1.3 2007-12-08 03:58:37 bfulgham Exp $
include ../../Make.header

TEST    := dispatch
TITLE   := Virtual methods in State and Flyweight patterns

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
# gcc -O3 is detrimental for this test!
GCCOPTS := -O1
GDCOPTS := -O1
OO2COPTS := -A --no-rtc
POLYOPTS := -q

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
GHCOPTS := -fexcess-precision

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 200000,600000,1000000

include ../../Make.footer
