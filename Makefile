# $Id: Makefile,v 1.22 2005-04-05 14:33:42 bfulgham Exp $

include Make.header

all: init versions
	-(cd bench ; make $@)
	-(cd bench ; make --no-print-directory report> report.txt)
	-bin/build_data_files
	-make recent codelinks

website: 
	-bin/build_data_files
	-bin/make_highlight
	-(cd website/code; ../../bin/add_strays)
	-cvs commit -m "Rerun of benchmarks."

test plot show loc:
	-(cd bench ; make $@)

clean:
	-(cd bench ; make $@)

.PHONY: dist report recent versions codelinks

versions: versions.html

versions.html: bin/make_versions langs.pl
	-bin/make_versions > versions.html.tmp && \
	mv -f versions.html.tmp versions.html

dist:
	-bin/make_dist

report codelinks:
	-@bin/make_highlight

recent:
	-@bin/make_recent > recent.html

init: init-stamp
init-stamp: links-stamp
	-bin/make_dirs
	-touch init-stamp

links:  links-stamp
links-stamp:
	# All Java's use the same source
	for j in `find bench -name '*.java'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.java'`.kaffe; \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.java'`.gcj; \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.java'`.gij; \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.java'`.sablevm; \
	done

	# Hipe and Erlang are the same
	for j in `find bench -name '*.erlang'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.erlang'`.hipe; \
	done

	# Ocaml and Ocamlb are the same
	for j in `find bench -name '*.ocaml'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.ocaml'`.ocamlb; \
	done

	# MzScheme and Mzc are the same
	for j in `find bench -name '*.mzscheme'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.mzscheme'`.mzc; \
	done

	# CMUCL, SBCL, and GCL are the same
	for j in `find bench -name '*.cmucl'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.cmucl'`.sbcl; \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.cmucl'`.gcl; \
	done

	# GHC, nhc98, and HUGS are the same
	for j in `find bench -name '*.ghc'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.ghc'`.nhc98; \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.ghc'`.hugs; \
	done

	# G++ and Intel C++ (ipp) are the same
	for j in `find bench -name '*.gcc'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.gcc'`.icc; \
	done
	for j in `find bench -name '*.gpp'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.gpp'`.icpp; \
	done

	# G95 and Intel Fortran are the same
	for j in `find bench -name '*.ifc'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.ifc'`.g95; \
	done

	touch links-stamp
