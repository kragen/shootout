# $Id: Makefile,v 1.13 2005-03-25 07:59:07 bfulgham Exp $
include ../../Make.header

TEST    := hello
TITLE   := Hello World

tmp:
	mkdir tmp

tmp/repeat: repeat
	cp $< $@

setup: tmp tmp/repeat

ERLFLAGS := -noinput -noshell
OO2COPTS := -A --no-rtc
POLYOPTS := -q
RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	--range 1,50,100,150,200 --ignore hello.poly \
	--ignore hello.ciao \
	--ignore hello.elastic

include ../../Make.footer
