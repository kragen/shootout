# The Computer Language Benchmarks Game - linux

# ASSUME each program will build in a clean empty tmpdir
# ASSUME there's a symlink to the program source in tmpdir
# ASSUME there's a symlink to the Include directory in tmpdir
# ASSUME there are symlinks to helper files in tmpdir
# ASSUME no responsibility for removing temporary files from tmpdir

# TYPICAL actions include an initial mv to give the expected extension 

# ASSUME environment variables for compilers and interpreters are set in the header


COPTS := -O3 -fomit-frame-pointer



############################################################
# ACTIONS for specific language implementations
############################################################


########################################
# Python
########################################

%.compiledpython_run: %.compiledpython $(PYTHON)
	-mv $< $*.py
	-$(PYTHON) -OO -c "from py_compile import compile; compile('$*.py')"


########################################
# java
########################################

%.java_run: %.java $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java

%.javaxint_run: %.javaxint $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java

%.javaclient_run: %.javaclient $(JDKRUN)
	-mv $< $(TEST).java
	-$(JDKC) $(TEST).java


########################################
# gcc
########################################

%.c: %.gcc $(GCC)
	-@mv $< $@

%.gcc_run: %.c $(GCC)
	-$(GCC) -pipe -Wall $(COPTS) $(GCCOPTS) $< -o $@


########################################
# gpp
########################################

%.c++: %.gpp $(GXX)
	-@mv $< $@

%.gpp_run: %.c++
	-$(GXX) -c -pipe $(COPTS) $(GXXOPTS) $< -o $<.o &&  \
        $(GXX) $<.o -o $@ $(GXXLDOPTS) 


