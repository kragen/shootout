
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
 is not available.

 bencher usually writes good news to the console; for the bad news
 look through bencher/tmp/bencher.log



 REQUIREMENTS

 Python 2.5+ (these are Python scripts)
 GNU make (to compile programs for compiled languages)
 GNU diff & cmp (to check program output is as expected)
 ndiff (to check program output more selectively)
    see http://www.math.utah.edu/~beebe/software/ndiff/

 LINUX SPECIFIC REQUIREMENTS

 libgtop2 dev files and Python bindings
    (for cpu load and resident memory measurement)

 [ WIN32 SPECIFIC REQUIREMENTS ]

 Python Win32 Extensions (for win32 process monitoring)
   see http://sourceforge.net/projects/pywin32/

   (add \Python26 to the system path)

 GNU Make for Windows
   see http://gnuwin32.sourceforge.net/packages/make.htm

 GNU DiffUtils for Windows
   see http://gnuwin32.sourceforge.net/packages/diffutils.htm

   (add GnuWin32\bin to the system path)



 LINUX QUICK START [ WIN32 QUICK START ]

 1) unzip in ~ directory [ unzip in c:\ ]

    The default configuration only creates files in the bencher
    subdirectory

 2) cd ~/bencher [ cd c:\bencher ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini

  [ python bin\bencher.py --conf makefiles\my.win32.ini ]

    measure cpu & elapsed time & memory & cpu load
    Fri 18:01:21 .....OK binarytrees.python [4]
    Fri 18:01:30 .....OK binarytrees.compiledpython [3]
    Fri 18:01:41 .OK regexdna.python [2]
    Fri 18:01:41 .OK regexdna.compiledpython [1]

 4) look through tmp/bencher.log

  [ look through tmp\bencher.log ]

    2010-03-05 18:01:21,430 DEBUG mkdir /home/dunham/bencher/tmp/binarytrees
    2010-03-05 18:01:21,430 DEBUG mkdir /home/dunham/bencher/tmp/binarytrees/log
    2010-03-05 18:01:21,430 DEBUG mkdir /home/dunham/bencher/tmp/binarytrees/dat
    2010-03-05 18:01:21,430 DEBUG mkdir /home/dunham/bencher/tmp/binarytrees/code
    2010-03-05 18:01:21,431 DEBUG mkdir /home/dunham/bencher/tmp/regexdna/log
    2010-03-05 18:01:21,431 DEBUG mkdir /home/dunham/bencher/tmp/regexdna/dat
    2010-03-05 18:01:21,431 DEBUG mkdir /home/dunham/bencher/tmp/regexdna/code
    2010-03-05 18:01:21,431 INFO 2 No such file or directory /home/dunham/bencher/tmp/binarytrees/tmp
    2010-03-05 18:01:30,732 INFO .....OK binarytrees.python [4]
    2010-03-05 18:01:41,046 INFO .....OK binarytrees.compiledpython [3]
    2010-03-05 18:01:41,047 INFO 2 No such file or directory /home/dunham/bencher/tmp/regexdna/tmp
    2010-03-05 18:01:41,122 INFO .OK regexdna.python [2]
    2010-03-05 18:01:41,300 INFO .OK regexdna.compiledpython [1]
    2010-03-05 18:01:41,300 INFO mkcsv building csv files from binarytrees/dat
    2010-03-05 18:01:41,301 INFO mkcsv building csv files from regexdna/dat
    2010-03-05 18:01:41,302 INFO copy *.csv files to /home/dunham/bencher/summary
    2010-03-05 18:01:41,302 INFO copy *.log files to /home/dunham/bencher/run_logs

 5) look through summary/measurements.csv

  [ look through summary\measurements.csv ]

    name,lang,id,n,size(B),cpu(s),mem(KB),status,load,elapsed(s)
    binarytrees,compiledpython,1,8,0,0.180,0,0,20% 0% 7% 100%,0.147
    binarytrees,compiledpython,1,10,0,0.320,0,0,40% 5% 30% 86%,0.204
    binarytrees,compiledpython,1,12,0,1.120,33848,0,64% 50% 70% 63%,0.451
    binarytrees,compiledpython,1,14,0,5.020,47308,0,79% 80% 71% 81%,1.581
    binarytrees,compiledpython,1,16,0,25.150,109096,0,89% 77% 69% 86%,7.818
    binarytrees,python,1,8,0,0.080,0,0,11% 0% 13% 75%,0.073
    binarytrees,python,1,10,0,0.280,0,0,64% 36% 55% 100%,0.109
    binarytrees,python,1,12,0,0.970,23040,0,73% 85% 22% 73%,0.388
    binarytrees,python,1,14,0,4.950,46916,0,88% 87% 86% 74%,1.469
    binarytrees,python,1,16,0,25.360,108288,0,93% 83% 82% 89%,7.243
    regexdna,python,1,10000,0,0.070,0,0,0% 0% 100% 0%,0.071
    regexdna,compiledpython,1,10000,0,0.100,0,0,100% 0% 0% 0%,0.093



 LINUX FORCE DO-OVER [ WIN32 FORCE DO-OVER ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini python

  [ python bin\bencher.py --conf makefiles\my.win32.ini python ]

    measure cpu & elapsed time & memory & cpu load
    Fri 18:04:15 .....OK binarytrees.python [2]
    Fri 18:04:25 .OK regexdna.python [1]



 LINUX FORCE DO-OVER AGAIN [ WIN32 FORCE DO-OVER AGAIN ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini python compiledpython

  [ python bin\bencher.py --conf makefiles\my.win32.ini python compiledpython ]

    measure cpu & elapsed time & memory & cpu load
    Fri 18:04:37 .....OK binarytrees.python [4]
    Fri 18:04:48 .....OK binarytrees.compiledpython [3]
    Fri 18:04:58 .OK regexdna.python [2]
    Fri 18:04:58 .OK regexdna.compiledpython [1]



 AND AGAIN [ AND AGAIN ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini python regexdna

  [ python bin\bencher.py --conf makefiles\my.win32.ini python regexdna ]

    measure cpu & elapsed time & memory & cpu load
    Fri 18:05:07 .....OK binarytrees.python [3]
    Fri 18:05:17 .OK regexdna.python [2]
    Fri 18:05:17 .OK regexdna.compiledpython [1]



 AND AGAIN [ AND AGAIN ]

 3) python bin/bencher.py --conf makefiles/my.linux.ini binarytrees python

  [ python bin\bencher.py --conf makefiles\my.win32.ini binarytrees python ]

    measure cpu & elapsed time & memory & cpu load
    Fri 18:09:41 .....OK binarytrees.python [3]
    Fri 18:09:52 .....OK binarytrees.compiledpython [2]
    Fri 18:10:02 .OK regexdna.python [1]



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
    Fri 18:30:35 .OK regexdna.python [1]



 BASIC ASSUMPTIONS
 
 Program source files are organized by 'benchmark' in different subdirectories,
 and program source files have the same name as the 'benchmark' distinguished
 by file extension, for example:

  programs
     binarytrees                     subdirectory
        binarytrees.python           program source file
        binarytrees.gcc              program source file
        binarytrees.gcc-2.gcc        program source file

     regexdna	                     subdirectory
        regexdna.python              program source file
        regexdna.gcc                 program source file
        regexdna.perl-2.perl         program source file


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
  
