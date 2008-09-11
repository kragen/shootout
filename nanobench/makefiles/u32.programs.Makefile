# The Computer Language Benchmarks Game
# $Id: u32.programs.Makefile,v 1.6 2008-09-11 00:40:00 igouy-guest Exp $

# ASSUME each program will build in a clean empty tmpdir
# ASSUME there's a symlink to the program source in tmpdir
# ASSUME there's a symlink to the Include directory in tmpdir
# ASSUME there are symlinks to helper files in tmpdir
# ASSUME no responsibility for removing temporary files from tmpdir

# TYPICAL actions include an initial mv to give the expected extension 

# ASSUME environment variables for compilers and interpreters are set in the header


SPLITFILE := $(NANO_BIN)/split_file.bash

COPTS := -O3 -fomit-frame-pointer



############################################################
# ACTIONS for specific language implementations
############################################################


########################################
# gnat ADA 2005
########################################

%.gnat_run: %.gnat
	-$(GNATCHOP) -w $<
	-$(GNATC) -gnatp $(COPTS) $(GNATOPTS) -f $(TEST).adb -o $@


########################################
# gcc
########################################

%.c: %.gcc $(GCC)
	-@mv $< $@

%.gcc_run: %.c $(GCC)
	-$(GCC) -pipe -Wall $(COPTS) $(GCCOPTS) $< -o $@


########################################
# gpp
########################################

%.c++: %.gpp $(GXX)
	-@mv $< $@

%.gpp_run: %.c++
	-$(GXX) -c -pipe $(COPTS) $(GXXOPTS) $< -o $<.o &&  \
        $(GXX) $<.o -o $@ -L/usr/lib $(GXXLDOPTS) 


########################################
# cgpp
########################################

%.c: %.cgpp $(GXX)
	-@mv $< $@

%.cgpp_run: %.c
	-$(GXX) -c -pipe $(COPTS) $(GXXOPTS) $< -o $<.o &&  \
        $(GXX) $<.o -o $@ -L/usr/lib $(GXXLDOPTS) 


########################################
# icc
########################################

%.c: %.icc $(ICC)
	-@mv $< $@

%.icc_run: %.c $(ICC)
	-$(ICC) -O3 -ipo -static $(ICCOPTS) $< -o $@


########################################
# Intel C++
########################################

%.c++: %.icpp $(ICPC)
	-@mv $< $@

%.icpp_run: %.c++
	-$(ICPC) -c -O3 -ipo -static $(ICPCOPTS) $< -o $<.o &&  \
        $(ICPC) $<.o -o $@ -O3 -ipo -static $(ICPCOPTS) 


########################################
# chicken
########################################

CHICKENOPTS := -O2 -d0 -no-trace -no-lambda-info -optimize-level 3 -disable-interrupts -block -lambda-lift $(CHICKENOPTS) -C "$(COPTS) -fno-strict-aliasing"

#%.chicken: %.chicken $(CHICKEN)
#	-cp $< $@

%.chicken_run: %.chicken
	-$(CHICKEN) $< $(CHICKENOPTS) -o $@



########################################
# Gwydion Dylan
########################################

%.dylan: %.gwydion $(GWYDION)
	-mv $< $@

%.gwydion_run: %.dylan
	-(if [ "$*" = "random" ]; then	\
	    cp random.dylan randum.dylan;	\
	fi)
	-$(GWYDION) -s $(GWYDION_OPTS) $<
	-(if [ "$*" = "random" ]; then	\
	    mv randum $@;		\
	else				\
	    mv $* $@;			\
	fi)


########################################
# SmartEiffel
########################################

%.e: %.se $(EIFFELC)
	-mv $< $(TEST).e
	-$(SPLITFILE) $< $(TEST).e

%.se_run: %.e
	-$(EIFFELC) c -clean -boost -no_split $(COPTS) $(EIFFELOPTS) -o $@ $(TEST)


########################################
# Lisaac
########################################

%.li: %.lisaac $(LISAAC)
	-mv $< $(TEST).li
#	-@echo split_file.bash $(TEST).li $(TEST).li
#	-@$(SPLITFILE) $(TEST).li $(TEST).li

%.lisaac_run: %.li
#	-$(LISAAC) $(TEST) $(LISAACOPTS) -o lisaac_run 
#	-mv lisaac_run $@
	-$(LISAAC) -O -i20 $(TEST)
	-$(GCC) $(GCCOPTS) $(TEST).c -o $@


########################################
# F#
########################################

%.fs: %.fsharp $(FSHARPC)
	-mv $< $@

%.fsharp_run: %.fs
	-$(MONORUN) $(FSHARPC) -r FSharp.PowerPack.dll --platform x86 -O $(FSHARPOPTS) -o $@.exe $<

########################################
# Zonnon
########################################

%.znn_run: %.znn
	-mv $< $@
	-$(MONORUN) $(ZONNONC) /ref:Include/zonnon/BenchmarksGame.dll /entry:$(TEST) $< /out:$@.exe 


########################################
# Mono (C#)
########################################

%.cs: %.csharp $(MONOC)
	-mv $< $@

