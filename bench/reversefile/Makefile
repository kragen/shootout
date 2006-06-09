# $Id: Makefile,v 1.27 2006-06-09 23:27:21 bfulgham Exp $
include ../../Make.header

TEST    := reversefile
TITLE   := Reverse a File

#XLABEL  := N (number of copies of input data)

ERLFLAGS := -noinput -noshell
CLEANOPTS := -nr -l /usr/lib/clean/lib/ArgEnv/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-I /usr/lib/clean/lib/ArgEnv
MB_CLRTS := -h 20000000
MB_NHCRTS := +RTS -H40M
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS :=  $(MINIBENCH) --conf ../../Minibench.conf --range 10,15,20,25 \
	  --inputfile ../../website/desc/reversefile-input.txt --geninput

include ../../Make.footer
