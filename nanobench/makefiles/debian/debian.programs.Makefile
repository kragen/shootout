# The Computer Language Benchmarks Game
# $Id: debian.programs.Makefile,v 1.2 2008-07-30 19:44:28 igouy-guest Exp $

include $(SITE_MAKEFILES)/$(SITE_NAME).header.Makefile

############################################################
# common definitions go here 
############################################################
SPLITFILE := ../../../bin/split_file.bash

COPTS := -O3 -fomit-frame-pointer $(COPTS)

HIPE_OPTS := +native +"{hipe, [o3]}"

CLEANOPTS := -b -nt -IL ArgEnv -I Include/clean $(CLEANOPTS)

BIGLOOOPTS := -fsharing -Obench -unsafe $(BIGLOOOPTS)
CHICKENOPTS := -O2 -d0 -no-trace -no-lambda-info -optimize-level 3 -disable-interrupts -block -lambda-lift $(CHICKENOPTS) -C "$(COPTS) -fno-strict-aliasing"
DLANGOPTS := -O -inline -release $(DLANGOPTS)
EIFFELOPTS := c -clean -boost -no_split $(COPTS) $(EIFFELOPTS)
FLXOPTS := -c --optimize --static
FPCOPTS := -XX -Xs -O3ppentium4 -Cppentium4
G95OPTS := -pipe $(COPTS) $(G95OPTS)
GCCOPTS := -pipe -Wall $(COPTS) $(GCCOPTS)
GCJOPTS := $(COPTS) -fno-bounds-check -fno-store-check
GHCOPTS  := --make -O2 -fglasgow-exts $(GHCOPTS) -optc-march=pentium4
GNATOPTS := -gnatp $(COPTS) $(GNATOPTS)
GXXOPTS := -pipe $(COPTS) $(GXXOPTS)
GXXLDOPTS := -L/usr/local/lib $(GXXLDOPTS)
ICCCOPTS := -O3 -ipo -static $(ICCCOPTS)
ICPCOPTS := -O3 -ipo -static $(ICPCOPTS)
IFCOPTS := -O3 -ipo -static $(IFCOPTS)
MZSCHEMEOPTS := -qu
OBJCOPTS := -pipe $(COPTS) -lobjc $(OBJCOPTS)
OCCAMOPTS := -lcourse
#OCAMLOPTS := -noassert -unsafe -I /usr/lib/ocaml/contrib $(OCAMLOPTS)
OCAMLOPTS := -noassert -unsafe $(OCAMLOPTS)
OO2COPTS := -A --no-rtc --cflags "$(COPTS)"
STALINOPTS := -I /opt/stalin-0.10alpha2/include -Ob -Om -On -Or -Ot -copt -O3 -copt -fomit-frame-pointer -copt -Wall -copt -freg-struct-return $(STALINOPTS)
SWIOPTS := -O -t halt --goal=main --stand_alone=true
LISAACOPTS := -O -i20
MMCOPTS := --grade hlc.gc --cflags "$(COPTS)" $(MMCOPTS)



.EXPORT_ALL_VARIABLES:

##################################################
# common rules go here
##################################################

# some definitions used by the rules
.PHONY: plot show clean clobber test

############################################################
# Targets normally called by user
############################################################
show: plot
	@ee data/max.png &
	@ee data/cpu.png &
	@ee data/mem.png &
	@ee data/min.png &

clobber: clean
	@echo "Clobbering data/*"
	@rm -rf data

clean:
	@echo "Cleaning tmp/*"
	@rm -rf tmp

############################################################
# for source files that need to be built/compiled
############################################################


########################################
# gnat ADA 2005
########################################
%.gnat: %.gnat
	-cp $< $@

%.gnat_run: %.gnat
	-@rm -f $@
	-$(GNATCHOP) -w $<
	-$(GNATC) $(GNATOPTS) -f $(TEST).adb -o $@
	-@rm -f *.o $*.ali $*.adb


