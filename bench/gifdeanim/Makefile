# $Id: Makefile,v 1.2 2004-06-16 04:38:25 bfulgham Exp $
include ../../Make.header

TEST    := gifdeanim
TITLE   := GIF Image De-Animator

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,16,24,32 \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
