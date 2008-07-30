# The Computer Language Benchmarks Game
# $Id: debian_hello.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


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

GCCOPTS := -ffreestanding -nostartfiles -s -static


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	--range 1,200 


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