########################################
# gcc
########################################
%.c: %.gcc $(GCC)
	-@cp $< $@

%.gcc_run: %.c $(GCC)
	-@rm -f $@
	-$(GCC) $(GCCOPTS) $< -o $@
	-@rm -f $*.c $*.o

########################################
# icc
########################################
%.c: %.icc $(ICC)
	-@cp $< $@

%.icc_run: %.c $(ICC)
	-@rm -f $@
	-$(ICC) $(ICCOPTS) $< -o $@
	-@rm -f $*.c $*.o


########################################
# gpp
########################################
%.c++: %.gpp $(GXX)
	-@cp $< $@

%.gpp_run: %.c++
	-@rm -f $@
	-$(GXX) -c $(GXXOPTS) $< -o $<.o &&  \
        $(GXX) $<.o -o $@ $(GXXLDOPTS) 
	-@rm -f $*.c++ $*.c++.o $*.o


########################################
# cgpp
########################################
%.c: %.cgpp $(GXX)
	-@cp $< $@

%.cgpp_run: %.c
	-@rm -f $@
	-$(GXX) -c $(GXXOPTS) $< -o $<.o &&  \
        $(GXX) $<.o -o $@ $(GXXLDOPTS) 
	-@rm -f $*.c $*.c.o $*.o

########################################
# Intel C++
########################################
%.c++: %.icpp $(ICPC)
	-@cp $< $@

%.icpp_run: %.c++
	-@rm -f $@
	-$(ICPC) -c $(ICPCOPTS) $< -o $<.o &&  \
        $(ICPC) $<.o -o $@ $(ICPCOPTS) 
	-@rm $*.c++ *.o


########################################
# chicken
########################################
%.chicken: %.chicken $(CHICKEN)
	-cp $< $@

%.chicken_run: %.chicken
	-rm -f $@
	-$(CHICKEN) $< $(CHICKENOPTS) -o $@
	-@rm -f $*.o



########################################
# Gwydion Dylan
########################################
%.dylan: %.gwydion $(GWYDION)
	cp $< $@

%.gwydion_run: %.dylan
	-@rm -f $@ 
	-(if [ "$*" = "random" ]; then	\
	    cp random.dylan randum.dylan;	\
	fi)
	-$(GWYDION) -s $(GWYDION_OPTS) $<
	-(if [ "$*" = "random" ]; then	\
	    mv randum $@;		\
	else				\
	    mv $* $@;			\
	fi)
	-rm $*.[co]
	-rm -rf .libs

########################################
# SmartEiffel
########################################
%.e: %.se $(EIFFELC)
	-@echo "copying $< to $(TEST).e"
	-cp $< $(TEST).e
	-$(SPLITFILE) $< $(TEST).e

%.se_run: %.e
	-rm -f $@
	-$(EIFFELC) $(EIFFELOPTS) -o $@ $(TEST)

########################################
# Lisaac
########################################
%.li: %.lisaac $(LISAAC)
	-cp $< $(TEST).li
	-$(SPLITFILE) $< $(TEST).li

%.lisaac_run: %.li
	-rm -f $@
#	-$(LISAAC) $(TEST) $(LISAACOPTS) -o lisaac_run 
#	-mv lisaac_run $@
	-$(LISAAC) -O -i20 $(TEST)
	-$(GCC) $(GCCOPTS) $(TEST).c -o $@
	-@rm -f $*.c $*.o $*.li


########################################
# Portable.NET (C#)
########################################
%.cs: %.pnet $(PNETCC)
	-cp $< $@

%.pnet_run: %.cs
	-rm -f $@
	-$(PNETC) $(PNETOPTS) /out:$@ $<


########################################
# F#
########################################
%.fs: %.fsharp $(FSHARPC)
	-cp $< $@

%.fsharp_run: %.fs
	-rm -f $@
	-$(MONORUN) --runtime=v2.0.50727 $(FSHARPC) -O3 $(FSHARPOPTS) -o $@.exe $<

########################################
# Zonnon
########################################