%.csharp_run: %.cs
	-$(MONOC) $(MONOOPTS) -optimize+ -out:$@ $<


########################################
# Clean
########################################

%.icl: %.clean $(CLEANC)
	-mv $< $(TEST).icl

%.clean_run: %.icl
	-$(CLEANC) -b -nt -IL ArgEnv -I Include/clean $(CLEANOPTS) $(TEST) -o $@


########################################
# D Language
########################################

%.d: %.dlang $(DLANG)
	-mv $< $(TEST).d

%.dlang_run: %.d
	-$(DLANG) -O -inline -release  $(DLANGOPTS) -of$@ $(TEST).d


########################################
# Erlang
########################################

%.erl: %.erlang $(ERLC)
	-mv $< $(TEST).erl

%.erlang_run: %.erl
	-$(ERLC) $(TEST).erl


########################################
# Hipe
########################################

%.erl: %.hipe $(ERLC)
	-mv $< $(TEST).erl

%.hipe_run: %.erl
	-$(ERLC) +native +"{hipe, [o3]}" $(HIPE_OPTS) $(TEST).erl


########################################
# gforth (GNU Forth)
########################################

%.gforth: %.gforth $(GFORTH)
	-mv $< $@

%.gforth_run: %.gforth
	-$(GFORTH) $< -e 'savesystem $@ bye'


########################################
# g95 (GNU Fortran)
########################################

%.f90: %.g95 $(G95)
	-@mv $< $@

%.g95_run: %.f90
	-$(G95) -pipe $(COPTS) $(G95OPTS) $< -o $@


########################################
# kroc
########################################

%.occ: %.occam $(OCCAM)
	-@mv $< $@

%.occam_run: %.occ $(OCCAM)
	-$(OCCAM) $(OCCAMOPTS) $<  -o $@ 


########################################
# ifort (Intel Fortran)
########################################

%.f90: %.ifc $(IFORT)
	-@mv $< $@

%.ifc_run: %.f90
	-$(IFORT) -O3 -ipo -static $(IFCOPTS) $< -o $@


########################################
# ghc (glasgow haskell compiler)
########################################

%.hs: %.ghc $(GHC)
	-mv $< $@

%.ghc_run: %.hs $(GHC)
	-$(GHC) --make -O2 -fglasgow-exts $(GHCOPTS) $< -o $@


########################################
# java
########################################

%.java_run: %.java $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java

%.javaxx_run: %.javaxx $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java

%.javaxint_run: %.javaxint $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java

%.javaclient_run: %.javaclient $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java

%.java14_run: %.java14 $(JDKOLDRUN)
	-mv $< $(TEST).java
	-$(JDKOLDC) $(TEST).java

%.java5_run: %.java5 $(JDK5RUN)
	-mv $< $(TEST).java
	-$(JDK5C) $(TEST).java

%.ibmjava_run: %.ibmjava $(IBMJDKRUN)
	-mv $< $(TEST).java
	-$(IBMJDKC) $(TEST).java


########################################
# CAL
########################################

%.cal_run: %.cal 
	-mv $< $(TEST).cal
	-Include/cal/compile.sh $(TEST).cal


########################################
# gcj
#######################################--make -O2 -fglasgow-exts $(GHCOPTS)#

%.javagcj: %.gcj $(GCJ)
	-@mv $< $@

%.gcj_run: %.javagcj $(GCJ)
	-$(GCJ) -x java $(COPTS) -fno-bounds-check -fno-store-check $(GCJOPTS) -o $@ --main=$(TEST) $<


