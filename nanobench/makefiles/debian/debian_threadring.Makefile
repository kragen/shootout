# The Computer Language Benchmarks Game
# $Id: debian_threadring.Makefile,v 1.1 2008-07-30 18:57:16 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile

TEST    := threadring
TITLE   := Thread Ring


CLEANOPTS := $(CLEANOPTS) -l /usr/lib/clean/lib/ArgEnvUnix/ArgEnvC.o \
		-I ../Include/clean -I ../../Include/clean \
		-IL StdLib

BIGLOOOPTS := -farithmetic
MZSCHEMEOPTS := -qu
OO2COPTS := -A --no-rtc
OCAMLOPTS  := -thread unix.cmxa threads.cmxa
OCAMLBOPTS := -vmthread unix.cma threads.cma
POLYOPTS := -q

CHICKENOPTS := -R mailbox

GPLCOPTS := --fast-math
GXXLDOPTS  := $(GXXLDOPTS) -lpthread

GCCOPTS :=  $(GCCOPTS) -lpthread
ICCOPTS := $(ICCOPTS) -lpthread

CALFLAGS := -Dorg.openquark.cal.machine.lecc.concurrent_runtime


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 100000,1000000,10000000 


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
