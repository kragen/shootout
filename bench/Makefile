# $Id: Makefile,v 1.50 2007-11-08 22:01:47 igouy-guest Exp $
TESTS = \
    hello \
    binarytrees \
    chameneos \
    fannkuch \
    fasta \
    knucleotide \
    magicsquares \
    mandelbrot \
    message \
    messagering \
    nbody \
    nsieve \
    nsievebits \
    partialsums \
    pidigits \
    recursive \
    regexdna \
    revcomp \
    spectralnorm \
    sumcol

# get rid of this hardcoded path
BIN:=/opt/shootout/shootout/bin

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber:
	-@for t in $(TESTS) ; do (cd $$t && $(BIN)/reset.bash &&  make -i $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

craps: $(TESTS)
	@../bin/make_craps $^
	