%.znn_run: %.znn
	-rm -f $@.exe
	-mv $< $@
	-$(MONORUN) $(ZONNONC) /ref:Include/zonnon/BenchmarksGame.dll /entry:$(TEST) $< /out:$@.exe 
	-rm -f *.znn


########################################
# Mono (C#)
########################################
%.cs: %.csharp $(MONOC)
	-cp $< $@

%.csharp_run: %.cs
	-rm -f $@
	-$(MONOC) $(MONOOPTS) -optimize+ -out:$@ $<


########################################
# Clean
########################################
%.icl: %.clean $(CLEANC)
	-cp $< $(TEST).icl

%.clean_run: %.icl
	-@rm -f $@
	-$(CLEANC) $(CLEANOPTS) $(TEST) -o $@
	-@rm -f *.c *.o *.s


########################################
# D Language
########################################
%.d: %.dlang $(DLANG)
	-cp $< $(TEST).d

%.dlang_run: %.d
	-@rm -f $@ 
	-$(DLANG) $(DLANGOPTS) -of$@ $(TEST).d
	-@rm -f $*.o

########################################
# Erlang
########################################
%.erl: %.erlang $(ERLC)
	-cp $< $(TEST).erl

%.erlang_run: %.erl
	-@rm -f $@ 	
	-$(ERLC) $(TEST).erl



########################################
# Hipe
########################################

%.erl: %.hipe $(ERLC)
	-cp $< $(TEST).erl

%.hipe_run: %.erl
	-@rm -f $@ 	
	-$(ERLC) $(HIPE_OPTS) $(TEST).erl


########################################
# gforth (GNU Forth)
########################################
%.gforth: %.gforth $(GFORTH)
	-cp $< $@

%.gforth_run: %.gforth
	-@rm -f $@ 
	-$(GFORTH) $< -e 'savesystem $@ bye'



########################################
# g95 (GNU Fortran)
########################################
%.f90: %.g95 $(G95)
	-@cp $< $@

%.g95_run: %.f90
	-@rm -f $@
	-$(G95) $(G95OPTS) $< -o $@
	-rm $*.f90
	-@rm -f $*.o

########################################
# kroc
########################################

%.occ: %.occam $(OCCAM)
	-@cp $< $@

%.occam_run: %.occ $(OCCAM)
	-@rm -f $@
	-$(OCCAM) $(OCCAMOPTS) $<  -o $@ 
	-@rm -f $*.occ 

########################################
# ifort (Intel Fortran)
########################################
%.f90: %.ifc $(IFORT)
	-@cp $< $@

%.ifc_run: %.f90
	-@rm -f $@ 
	-$(IFORT) $(IFCOPTS) $< -o $@
	-rm $*.f90
	-@rm -f $*.o


########################################
# ghc (glasgow haskell compiler)
########################################
%.hs: %.ghc $(GHC)
	-cp $< $@

%.ghc_run: %.hs $(GHC)
	-@rm -f $@ 
	-$(GHC) $(GHCOPTS) $< -o $@
	-@rm -f $*.o


########################################
# java
########################################

%.ibmjava_run: %.ibmjava $(IBMJDKRUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(IBMJDKC) -classpath '.' $(TEST).java )
	-touch $@


%.java14_run: %.java14 $(JDKOLDRUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(JDKOLDC) -classpath '.' $(TEST).java )
	-touch $@

%.java5_run: %.java5 $(JDK5RUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(JDK5C) -classpath '.' $(TEST).java )
	-touch $@


%.java_run: %.java $(JDKRUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(JDKC) -classpath '.' $(TEST).java )
	-touch $@

%.javaxx_run: %.javaxx $(JDKRUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(JDKC) -classpath '.' $(TEST).java )
	-touch $@

%.javaxint_run: %.javaxint $(JDKRUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(JDKC) -classpath '.' $(TEST).java )
	-touch $@

