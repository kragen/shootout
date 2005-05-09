# $Id: Makefile,v 1.27 2005-05-09 01:22:41 bfulgham Exp $

TESTS = \
    hello \
    ackermann \
    ary \
    echo \
    except \
    fannkuch \
    fasta \
    fibo \
    harmonic \
    hash \
    hash2 \
    health \
    heapsort \
    implicitode \
    knucleotide \
    lists \
    mandelbrot \
    matrix \
    matrixnorm \
    message \
    methcall \
    moments \
    nbody \
    nestedloop \
    nsieve \
    nsievebits \
    objinst \
    pidigits \
    plugin \
    process \
    prodcons \
    random \
    regexmatch \
    revcomp \
    reversefile \
    sieve \
    spectralnorm \
    spellcheck \
    strcat \
    sumcol \
    takfp \
    tcpecho \
    tcprequest \
    tcpstream \
    wc \
    wordfreq

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber:
	-@for t in $(TESTS) ; do (cd $$t && make $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

craps: $(TESTS)
	@../bin/make_craps $^
	
