# $Id: Makefile,v 1.8 2004-12-05 01:59:48 bfulgham Exp $

TESTS = \
    hello \
    ackermann \
    ary \
    div2sum \
    echo \
    except \
    fannkuch \
    fasta \
    fibo \
    hash \
    hash2 \
    heapsort \
    josephus \
    lists \
    matrix \
    message \
    methcall \
    moments \
    nestedloop \
    nsieve \
    objinst \
    plugin \
    primesieve \
    process \
    procinst \
    prodcons \
    random \
    regexmatch \
    reversefile \
    ringmsg \
    sieve \
    spellcheck \
    strcat \
    sumcol \
    takfp \
    wc \
    wordfreq

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber: oberon-includes
	@for t in $(TESTS) ; do (cd $$t && make $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

codelinks: $(TESTS)
	@../bin/make_codelinks $^

craps: $(TESTS)
	@../bin/make_craps $^

oberon-includes: $(OO2C)
	@(cd Include/oberon2; for t in `ls *.Mod`; do oo2c -M $$t; done)
	touch oberon-includes
