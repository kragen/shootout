# $Id: Makefile,v 1.15 2005-03-25 07:59:08 bfulgham Exp $
include ../../Make.header

TEST    := objinst
TITLE   := Object Instantiation

ERLFLAGS := -noinput -noshell
LOCDEPS := --dep=se:../Include/nth_toggle.e,../Include/toggle.e
#CHICKENOPTS := -include-path /usr/share/chicken/meroon #-extends meroon #\
#		-C "-O3 -fomit-frame-pointer -fno-strict-aliasing"
CLEANOPTS := -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean
NHC98OPTS := -package base
OO2COPTS := -A --no-rtc
POLYOPTS := -q

RUNTESTS := $(MINIBENCH) --conf ../../Minibench.conf \
	  --range 400000,700000,1000000,1500000

include ../../Make.footer
