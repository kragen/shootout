# $Id: Makefile,v 1.10 2006-06-10 23:38:28 bfulgham Exp $
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

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,9,10 

include ../../Make.footer
