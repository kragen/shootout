# The Computer Language Benchmarks Game
# $Id: u64q.header.Makefile,v 1.4 2008-08-01 16:58:03 igouy-guest Exp $

############################################################
# 
############################################################

BENCHMARKER := $(NANO_BIN)/nanobench

SPLITFILE := $(NANO_BIN)/split_file.bash

############################################################
# locations for exes and interpreters
############################################################

CALRUN := /usr/local/src/Quark/quarklaunch.sh
CINT := /opt/cint-5.16.19/cint
CHICKEN := /opt/chicken-3.0.0/csc
CLEANC := /opt/clean/bin/clm
DLANG := /opt/dmd/bin/dmd
EIFFELC := /opt/SmartEiffel/bin/se
ERLC := /usr/local/bin/erlc
ERLANG := /usr/local/bin/erl
FBASIC := /usr/bin/fbc
FPASCAL := /usr/bin/fpc
FSHARPC := /opt/FSharp-1.9.4.17/bin/fscp10.exe
G95 := /opt/g95-install/bin/i686-suse-linux-gnu-g95
GCC := /usr/bin/gcc
GFORTH := /usr/bin/gforth
BIGFORTH := /opt/bigforth/bigforth
GHC := /usr/bin/ghc
GNATC := /usr/bin/gnatmake
GNATCHOP := /usr/bin/gnatchop
GROOVY := /usr/local/src/groovy-1.6-beta-1/bin/groovy
GST := /usr/local/bin/gst
GWYDION := /usr/bin/d2c
GXX := /usr/bin/g++
ICPC := /opt/intel/cc/10.1.012/bin/icpc
ICC := /opt/intel/cc/10.1.012/bin/icc
IFORT := /opt/intel/fc/10.1.012/bin/ifort
IO := /usr/bin/io_static
IRON := /opt/IronPython-1.1.1/ipy.exe
JDKRUN := /usr/bin/java
JDKC := /usr/bin/javac
GAMBIT := /usr/bin/gsc-gambit
GCJ := /usr/bin/gcj
IKARUS := /opt/ikarus-0.0.3/bin/ikarus
JAVASCRIPT := /usr/bin/js
LISAAC := /usr/bin/lisaac
LUA := /usr/bin/lua
LUAJIT := /usr/local/bin/luajit
MLTON := /usr/bin/mlton
MMC := /usr/bin/mmc
MONOC := /usr/bin/gmcs
MONORUN := /usr/bin/mono
MZSCHEME := /usr/local/src/mz-4.0.2/bin/mzscheme
NICEC := /usr/bin/nicec
OCAML := /usr/bin/ocamlopt
OOC := /usr/local/bin/oo2c
OZC := /opt/mozart/bin/ozc
PERL := /usr/bin/perl
PHP := /usr/bin/php
PIKE := /usr/bin/pike
PYTHON := /usr/bin/python
PSYCO := /usr/bin/python
REBOL := /opt/rebol/rebol
RUBY := /usr/bin/ruby
JRUBY := /opt/jruby-1.1.2/bin/jruby
SBCL := /usr/local/bin/sbcl
SCALA := /usr/local/src/scala-2.7.1.final/bin/scala
SCALAC := /usr/local/src/scala-2.7.1.final/bin/scalac
SMLNJ := /opt/smlnj/bin/sml
SMLNJBUILD := /opt/smlnj/bin/ml-build
SWIPROLOG := /usr/bin/swipl
TCL := /usr/bin/tclsh
VW := /opt/vw7/bin/linux86/vwlinux86
YARV := /opt/ruby/ruby
SQUEAK := /opt/Squeak-3.9-8
YAP := /usr/local/bin/yap
ZONNONC := /opt/ch.ethz.zonnon_1.0.79/compiler/zc.exe


############################################################
# 
############################################################

COPTS := -O3 -fomit-frame-pointer $(COPTS)
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

QUARK_HOME = /usr/local/src/Quark
QUARK_JAVACMD = $(JDKRUN)
QUARK_VMARGS =  $(JDKFLAGS) -server -Xbatch $(CALFLAGS)


############################################################
	

.EXPORT_ALL_VARIABLES:

