# $Id: Makefile,v 1.7 2004-08-11 15:09:02 bfulgham Exp $
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
RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	--ignore hello.gcj \
	--ignore hello.nice \
	--range 1,50,100,150,200 

include ../../Make.footer
