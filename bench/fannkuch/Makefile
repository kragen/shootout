# $Id: Makefile,v 1.7 2006-01-21 04:44:58 bfulgham Exp $
include ../../Make.header

TEST    := fannkuch
TITLE   := Fannkuch Function

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

IFCOPTS := -ip
BIGLOOOPTS := -farithmetic
ICCOPTS := -tpp6
OO2COPTS := -A --no-rtc
PARROTOPTS := -j
POLYOPTS := -q
GHCOPTS  := -fparr

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,9,10 

include ../../Make.footer
