# $Id: Makefile,v 1.18 2004-10-11 04:48:05 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
MB_GHCRTS  := +RTS -H10M
MB_NHCRTS := +RTS -H60M -RTS
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400,700,1000,8000 \
	  --inputfile Input --geninput \
	  --ignore sumcol.bash \
	  --ignore sumcol.csharp \
	  --ignore sumcol.erlang \
	  --ignore sumcol.hipe \
	  --ignore sumcol.nhc98 \
	  --ignore sumcol.stalin 

include ../../Make.footer
