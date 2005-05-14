# $Id: Makefile,v 1.5 2005-05-14 16:29:48 sgeard-guest Exp $
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
POLYOPTS := -q
GHCOPTS  := -fparr

ERLFLAGS := -noinput -noshell
GPLCOPTS := --fast-math

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 7,8,9 

include ../../Make.footer
