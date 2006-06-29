# $Id: Makefile,v 1.47 2006-06-29 06:17:28 bfulgham Exp $
TESTS = \
    hello \
    ackermann \
    ary \
    binarytrees \
    chameneos \
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
    magicsquares \
    mandelbrot \
    matrix \
    message \
    methcall \
    moments \
    nbody \
    nestedloop \
    nsieve \
    nsievebits \
    objinst \
    partialsums \
    pidigits \
    process \
    prodcons \
    random \
    raytracer \
    recursive \
    regexdna \
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

# get rid of this hardcoded path
BIN:=/opt/shootout/shootout/bin

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber:
	-@for t in $(TESTS) ; do (cd $$t && $(BIN)/reset.bash &&  make -i $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

craps: $(TESTS)
	@../bin/make_craps $^
	
