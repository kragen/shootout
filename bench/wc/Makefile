# $Id: Makefile,v 1.7 2004-07-17 07:01:36 bfulgham Exp $
include ../../Make.header

TEST    := wc
TITLE   := Count Lines/Words/Chars

#XLABEL  := N (number of copies of input data)

GHCOPTS := -package lang
MB_GHCRTS  := +RTS -M200m -K10m
STALINOPTS := -q
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 500,1000,1500,2000 \
	  --ignore wc.gnat \
	  --ignore wc.csharp \
	  --ignore wc.rep \
	  --ignore wc.stalin \
	  --ignore wc.erlang \
	  --ignore wc.hipe \
	  --inputfile Input --geninput

include ../../Make.footer
