# $Id: Makefile,v 1.1 2005-05-17 07:42:04 igouy-guest Exp $
include ../../Make.header

TEST    := binarytrees
TITLE   := Make and free many binary trees

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
	  --range 14,16,18

include ../../Make.footer
