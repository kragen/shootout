# The Computer Language Benchmarks Game
# $Id: u64q_sumcol.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := sumcol
TITLE   := Sum a File of Numbers


#XLABEL  := N (number of copies of input data)

MB_NHCRTS := +RTS -H20M -RTS

#ERLFLAGS := -user sumcol -run
#ERLFLAGS := +T 9 +Mea min -noinput -run


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 1000,11000,21000 \
	  --data $(DATA_ROOT)/sumcol-input.txt


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
