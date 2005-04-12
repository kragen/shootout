# $Id: Makefile,v 1.20 2005-04-12 15:04:48 bfulgham Exp $

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

all plot test loc show clean clobber: oberon-includes
	-@for t in $(TESTS) ; do (cd $$t && make $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

craps: $(TESTS)
	@../bin/make_craps $^

oberon-includes: $(OO2C)
	@(cd Include/oberon2; for t in `ls *.Mod`; do oo2c -M $$t; done)
	touch oberon-includes
