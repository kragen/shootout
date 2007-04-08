# $Id: Makefile,v 1.14 2007-04-08 15:09:41 bfulgham Exp $
include ../../Make.header

TEST    := fannkuch
TITLE   := Fannkuch Function

#XLABEL  := N (number of iterations)

CLEANOPTS := $(CLEANOPTS) -nr -h 32k -s 32k -I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
ICCOPTS := -tpp6
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
GHCOPTS  := -fparr

ERLFLAGS := -noinput -noshell
GHCOPTS := --make -O2 -optc-O3
GPLCOPTS := --fast-math
OBJCOPTS := -std=gnu99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 9,10,11 

include ../../Make.footer
