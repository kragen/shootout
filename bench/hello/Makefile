# $Id: Makefile,v 1.10 2004-11-23 08:08:43 bfulgham Exp $
include ../../Make.header

TEST    := hello
TITLE   := Hello World

tmp:
	mkdir tmp

tmp/repeat: repeat
	cp $< $@

setup: tmp tmp/repeat

data/startup.tab: data/cpu.mbtab
	../../bin/make_startup_tab

post: data/startup.tab

ERLFLAGS := -noinput
OO2COPTS := -A --no-rtc
POLYOPTS := -q
RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	--range 1,50,100,150,200 --ignore hello.poly \
	--ignore hello.ciao

include ../../Make.footer
