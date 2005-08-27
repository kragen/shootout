# $Id: Makefile,v 1.38 2005-08-27 19:43:54 igouy-guest Exp $

TESTS = \
    hello \
    ackermann \
    ary \
    binarytrees \
    chameneos \
    discovery \
    dispatch \
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
    raytracer \
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
    tcpsocket \
    tcpstream \
    wc \
    wordfreq

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber:
	-@for t in $(TESTS) ; do (cd $$t && $(BIN)/reset.bash &&  make $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

craps: $(TESTS)
	@../bin/make_craps $^
	
