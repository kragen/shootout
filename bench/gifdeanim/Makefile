# $Id: Makefile,v 1.4 2004-07-31 09:19:00 bfulgham Exp $
include ../../Make.header

TEST    := gifdeanim
TITLE   := GIF Image De-Animator

#XLABEL  := N (number of iterations)

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,16,24,32

include ../../Make.footer
