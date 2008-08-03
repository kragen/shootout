# The Computer Language Benchmarks Game
# $Id: u64q_threadring.Makefile,v 1.2 2008-08-03 20:08:11 igouy-guest Exp $

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
	  --range 500000,5000000,50000000 


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
