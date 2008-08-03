# The Computer Language Benchmarks Game
# $Id: gp4.header.Makefile,v 1.2 2008-08-01 17:09:28 igouy-guest Exp $

############################################################
# 
############################################################

BENCHMARKER := $(NANO_BIN)/nanobench

SPLITFILE := $(NANO_BIN)/split_file.bash

############################################################
# locations for exes and interpreters
############################################################

BEANSHELL := bsh.Interpreter
CALRUN := /opt/Quark/quarklaunch.sh
CH := /usr/local/ch5.1.0/bin/ch
CINT := /opt/cint-5.16.19/cint
CHICKEN := /opt/chicken-3.0.0/csc
CLEANC := /opt/clean/bin/clm
DLANG := /opt/dmd/bin/dmd
EIFFELC := /opt/SmartEiffel/bin/se
ERLC := /opt/otp_src_R12B-1/bin/erlc
ERLANG := /opt/otp_src_R12B-1/bin/erl
FBASIC := /usr/bin/fbc
FPASCAL := /usr/bin/fpc
FSHARPC := /opt/FSharp-1.9.4.17/bin/fscp10.exe
G95 := /opt/g95-install/bin/i686-suse-linux-gnu-g95
GCC := /usr/bin/gcc
GFORTH := /usr/bin/gforth
BIGFORTH := /opt/bigforth/bigforth
GHC := /usr/bin/ghc
GNATC := gnatmake
GNATCHOP := gnatchop
GROOVY := /opt/groovy-1.6-beta-1/bin/groovy
GST := /opt/gst/bin/gst
GWYDION := /usr/bin/d2c
GXX := /usr/bin/g++
ICPC := /opt/intel/cc/10.1.012/bin/icpc
ICC := /opt/intel/cc/10.1.012/bin/icc
ICON := /opt/icon.v943src/bin/icon
IFORT := /opt/intel/fc/10.1.012/bin/ifort
IO := /usr/bin/io_static
IRON := /opt/IronPython-1.1.1/ipy.exe
JDKRUN := /opt/sun-jdk-1.6.0.07/bin/java
JDKC := /opt/sun-jdk-1.6.0.07/bin/javac
JDKOLDRUN := /opt/sun-jdk-1.4.2.16/bin/java
JDKOLDC := /opt/sun-jdk-1.4.2.16/bin/javac
IBMJDKRUN := /opt/ibm-jdk-bin-1.5.0.2/bin/java
IBMJDKC := /opt/ibm-jdk-bin-1.5.0.2/bin/javac
GAMBIT := /usr/bin/gsc-gambit
GCJ := /usr/bin/gcj
IKARUS := /opt/ikarus-0.0.3/bin/ikarus
JAVASCRIPT := /opt/mozilla/js/src/Linux_All_OPT.OBJ/js
LISAAC := /usr/bin/lisaac
LUA := /usr/bin/lua
LUAJIT := /usr/local/bin/luajit
MLTON := /opt/mlton-20070826/bin/mlton
MMC := /usr/bin/mmc
MONOC := /usr/local/bin/gmcs
MONOC1 := /usr/local/bin/mcs
MONORUN := /usr/local/bin/mono
MZSCHEME := /opt/mz-4.0.2/bin/mzscheme
NEKOC := /opt/neko-1.4/bin/nekoc
NEKO := /opt/neko-1.4/bin/neko
NICEC := /opt/nice-0.9.12/bin/nicec
OCAML := /usr/bin/ocamlopt
OCCAM := /opt/kroc-1.4.0/install/bin/kroc
OOC := /usr/local/bin/oo2c
OZC := /opt/mozart/bin/ozc
PERL := /usr/bin/perl
PETITNASM := /opt/larceny-0.90-bin-petit-nasm-linux86
PHP := /usr/bin/php
PIKE := /usr/local/bin/pike
PNETC := /usr/bin/cscc
PNETRUN := /usr/bin/ilrun
PYTHON := /usr/bin/python
PSYCO := /usr/bin/python
REBOL := /opt/rebol/rebol
REGINA := /usr/bin/regina
RHINO := org.mozilla.javascript.tools.shell.Main
RUBY := /usr/bin/ruby
JRUBY := /opt/jruby-1.1.2/bin/jruby
SBCL := /usr/bin/sbcl
SCALA := /opt/scala-2.7.1.final/bin/scala
SCALAC := /opt/scala-2.7.1.final/bin/scalac
SMLNJ := /opt/smlnj/bin/sml
SMLNJBUILD := /opt/smlnj/bin/ml-build
STALIN := /opt/stalin-0.10alpha2/stalin
SWIPROLOG := /usr/local/bin/pl
TCL  := /opt/tcl/bin/tclsh8.5
VB := /usr/bin/mbas
VW := /opt/vw7/bin/linux86/vwlinux86
XDS := /usr/local/xds/bin/xc
YARV := /opt/ruby/ruby
BEANSHELL := $JDKRUN bsh.Interpreter
SQUEAK := /opt/Squeak-3.9-8
YAP := /usr/bin/yap
ZONNONC := /opt/ch.ethz.zonnon_1.0.79/compiler/zc.exe



############################################################
# 
############################################################

COPTS := -O3 -fomit-frame-pointer -march=pentium4 $(COPTS)
GXXOPTS := -pipe $(COPTS) $(GXXOPTS)
GXXLDOPTS := -L/usr/local/lib $(GXXLDOPTS)

#CLEANFLAGS :=
ERLFLAGS := -noshell -run
#GFORTH_FLAGS := 
#BIGFORTH_FLAGS :=
#JDKFLAGS :=
#CALFLAGS :=
#MONOFLAGS :=
JAVASCRIPTOPTS :=
#LUA_EXTRAS :=
#PHPOPTS :=
SWIFLAGS := -q -g main
JRUBYFLAGS := -J-server

GROOVYFLAGS := -server
JAVA_OPTS = $(GROOVYFLAGS)

QUARK_HOME = /opt/Quark
QUARK_JAVACMD = $(JDKRUN)
QUARK_VMARGS =  $(JDKFLAGS) -server -Xbatch $(CALFLAGS)

############################################################
	

.EXPORT_ALL_VARIABLES:
