# $Id: Makefile,v 1.2 2004-06-18 08:08:23 dbr-guest Exp $
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

RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	--range 1,50,100,150,200

include ../../Make.footer
