# $Id: Makefile,v 1.2 2004-06-10 05:57:01 bfulgham Exp $
include ../../Make.header

TEST    := sieve
TITLE   := Sieve of Eratosthenes
GXXOPTS := $(GXXOPTS) -fno-exceptions

CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf --range 1,300,600,900 \
	  --ignore sieve.bash \
	  --title "$(TITLE)" $(TEST).*

include ../../Make.footer
