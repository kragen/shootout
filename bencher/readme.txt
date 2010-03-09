# The Computer Language Benchmarks Game
# $Id: readme.txt,v 1.3 2010-03-09 20:36:46 igouy-guest Exp $

	bencher - The Computer Language Benchmarks Game - March 2010



 AUDIENCE

 - someone who wants to measure programs of their own



 MOTIVATION

 simplify The Computer Language Benchmarks Game measurement script

 bencher does repeated measurements of program cpu time, elapsed time,
 resident memory usage, cpu load while a program is running.



 LAZY, STUBBORN, QUIET

 bencher only measures when there is no dat file to match every
 program source code file, or when the dat file is older than
 the program source code file.

 bencher will try to measure elapsed times when unable to measure
 memory use and cpu load; bencher will try a basic check when diff
 is not available; bencher will give a basic size for source code
 when highlight is not available.

 bencher usually writes good news to the console; for the bad news
 look through bencher/tmp/bencher.log



 REQUIREMENTS

 Python 2.5+ (these are Python scripts)

 [ WIN32 SPECIFIC REQUIREMENTS ]

 Python Win32 Extensions (for win32 process monitoring)
   see http://sourceforge.net/projects/pywin32/

   (add \Python26 to the system path)


 RECOMMENDATIONS

 ndiff (to check program output more selectively)
    see http://www.math.utah.edu/~beebe/software/ndiff/

 highlight: code & syntax highlighting
   see http://www.andre-simon.de/doku/highlight/en/highlight.html


 LINUX SPECIFIC RECOMMENDATIONS
 
 GNU make (to compile programs for compiled languages)
 GNU diff & cmp (to check program output is as expected)

 libgtop2 dev files and Python bindings
    (for cpu load and resident memory measurement)

 [ WIN32 SPECIFIC RECOMMENDATIONS ]

 GNU Make for Windows
   see http://gnuwin32.sourceforge.net/packages/make.htm

 GNU DiffUtils for Windows
   see http://gnuwin32.sourceforge.net/packages/diffutils.htm

   (add GnuWin32\bin to the system path)

   (add highlight to the system path)



 LINUX QUICK START [ WIN32 QUICK START ]

 1) unzip in ~ directory [ unzip in c:\ ]

    The default configuration only creates files in the bencher
    subdirectory

 2) cd ~/bencher [ cd c:\bencher ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini

  [ python bin\bencher.py --conf makefiles\my.win32.ini ]

    measure cpu & elapsed time & memory & cpu load
    Sat 18:06:02 .....OK nbody.python [4]
    Sat 18:06:06 .MAKE ERROR nbody.compiledpython [3]
    Sat 18:06:06 .OK regexdna.python [2]
    Sat 18:06:06 .MAKE ERROR regexdna.compiledpython [1]

 4) look through tmp/bencher.log

  [ look through tmp\bencher.log ]

    2010-03-06 18:06:02,657 DEBUG make program not found
    2010-03-06 18:06:02,657 DEBUG ndiff program not found
    2010-03-06 18:06:02,657 DEBUG cmp program not found
    2010-03-06 18:06:02,657 DEBUG diff program not found
    2010-03-06 18:06:02,657 DEBUG mkdir c:\bencher\tmp\nbody
    2010-03-06 18:06:02,657 DEBUG mkdir c:\bencher\tmp\nbody\log
    2010-03-06 18:06:02,657 DEBUG mkdir c:\bencher\tmp\nbody\dat
    2010-03-06 18:06:02,657 DEBUG mkdir c:\bencher\tmp\nbody\code
    2010-03-06 18:06:02,671 DEBUG mkdir c:\bencher\tmp\regexdna\log
    2010-03-06 18:06:02,671 DEBUG mkdir c:\bencher\tmp\regexdna\dat
    2010-03-06 18:06:02,671 DEBUG mkdir c:\bencher\tmp\regexdna\code
    2010-03-06 18:06:06,088 INFO .....OK nbody.python [4]
    2010-03-06 18:06:06,088 DEBUG make nbody.compiledpython_run - make program not found
    2010-03-06 18:06:06,119 INFO .MAKE ERROR nbody.compiledpython [3]
    2010-03-06 18:06:06,213 INFO .OK regexdna.python [2]
    2010-03-06 18:06:06,213 DEBUG make regexdna.compiledpython_run - make program not found
    2010-03-06 18:06:06,259 INFO .MAKE ERROR regexdna.compiledpython [1]
    2010-03-06 18:06:06,259 INFO mkcsv building csv files from nbody\dat
    2010-03-06 18:06:06,259 INFO mkcsv building csv files from regexdna\dat
    2010-03-06 18:06:06,259 INFO copy *.csv files to c:\bencher\summary
    2010-03-06 18:06:06,259 INFO copy *.log files to c:\bencher\run_logs

 5) look through summary/measurements.csv

  [ look through summary\measurements.csv ]

    name,lang,id,n,size(B),cpu(s),mem(KB),status,load,elapsed(s)
    nbody,python,1,10000,0,0.265,5572,0,%,0.258
    nbody,python,1,20000,0,0.468,5572,0,%,0.463
    nbody,python,1,30000,0,0.671,5572,0,%,0.677
    nbody,python,1,40000,0,0.889,5580,0,%,0.892
    nbody,python,1,50000,0,1.092,5572,0,%,1.106
    regexdna,python,1,10000,0,0.094,5932,0,%,0.092



 INSTALL GNU MAKE AND DO_OVER

 3) python bin/bencher.py --conf makefiles/my.linux.ini compiledpython 

  [ python bin\bencher.py --conf makefiles\my.win32.ini compiledpython ]

    measure cpu & elapsed time & memory & cpu load
    Sat 18:11:49 .....OK nbody.compiledpython [2]
    Sat 18:11:53 .OK regexdna.compiledpython [1]


 4) look through tmp/bencher.log

  [ look through tmp\bencher.log ]

    2010-03-06 18:11:49,553 DEBUG ndiff program not found
    2010-03-06 18:11:49,553 DEBUG cmp program not found
    2010-03-06 18:11:49,553 DEBUG diff program not found
    2010-03-06 18:11:49,553 INFO remove c:\bencher\tmp\regexdna\dat regexdna.1.compiledpython_dat
    2010-03-06 18:11:49,553 INFO remove c:\bencher\tmp\nbody\dat nbody.1.compiledpython_dat
    2010-03-06 18:11:53,328 INFO .....OK nbody.compiledpython [2]
    2010-03-06 18:11:53,516 INFO .OK regexdna.compiledpython [1]
    2010-03-06 18:11:53,516 INFO mkcsv building csv files from nbody\dat
    2010-03-06 18:11:53,532 INFO mkcsv building csv files from regexdna\dat
    2010-03-06 18:11:53,532 INFO copy *.csv files to c:\bencher\summary
    2010-03-06 18:11:53,532 INFO copy *.log files to c:\bencher\run_logs


 5) look through summary/measurements.csv

  [ look through summary\measurements.csv ]

    name,lang,id,n,size(B),cpu(s),mem(KB),status,load,elapsed(s)
    nbody,compiledpython,1,10000,0,0.250,5436,0,%,0.264
    nbody,compiledpython,1,20000,0,0.484,5436,0,%,0.495
    nbody,compiledpython,1,30000,0,0.733,5436,0,%,0.725
    nbody,compiledpython,1,40000,0,0.952,5440,0,%,0.956
    nbody,compiledpython,1,50000,0,1.186,5432,0,%,1.187
    nbody,python,1,10000,0,0.265,5572,0,%,0.258
    nbody,python,1,20000,0,0.468,5572,0,%,0.463
    nbody,python,1,30000,0,0.671,5572,0,%,0.677
    nbody,python,1,40000,0,0.889,5580,0,%,0.892
    nbody,python,1,50000,0,1.092,5572,0,%,1.106
    regexdna,compiledpython,1,10000,0,0.094,6052,0,%,0.091
    regexdna,python,1,10000,0,0.094,5932,0,%,0.092



 LINUX FORCE DO-OVER [ WIN32 FORCE DO-OVER ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini python compiledpython

  [ python bin\bencher.py --conf makefiles\my.win32.ini python compiledpython ]

    measure cpu & elapsed time & memory & cpu load
    Sat 18:16:26 .....OK nbody.python [4]
    Sat 18:16:29 .....OK nbody.compiledpython [3]
    Sat 18:16:33 .OK regexdna.python [2]
    Sat 18:16:33 .OK regexdna.compiledpython [1]


 LINUX FORCE DO-OVER AGAIN [ WIN32 FORCE DO-OVER AGAIN ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini python regexdna

  [ python bin\bencher.py --conf makefiles\my.win32.ini python regexdna ]

    measure cpu & elapsed time & memory & cpu load
    Sat 18:17:45 .....OK nbody.python [3]
    Sat 18:17:48 .OK regexdna.python [2]
    Sat 18:17:48 .OK regexdna.compiledpython [1]


 AND AGAIN [ AND AGAIN ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini nbody python

  [ python bin\bencher.py --conf makefiles\my.win32.ini nbody python ]

    measure cpu & elapsed time & memory & cpu load
    Sat 18:18:31 .....OK nbody.python [3]
    Sat 18:18:35 .....OK nbody.compiledpython [2]
    Sat 18:18:39 .OK regexdna.python [1]


 OTHERWISE [ OTHERWISE ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini

  [ python bin\bencher.py --conf makefiles\my.win32.ini ]

    measure cpu & elapsed time & memory & cpu load
    nothing to be done - measurements are up-to-date



 QUICK FIXES

 Check PYTHON in the [tools] section of makefiles/my.*.ini is correct

 To force measurement of just one program, delete the corresponding dat file
 and re-measure.

 For example, 
    to force measurement of regexdna.python

    rm -f tmp/regexdna/dat/regexdna.1.python_dat 

  [ del tmp\regexdna\dat\regexdna.1.python_dat ]


    python bin/bencher.py --conf makefiles/my.linux.ini

  [ python bin\bencher.py --conf makefiles\my.win32.ini ]

    measure cpu & elapsed time & memory & cpu load
    Sat 18:21:56 .OK regexdna.python [1]


 BASIC ASSUMPTIONS
 
 Program source files are organized by 'benchmark' in different subdirectories,
 and program source files have the same name as the 'benchmark' distinguished
 by file extension, for example:

  programs
     nbody			subdirectory
        nbody.python		program source file
        nbody.gcc		program source file
        nbody.gcc-2.gcc		program source file

     regexdna			subdirectory
        regexdna.python		program source file
        regexdna.gcc		program source file
        regexdna.perl-2.perl	program source file


 For each source code subdirectory in programs a matching directory 
 will be created under tmp, containing -

     data subdirectory - compressed measurement files
     log subdirectory - log text files recording each program build and run
     tmp subdirectory - files needed to build and measure the current program
     expected output files for various data input sizes *_out



 TESTDATA

 The location of the test data redirected to stdin for knucleotide, 
 regexdna, and revcomp is given by a relative path in the [testdata]
 section of bencher/makefiles/my.*.ini

 The default locations are: 
   bencher/tmp/knucleotide [ bencher\tmp\knucleotide ]
   bencher/tmp/regexdna    [ bencher\tmp\regexdna ]
   bencher/tmp/revcomp     [ bencher\tmp\revcomp ]

 Test data files of appropriate sizes should be generated using the fasta program
 and named according to benchmark and size, for example: 
 
  knucleotide-input50000.txt
  knucleotide-input500000.txt
  knucleotide-input5000000.txt

  regexdna-input50000.txt
  regexdna-input500000.txt
  regexdna-input5000000.txt
  
