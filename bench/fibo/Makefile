# $Id: Makefile,v 1.1 2004-05-19 18:09:48 bfulgham Exp $
include ../../Make.header

TEST    := fibo
TITLE   := Fibonacci Numbers

#XLABEL  := N (number of iterations)

BIGLOOOPTS := -farithmetic

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 8,24,32 \
	  --ignore fibo.bash \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
