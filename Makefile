# $Id: Makefile,v 1.28 2005-05-25 07:02:18 bfulgham Exp $

include Make.header

all: init versions
	-bin/preen.pl
	-(cd bench ; make $@)
	-(cd bench ; make --no-print-directory report> report.txt)
	-bin/build_data_files
	-bin/build_summary_file < website/data/ndata.csv > website/data/data.csv
	-make codelinks

website: 
	-bin/build_data_files
	-bin/compress_ndata	
	-bin/make_highlight
	-(cd website/code; ../../bin/add_strays)
	-cvs commit -m "Rerun of benchmarks."

test plot show loc:
	-(cd bench ; make $@)

clean:
	-(cd bench ; make $@)

.PHONY: dist report recent versions codelinks website

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
	-touch init-stamp

links:  links-stamp
links-stamp:
	-@bin/make_links
	touch links-stamp
