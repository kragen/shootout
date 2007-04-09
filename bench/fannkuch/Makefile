# $Id: Makefile,v 1.15 2007-04-09 15:15:31 bfulgham Exp $
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
	  --range 9,10,11 --ignore fannkuch.hugs-2.hugs --ignore fannkuch.hugs \
	  --ignore fannkuch.hugs-3.hugs

include ../../Make.footer
