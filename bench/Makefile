# $Id: Makefile,v 1.2 2004-05-23 05:18:56 bfulgham Exp $

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
    sieve \
    spellcheck \
    strcat \
    sumcol \
    wc \
    wordfreq

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber:
	@for t in $(TESTS) ; do (cd $$t && make $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

codelinks: $(TESTS)
	@../bin/make_codelinks $^

craps: $(TESTS)
	@../bin/make_craps $^

