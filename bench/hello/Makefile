# $Id: Makefile,v 1.1 2004-05-19 18:10:16 bfulgham Exp $
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
	--range 1,50,100,150,200 \
	--title "$(TITLE)" $(TEST).*

include ../../Make.footer