########################################
# SBCL (Common Lisp)
########################################
# (Note: arg to compile-file for trace: ':trace-file t')
SBCL_TRACE :=
#SBCL_TRACE := :trace-file t
%.sbcl_run: %.sbcl $(SBCL_SRCS) $(SBCL)
	-@rm -f $@ ; \
	echo "(proclaim '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0) (space 0)))" > $@ ; \
	COMPILE=$@; COMPILE=$${COMPILE%_run}_compile ; \
	FILES="" ; \
	for f in $(SBCL_SRCS) ; do cp $$f . ; FILES="$$FILES $${f##*/}" ; done ; \
	echo "(proclaim '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0) (space 0)))" > $$COMPILE ; \
	for src in $$FILES ; do \
	    echo "(compile-file \"$$src\" $(SBCL_TRACE)) (load \"$$src\" :verbose nil :print nil)" >> $$COMPILE ; \
	    base=$${src%.*} ; \
	done ; \
	cp $< . ; MAIN=$< ; MAIN=$${MAIN##*/} ; \
	(echo "(handler-bind ((sb-ext:defconstant-uneql " \
              "    (lambda (c) (abort c)))) " \
              "    (load (compile-file \"$$MAIN\" $(SBCL_TRACE))))" \
              "(save-lisp-and-die \"sbcl.core\" :purify t)") >> $$COMPILE ; \
	echo "SBCL built with: $(SBCL) --userinit /dev/null -batch -eval '(load \"$$COMPILE\")'" ; \
	echo "### START $$COMPILE" ; cat $$COMPILE ; echo "### END $$COMPILE" ; echo ; \
	$(SBCL) --noinform --userinit /dev/null --load $$COMPILE; \
	echo "(main) (quit)" >> $@
	-@echo "### START $@" ; cat $@ ; echo "### END $@" ; echo


########################################
# nice
########################################

%.nice_run: %.nice $(NICEC)
	-$(NICEC) -d . --sourcepath ".:.." -a $(TEST).jar tmp


########################################
# Oberon-2 (oo2c) 
########################################
	
%.ooc_run: %.ooc
	-mv $< $(TEST).ooc
	-$(OOC) -r Include/ooc -r . -A --no-rtc --cflags "$(COPTS)" $(OO2COPTS) -M $(TEST).ooc
	-mv bin/* $@


########################################
# ocaml native code compiler
########################################

%.ml: %.ocaml $(OCAML)
	-mv $< $@

%.ocaml_run: %.ml
	-$(OCAML) -noassert -unsafe $(OCAMLOPTS) $< -o $@


########################################
# ocaml bytecode compiler
########################################

%.ml: %.ocamlb $(OCAMLB)
	-mv $< $@

%.ocamlb_run: %.ml
	-$(OCAMLB) $(OCAMLBOPTS) $< -o $@


########################################
# fbasic (FreeBASIC Compiler)
########################################

%.bas: %.fbasic $(FBASIC)
	-mv $< $(TEST).bas

%.fbasic_run: %.bas
	-$(FBASIC) -lang deprecated $(FBCOPTS) $(TEST).bas
	-mv $(TEST) $@


########################################
# fpascal (Free Pascal Compiler)
########################################

%.pas: %.fpascal $(FPASCAL)
	-mv $< $@

%.fpascal_run: %.pas
	-$(FPASCAL) -FuInclude/fpascal -XX -Xs  $(FPCOPTS) -oFPASCAL_RUN $<
	-mv FPASCAL_RUN $@


########################################
# Pike
########################################

%.pike_run: %.pike $(PIKE)
	-mv $< $*.pike
	-$(PIKE) -x dump $*.pike


#######################################
# SWI Prolog
########################################

%.swiprolog_run: %.swiprolog $(SWIPROLOG)
	-mv $< $(TEST).pl
	-$(SWIPROLOG) -O -t halt --goal=main --stand_alone=true $(SWIOPTS) -o $@ -c $(TEST).pl


########################################
# Python
########################################

%.python_run: %.python $(PYTHON)
	-mv $< $*.py
	-$(PYTHON) -OO -c "from py_compile import compile; compile('$*.py')"


########################################
# Psyco
########################################

%.psyco_run: %.psyco $(PYTHON)
	-mv $< $*.py
	-$(PSYCO) -OO -c "from py_compile import compile; compile('$*.py')"


########################################
# gambit
########################################

%.gambit: %.gambit $(GAMBIT) $(GCC)
	-mv $< $@

%.gambit_run: %.gambit
	-$(GAMBIT) -link $<
#	-$(GAMBIT) -postlude '(main (cadr (command-line)))' $(GAMBITOPTS) $< 
	-$(GCC) $(GCCOPTS) -D___SHARED_HOST $(TEST)*.c -lgambc -o $@


########################################
# petit
########################################

%.petitnasm: %.petitnasm $(PETITNASM)
	-mv $< $@

%.petitnasm_run: %.petitnasm
	-( cd $(PETITNASM) ; ./twobit twobit.heap -args tmp $*.petitnasm ; cd tmp )
	-mv .larceny $@


#######################################
# sml/nj
########################################

%.x86-linux: %.smlnj $(SMLNJ) $(SMLNJBUILD)
	-cp $< $(TEST).sml
	-$(SMLNJBUILD) cm_$(TEST).cm Test.main $(TEST)


.PRECIOUS: %.x86-linux

%.smlnj_run: %.x86-linux
	@:



########################################
# mlton
########################################

%.mlton_run: %.mlton $(MLTON)
	-mv $*.mlton $*.sml
	-(if [ -r mlb_$*.mlb ]; then			\
			mv mlb_$*.mlb $*.mlb;		\
		else							\
			echo 'Include/mlton-src/lib.mlb $*.sml'	\
				 >$*.mlb;				\
		fi)
	-$(MLTON) $(MLTONOPTS) -output $@ $*.mlb


########################################
# Mozart/Oz compiler
########################################

%.oz_run: %.oz
	-$(OZC) $(OZOPTS) -x $<
	-mv $* $@


########################################
# JRuby file name fix
########################################

%.jruby_run: %.jruby
	-mv $< $(TEST).rb


########################################
# Groovy file options export
########################################

# groovy needs a file not a symlink

%.groovy_run: %.groovy
	-cp $< $(TEST).groovy


########################################
# mmc
########################################

%.m: %.mercury $(MMC)
	-@mv $< $@

%.mercury_run: %.m $(MMC)
	-$(MMC) $(MMCOPTS) $< -o $@


########################################
# scala
########################################

%.scala_run: %.scala $(SCALAC)
	-mv $< $(TEST).scala
	-$(SCALAC) -optimise $(TEST).scala





