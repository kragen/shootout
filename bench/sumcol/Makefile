# $Id: Makefile,v 1.28 2006-06-09 23:27:21 bfulgham Exp $
include ../../Make.header

TEST    := sumcol
TITLE   := Sum a File of Numbers

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput -noshell
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_GHCRTS  := +RTS -H10M
MB_NHCRTS := +RTS -H20M -RTS
MZSCHEMEOPTS := -rqxA
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400,700,1000,8000 \
	  --inputfile ../../website/desc/sumcol-input.txt --geninput

include ../../Make.footer