%.javaclient_run: %.javaclient $(JDKRUN)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).java
	-( cd $@ ; rm -rf *.class; $(JDKC) -classpath '.' $(TEST).java )
	-touch $@


########################################
# CAL
########################################


%.cal_run: %.cal 
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).cal
	-( cd $@ ; ../Include/cal/compile.sh $(TEST).cal )
	-touch $@


########################################
# gcj
########################################
%.javagcj: %.gcj $(GCJ)
	-@cp $< $@

%.gcj_run: %.javagcj $(GCJ)
	-@rm -f $@
	-$(GCJ) -x java $(GCJOPTS) -o $@ --main=$(TEST) $<
	-@rm -f $*.o

########################################
# CMUCL (Common Lisp)
########################################
# (Note: arg to compile-file for trace: ':trace-file t')
CMUCL_TRACE :=
#CMUCL_TRACE := :trace-file t
%.cmucl_run: %.cmucl $(CMUCL_SRCS) $(CMUCL)
	-@rm -f $@ ; \
	echo "(proclaim '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0) (space 0)))" > $@ ; \
	echo "(setq *gc-verbose* nil)" >> $@ ; \
	COMPILE=$@; COMPILE=$${COMPILE%_run}_compile ; \
	FILES="" ; \
	for f in $(CMUCL_SRCS) ; do cp $$f . ; FILES="$$FILES $${f##*/}" ; done ; \
	echo "(proclaim '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0) (space 0)))" > $$COMPILE ; \
	for src in $$FILES ; do \
	    echo "(compile-file \"$$src\" :block-compile t $(CMUCL_TRACE)) (load \"$$src\" :verbose nil :print nil)" >> $$COMPILE ; \
	    base=$${src%.*} ; \
	    echo "(load \"$$base.x86f\" :verbose nil :print nil)" >> $@ ; \
	done ; \
	cp $< . ; MAIN=$< ; MAIN=$${MAIN##*/} ; \
	(echo "(compile-file \"$$MAIN\" :block-compile t $(CMUCL_TRACE) :entry-points '(main))"; echo "(quit)") >> $$COMPILE ; \
	MAIN=$${MAIN%.*} ; MAIN="$${MAIN}.x86f" ; echo "(load \"$$MAIN\" :verbose nil :print nil)" >> $@ ; \
	echo "CMUCL built with: $(CMUCL) -noinit -batch -eval '(load \"$$COMPILE\")'" ; \
	echo "### START $$COMPILE" ; cat $$COMPILE ; echo "### END $$COMPILE" ; echo ; \
	$(CMUCL) -noinit -batch -eval "(load \"$$COMPILE\")" ; \
	echo "(main) (quit)" >> $@
	-@echo "### START $@" ; cat $@ ; echo "### END $@" ; echo

########################################
# GNU Common Lisp
########################################
%.gcl_run: %.gcl $(GCL)
	-@rm -f $@ 
	-@rm -f $*.o
	-cp $< $*.gcl
	-(GCL_ANSI=1; export GCL_ANSI; \
	  $(GCL) -compile $*.gcl)
	-touch $@

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
	echo "SBCL built with: $(SBCL) --userinit /dev/null --sysinit /etc/sbclrc -batch -eval '(load \"$$COMPILE\")'" ; \
	echo "### START $$COMPILE" ; cat $$COMPILE ; echo "### END $$COMPILE" ; echo ; \
	$(SBCL) --noinform --userinit /dev/null --sysinit /etc/sbclrc --disable-debugger --load $$COMPILE; \
	echo "(main) (quit)" >> $@
	-@echo "### START $@" ; cat $@ ; echo "### END $@" ; echo


########################################
# lua
########################################
%.lua_run: %.lua $(LUA)
	-@rm -f $@ 
	-cp $< $@
	-@echo "lua -e NUM=%ARG $@"

########################################
# Neko
########################################
%.neko: %.neko $(NEKOC)
	-@cp $< $@

%.neko_run: %.neko
	-@rm -f *.n	
	-$(NEKOC) $<
	-@rm -f $*.neko

########################################
# nice
########################################

%.nice_run: %.nice $(NICEC)
	-@rm -rf $@  
	-( if [ ! -d $@ ] ; then mkdir $@ ; mkdir $@/$(TEST) ; fi)
	-cp $< $@/$(TEST)/$(TEST).nice
	-( cd $@/$(TEST) ; $(NICEC) -d . --sourcepath "..:../../../.." -a ../../$(TEST).jar $(TEST) )
	-touch $@

########################################
# Oberon-2 (XDS C)
########################################
%.xds: %.xds $(XDS)
	-cp $< $@

%.xds_run: %.xds
	-@rm -f $@ 
	-$(XDS) $(XDSOPTS) $<
	-@rm -f $*.o $*.sym $*.mkf $*.xds
	-mv $* $@
	
	
########################################
# Oberon-2 (oo2c) 
########################################
	
%.ooc_run: %.ooc
	-@rm -f $@ 
	-mv $< $(TEST).ooc
	-$(OOC) -r Include/ooc -r . $(OO2COPTS) -M $(TEST).ooc
	-mv bin/* $@
	-rm -rf obj sym bin	

########################################
# ocaml native code compiler
########################################
%.ml: %.ocaml $(OCAML)
	-cp $< $@

%.ocaml_run: %.ml
	-@rm -f $@ 
	-$(OCAML) $(OCAMLOPTS) $< -o $@

########################################
# ocaml bytecode compiler
########################################
%.ml: %.ocamlb $(OCAMLB)
	-cp $< $@

%.ocamlb_run: %.ml
	-@rm -f $@ 
	-$(OCAMLB) $(OCAMLBOPTS) $< -o $@


########################################
# fbasic (FreeBASIC Compiler)
########################################
%.bas: %.fbasic $(FBASIC)
	-cp $< $(TEST).bas

%.fbasic_run: %.bas
	-@rm -f $@ 
	-$(FBASIC) -lang deprecated $(FBCOPTS) $(TEST).bas
	-mv $(TEST) $@


########################################
# fpascal (Free Pascal Compiler)
########################################
%.pas: %.fpascal $(FPASCAL)
	-cp $< $@

%.fpascal_run: %.pas
	-@rm -f $@ 
	-$(FPASCAL) -FuInclude/fpascal $(FPCOPTS) -oFPASCAL_RUN $<
	-mv FPASCAL_RUN $@
	-@rm -f $*.o

########################################
# Pike
########################################
%.pike_run: %.pike $(PIKE)
	-@rm -f $@ 
	-rm -f $*.o
	-cp $< $*.pike
	-$(PIKE) -x dump $*.pike
	-touch $@

########################################
# GNU Prolog
########################################
%.gprolog_run: %.gprolog $(GPLC)
	-@rm -f $@ 
	-rm -f $*.pl
	-cp $< $*.pl
	-$(GPLC) $(GPLCOPTS) -o $@ $*.pl
	-rm -f $*.p[lo]

########################################
# SWI Prolog
########################################
%.swiprolog_run: %.swiprolog $(SWIPROLOG)
	-@rm -f $@ 
	-rm -f $*.pl
	-cp $< $*.pl
	-$(SWIPROLOG) $(SWIOPTS) -o $@ -c $*.pl
	-rm -f $*.p[lo]


########################################
# Python
########################################
%.python_run: %.python $(PYTHON)
	-@rm -f $@ 
	-rm -f $*.pyo $*.pyc
	-cp $< $*.py
	-$(PYTHON) -OO -c "from py_compile import compile; compile('$*.py')"
#	-$(PYTHON) -OO -c "from py_compile import compile; compile('tmp/$*.py')"
	-touch $@

########################################
# Psyco
########################################
%.psyco_run: %.psyco $(PYTHON)
	-@rm -f $@ 
	-rm -f $*.pyo $*.pyc
	-cp $< $*.py
	-$(PSYCO) -OO -c "from py_compile import compile; compile('$*.py')"
#	-$(PSYCO) -OO -c "from py_compile import compile; compile('tmp/$*.py')"
	-touch $@


########################################
# gambit
########################################
%.gambit: %.gambit $(GAMBIT) $(GCC)
	-cp $< $@

%.gambit_run: %.gambit
	-rm -f $@
	-rm -f *.c
	-$(GAMBIT) -link $<
#	-$(GAMBIT) -postlude '(main (cadr (command-line)))' $(GAMBITOPTS) $< 
	-$(GCC) $(GCCOPTS) -D___SHARED_HOST $(TEST)*.c -lgambc -o $@
	-@rm -f $*.o $*.c


########################################
# petit
########################################
%.petitnasm: %.petitnasm $(PETITNASM)
	-cp $< $@

%.petitnasm_run: %.petitnasm
	-rm -f $@
	-( cd $(PETITNASM) ; ./twobit twobit.heap -args tmp $*.petitnasm ; cd tmp )
	-cp .larceny $@
	-@rm -f $*.so $*.o $*.asm


########################################
# Stalin
########################################
%.stalin_run.sc: %.stalin $(STALIN)
	-cp $< $@

%.stalin_run: %.stalin_run.sc
	-rm -f $@
	-$(STALIN) $(STALINOPTS) $<
	-@rm -f $*.o


########################################
# sml/nj
########################################
%.x86-linux: %.smlnj $(SMLNJ) $(SMLNJBUILD)
	-@rm -f $@
	-cp $< $(TEST).sml
	-$(SMLNJBUILD) cm_$(TEST).cm Test.main $(TEST)
	-@rm -f $(TEST).sml $*.cm

.PRECIOUS: %.x86-linux

%.smlnj_run: %.x86-linux
	@:



########################################
# mlton
########################################
%.mlton_run: %.mlton $(MLTON)
	-@rm -f $@ 
	-cp $*.mlton $*.sml
	-(if [ -r mlb_$*.mlb ]; then			\
			mv mlb_$*.mlb $*.mlb;		\
		else							\
			echo 'Include/mlton-src/lib.mlb $*.sml'	\
				 >$*.mlb;				\
		fi)
	-$(MLTON) $(MLTONOPTS) -output $@ $*.mlb
	-rm -f $*.mlb $*.sml

########################################
# Mozart/Oz compiler
########################################
#%.oz: $(OZC)
#	-cp $< $@

%.oz_run: %.oz
	-@rm -f $@ 
	-$(OZC) $(OZOPTS) -x $<
	-mv $* $@


########################################
# ST/X
########################################

%.stx_run: %.stx
	-@rm -rf $@  
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).stx
	-cp ../Make.proto $@
	-( cd $@ ; ../$(SPLITFILE) $(TEST).stx ; /opt/stx/rules/stmkmf /opt/stx ; make )
	-touch $@


########################################
# JRuby file name fix
########################################

%.jruby_run: %.jruby
	-@rm -f $(TEST).rb 
	-mv $< $(TEST).rb


########################################
# Groovy file name fix
########################################

%.groovy: %.groovy
	-@rm -f $(TEST).groovy 
	-cp $< $(TEST).groovy

%.groovy_run: %.groovy
	-@rm -f $@ 


########################################
# mmc
########################################
%.m: %.mercury $(MMC)
	-@cp $< $@

%.mercury_run: %.m $(MMC)
	-@rm -f $@
	-$(MMC) $(MMCOPTS) $< -o $@
	-@rm -f $*.c $*.o $*.mh $*.d $*.c_date 


########################################
# scala
########################################

%.scala_run: %.scala $(SCALAC)
	-@rm -rf $@ 
	-( if [ ! -d $@ ] ; then mkdir $@ ; fi)
	-cp $< $@/$(TEST).scala
	-( cd $@ ; $(SCALAC) $(TEST).scala )
	-touch $@
	-export JAVACMD="$JDKRUN $JDKFLAGS -server -Xbatch" 



