# $Id: Makefile,v 1.5 2004-08-04 07:39:53 bfulgham Exp $
include ../../Make.header

TEST    := gifdeanim
TITLE   := GIF Image De-Animator

#XLABEL  := N (number of iterations)

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
OO2CFLAGS := --no-rtc -A

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,16,24,32

include ../../Make.footer
