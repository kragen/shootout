# $Id: Makefile,v 1.11 2006-06-15 05:27:22 igouy-guest Exp $
include ../../Make.header

TEST    := fannkuch
TITLE   := Fannkuch Function

#XLABEL  := N (number of iterations)

CLEANOPTS := -I ../Include/clean -I ../../Include/clean
MB_CLRTS := -nr

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
ICCOPTS := -tpp6
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q
GHCOPTS  := -fparr

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math
OBJCOPTS := -std=gnu99

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,9,10 

include ../../Make.footer
