# $Id: Makefile,v 1.6 2004-10-05 02:29:17 bfulgham Exp $
include ../../Make.header

TEST    := gifdeanim
TITLE   := GIF Image De-Animator

#XLABEL  := N (number of iterations)

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2CFLAGS := --no-rtc -A
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,16,24,32

include ../../Make.footer
