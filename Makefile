# $Id: Makefile,v 1.3 2004-06-18 09:34:00 dbr-guest Exp $

include Make.header

all: versions links
	(cd bench ; make $@)
	(cd bench ; make --no-print-directory report> report.txt)
	make recent craps codelinks

test plot show loc:
	(cd bench ; make $@)

clean:
	(cd bench ; make $@)

.PHONY: dist report recent versions craps codelinks

versions: versions.html

versions.html: $(LANGS) bin/make_versions langs.pl
	bin/make_versions > versions.html.tmp && \
	mv -f versions.html.tmp versions.html

dist:
	bin/make_dist

report codelinks:
	@(cd bench ; make --no-print-directory $@)

craps:
	@(cd bench ; make --no-print-directory $@) > .craps.table

recent:
	@bin/make_recent > recent.html

links:
	for j in `find bench -name '*.java'`; do \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.java'`.kaffe; \
		ln -sf `basename $$j` `expr $$j : '\(.*\)\.java'`.gcj; \
	done
