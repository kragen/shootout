# $Id: Makefile,v 1.4 2004-08-30 06:23:13 bfulgham Exp $

TESTS = \
    hello \
    ackermann \
    ary \
    echo \
    except \
    fibo \
    hash \
    hash2 \
    heapsort \
    lists \
    matrix \
    methcall \
    moments \
    nestedloop \
    objinst \
    prodcons \
    random \
    regexmatch \
    reversefile \
    ringmsg \
    sieve \
    spellcheck \
    strcat \
    sumcol \
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
