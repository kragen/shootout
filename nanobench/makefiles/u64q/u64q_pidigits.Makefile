# The Computer Language Benchmarks Game
# $Id: u64q_pidigits.Makefile,v 1.1 2008-07-30 18:57:17 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile


TEST    := pidigits
TITLE   := Digits of Pi


CLEANOPTS := $(CLEANOPTS) -IL ExtendedArith -l -lgmp 

BIGLOOOPTS := -farithmetic
DLANGOPTS := -L-lgmp -I../../Include/dlang/gmp4d ../../Include/dlang/gmp4d/gmp.d ../../Include/dlang/gmp4d/gmppool.d ../../Include/dlang/gmp4d/mpz.d 
MONOOPTS := -r:Mono.Security
OCAMLOPTS := -I +gmp gmp.cmxa
OCAMLBOPTS := nums.cma
GCCOPTS := -lgmp
ICCOPTS := -lgmp
GXXLDOPTS := -lgmp -lgmpxx
ICPCOPTS := -lgmp -lgmpxx
JDKFLAGS := -Djava.library.path=../../Include/java


RUNTESTS := $(BENCHMARKER) --conf $(SITE_MAKEFILES)/$(SITE_NAME).ini \
	  --range 500,1500,2500


include $(SITE_MAKEFILES)/$(SITE_NAME).footer.Makefile
