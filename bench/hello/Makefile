# $Id: Makefile,v 1.4 2004-07-31 09:19:01 bfulgham Exp $
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
RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	--range 1,50,100,150,200 \
	--ignore hello.csharp

include ../../Make.footer
