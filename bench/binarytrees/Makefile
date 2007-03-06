# $Id: Makefile,v 1.19 2007-03-06 04:59:02 bfulgham Exp $
include ../../Make.header

TEST    := binarytrees
TITLE   := Allocate, walk, and free many binary trees

#XLABEL  := N (number of iterations)

MB_CLRTS := -nr	
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean -I /usr/lib/clean/lib/ArgEnv
CYCOPTS := -lm
IFCOPTS := -u -what
BIGLOOOPTS := -farithmetic
ERLFLAGS := -noinput

GCCOPTS := -lm
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
PHPOPTS := -d memory_limit=64M
BIGFORTHOPTS := -m 16M

GPLCOPTS := --fast-math
GHCOPTS := -fbang-patterns -funbox-strict-fields

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 12,14,16

include ../../Make.footer
