# $Id: Makefile,v 1.1 2004-05-19 18:09:05 bfulgham Exp $

TESTS = \
    hello \
    ackermann \
    ary3 \
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

