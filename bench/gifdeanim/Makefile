# $Id: Makefile,v 1.3 2004-06-18 08:08:23 dbr-guest Exp $
include ../../Make.header

TEST    := gifdeanim
TITLE   := GIF Image De-Animator

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,16,24,32

include ../../Make.footer
