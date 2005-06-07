# $Id: Makefile,v 1.3 2005-06-07 19:54:54 igouy-guest Exp $
include ../../Make.header

TEST    := binarytrees
TITLE   := Allocate, walk, and free many binary trees

#XLABEL  := N (number of iterations)

MB_CLRTS := -nr	
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
	  --range 12,14,16

include ../../Make.footer
