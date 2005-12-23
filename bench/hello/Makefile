# $Id: Makefile,v 1.16 2005-12-23 06:48:30 bfulgham Exp $
include ../../Make.header

TEST    := hello
TITLE   := Hello World

tmp:
	mkdir tmp

tmp/repeat: repeat
	cp $< $@

setup: tmp tmp/repeat

data/startup.tab: data/cpu.mbtab
	$(BIN)/make_startup_tab

post: data/startup.tab

ERLFLAGS := -noinput -noshell
OO2COPTS := -A --no-rtc
PARROTOPS := -j
POLYOPTS := -q
RUNTESTS := $(MINIBENCH) --conf Minibench.conf \
	--range 1,50,100,150,200 

include ../../Make.footer
