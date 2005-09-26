# $Id: Makefile,v 1.38 2005-09-26 01:17:59 bfulgham Exp $

BIN := $(PWD)/bin/

include Make.header

all: init versions
	-bin/cascade_delete.bash
	-bin/preen.pl
	-bin/find_badlinks
	-(. bin/setenv.sh; cd bench ; make $@)
	-(cd bench ; make --no-print-directory report> report.txt)
	-bin/build_data_files
	-(bin/build_summary_file < ./website/data/ndata.csv > ./website/data/data.csv)
	-make codelinks

website: 
	-bin/cascade_delete.bash
	-bin/build_data_files
	-(bin/build_summary_file < ./website/data/ndata.csv > ./website/data/data.csv)
	-bin/compress_ndata	
	-bin/make_highlight
	-(cd website/code; ../../bin/add_strays)
	-cvs commit -m "Rerun of benchmarks."
	-bin/send_status.pl

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
