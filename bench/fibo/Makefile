# $Id: Makefile,v 1.2 2004-05-27 06:40:23 bfulgham Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o

BIGLOOOPTS := -farithmetic

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,24,32 \
	  --ignore fibo.bash \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
