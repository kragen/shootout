# $Id: Makefile,v 1.51 2007-11-11 22:11:12 igouy-guest Exp $
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
    nbody \
    nsieve \
    nsievebits \
    partialsums \
    pidigits \
    recursive \
    regexdna \
    revcomp \
    spectralnorm \
    sumcol \
    threadring

# get rid of this hardcoded path
BIN:=/opt/shootout/shootout/bin

.PHONY: all plot test show clean clobber report

all plot test loc show clean clobber:
	-@for t in $(TESTS) ; do (cd $$t && $(BIN)/reset.bash &&  make -i $@) ; done

report: $(filter-out %.ocamlb,$(foreach dir,$(TESTS),$(wildcard $(dir)/$(dir).*)))
	@../bin/make_report $^

craps: $(TESTS)
	@../bin/make_craps $^
	
