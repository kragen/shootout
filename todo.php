<?php $title = "Computer Language Shootout Todo List";
      $keywords = "performance, benchmark, computer, algorithms, languages, compare, cpu, memory";
      require("html/header.php");
      require("html/toptabs.php");
      require("html/testnav.php");
      

      $parts = Explode('/', $_SERVER["SCRIPT_NAME"]);
      $current = $parts[count($parts) - 1];
	    
      toptabs($current) ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
<?php benchlist(".");
      nav_list_end(); ?>
  <td>
    <div id="bodycol">
      <div id="apphead"><h2>Todo List</h2></div>
      <div class="app">
      <ul>
        <li>Include SBCL, Chicken, and A+</li>
        <li>On language specific pages, put the total number of contenders in
	  each test.</li>
	<li>Investigate failure of mercury programs with gcc 3.0.</li>
	<li>Modify lists test to be a better test of deques.  intermix
	  operations from head and tail so that the reversal strategy does not
	  work.</li>
	<li>add a lists-1 test for singly linked lists (push, pop, map, apply,
	  fold, concat, length, reduce, filter, fold_left, ...)</li>
	<li>Split regexmatch into 2 tests, Basic Pattern Matching (e.g. a
	  "grep" test), and Regex matching with capture buffers.  (gforth,
	  awk, erlang? don't use capture buffers).  Should add more phone
	  numbers to input data.  Remove iteration loop and drive from large
	  input file, to be more realistic.</li>
	<li>standardize all cmucl commandline arg processing and optimization
	  calls.</li>
	<li>Experiment with Java classes and methods marking them "final".</li>
	<li>Replace LOC with token count.  (somewhat obviates need for coding
	  standards).  or else, Write a code submissions standard (arg
	  processing, output matching, style, 80 columns, etc), and rewrite
	  code according to guidelines.</li>
	<li>I need to re-evaluate all tests ... in general, all tests should be
	  designed so that there are no invariant calculations and no "unused
	  code" (objinst - mlton).  Try to cascade calculations so that the
	  latter depend on the former.  Tests that need invariants removed:
	  lists, regexmatch, matrix, sieve, objinst.</li>
	<li>Bulent M. suggests that I change the scoring algorithm on the craps
	  page so it reflects how much faster a language is.  I'm thinking I
	  might want to try to reflect overall ranking instead.  add combined
	  logarithmic score, and combined rank and subtract startup time
	  buttons.</li>
	<li>Stephen Weeks suggests: 10 * (best compiler CPU time / C's CPU time)</li>
	<li> John Aarts suggests:
	  <ul>
	    <li>For each test determine the max CPU test score (We do the same
	      for Memory and LOC scores)</li>
	    <li>For each language, for each test, calculate the normalized
	      score by dividing the test score by its related max test score
	      and multiplying this by 1000.</li>
	    <li>The language score is the weighted average of the normalized
	      scores, which is calculated by summing: (the normalized test
	      scores multiplied by their weights), and dividing this sum by the
	      sum of the weights.</li>
	    <li>The final language scores are now sorted in decreasing order
	      (low numbers are better).</li>
	  </ul></li>
	<li>Add compile-times to results tables.</li>
	<li>Add compile/run flags to language specific pages.</li>
	<li>Implement a CGI to compare languages selected from the home page
	  over all tests (or a selected subset).</li>
	<li>for GHC: try -fvia-C -O2-for-C (initial results show no change)</li>
	<li>make input files more challenging (exponential notation for floats,
	  negative numbers for integers).</li>
	<li>test result tables should reflect error/timeout conditions.</li>
	<li>Try new testing technique: have minibench automatically try larger
	  N until maxtime (30 seconds) is reached.  Then interpolate between N
	  and N+1 to get N for 30.  The higher N wins.  This gives the benefit
	  of doing tests in a throughput style, but they can still be written
	  as latency tests, and easily re-used by others as latency tests.</li>
	<li>possible problem with overflow for very fast languages.
	  <ul>
	    <li>it would be best for tests of this kind if they were cpu and
	      memory linear.  it would ensure less chance of overflow, and
	      easier interpolation.  curve-fitting?</li>
	    <li>maybe if a language overflows at higher N, we can extrapolate???</li>
	  </ul>
	</li>
	<li>In the Makefiles, allow user to easily specify which subset of
	  languages to run tests on</li>
	<li>It might be interesting to print total counts (total CPU/Mem/LOC)
	  on individual language summary pages.</li>
	<li>Rebuild with gcc, create build.lang scripts:
	  <ul>
	    <li>Icon
	  </ul>
	</li>
	<li>Change Rank on language summary pages to %score.  Actually we
	  should change the red-level calculation so it is based on percent of
	  score on each test.  rank range can vary widely over tests (depending
	  on %-completenes).  The current Avg. Rank is possibly misleading.</li>
	<li>Should limit producer/consumer to linux kernel threads.</li>
	<li>Ensure non-OO entries in objinst/methcall tests do the same work.</li>
	<li>Perhaps level the code length playing field by ignoring code for
	  command line argument processing.</li>
	<li>All tests need to be re-checked for adherence to stated test goals
	  and consistency of implementations across languages.  Re-check that
	  all programs read argv in standard way.  (spellcheck needs to be
	  reviewed for programs not doing line I/O).</li>
	<li>Language summary pages should reflect the "alternate" sources too?</li>
	<li>Mention NumPy on matrix mult page.  It's a commonly used library,
	  but not in the standard Python distribution.</li>
	<li>Test programs should all have a "reference" implementation, and a
	  tweaked implementation.  The reference implementations can go in the
	  Alernates section.</li>
	<li>We really need at least one larger scale "same thing" test.</li>
	<li>For gforth:
	  <ul>
	    <li>try "startup time" speedups (from info pages)</li>
	    <li>configure with --enable-force-reg (Anton Ertl)</li>
	    <li>try --enable-indirect-threading (Anton Ertl)</li>
	  </ul>
	</li>
	<li>work on the test descriptions.  add psuedo-code for "same way"
	  tests!</li>
	<li>Rewrite Makefiles so they use includes, not recursion!</li>
	<li>Fix minibench/makefiles so that if test fails, then minibench fails
	  and make stops.</li>
	<li>The C hash table source needs to be modified to be more fair: add
	  resize, allow value to be ptr to any type.  (allow key to be ptr to
	  anything, and pass in hash_code function?)</li>
	<li>Figure out why prodcons.rep started failing.</li>
	<li>After rebuilding SmallEiffel with gcc-2.95.3, programs that use the
	  dictionary class either run too long or dump core.  This needs to be
	  debugged.</li>
	<li>Have a results history comparison (speedup/slowdown???)</li>
	<li>Plot seconds logarithmically (gnuplot)?</li>
	<li>Check to see if we can reduce nestedloop line count for functional
	  languages by defining a loop function.</li>
	<li>New language requests:
	  <ul>
	    <li>Oscar Portela Arjona: Ciao Prolog
	      (<a href="http://clip.dia.fi.upm.es">http://clip.dia.fi.upm.es</a>)</li>
	    <li>JavaScript (http://www.mozilla.org/js/spidermonkey/)</li>
	    <li>objective C</li>
	    <li>simula</li>
	    <li>modula3</li>
	    <li>joy - http://www.latrobe.edu.au/www/philosophy/phimvt/j00syn.html (suggested by Julian Assange)</li>
	    <li>elastiC</li>
	    <li><a href="http://www.mozart-oz.org">http://www.mozart-oz.org</a></li>
	    <li>smalltalk squeak: <a href="http://www-sor.inria.fr/~piumarta/squeak/">
	      http://www-sor.inria.fr/~piumarta/squeak/</a></li>
	    <li>Alex Shinn: GNU Smalltalk</li>
	    <li>Andrew Sumner: Awka (awka.sourceforge.net)<li>
	    <li>CLISP</li>
	    <li>Rexx: http://www.rexxla.org/ (Mark Hessling -
	      http://www.lightlink.com/hessling/)</li>
	    <li>Jython: http://www.jython.org</li>
	    <li>Octave</li>
	    <li>Small: http://www.compuphase.com/small.htm</li>
	  </ul>
	<li>New Tests:</li>
	<ul>
	  <li>fractals.</li>
	  <li>Convex Hull calculation.</li>
	  <li>MD5 calculation: <a href="http://www.equi4.com/md5/">
	    http://www.equi4.com/md5/</a> (also find Don Libes Tcl MD5 code)</li>
	  <li>metacard wordstem test</li>
	  <li>parser test (to contrast with regexmatch test)</li>
	  <li>anagram (addagram?) generator</li>
	  <li>GIF deanimator</li>
	  <li>rfc822 address parser</li>
	  <li>quicksort?  (good for both recursive/iterative solutions)</li>
	  <li>tiny infix/postfix calculator implementation?</li>
	  <li>backtracking problem: knapsack/hanoi/n-queens?</li>
	  <li>GUI test?</li>
	  <li>dining philosophers: <a href="http://www.cis.temple.edu/~ingargio/cis307/readings/threads2.html">http://www.cis.temple.edu/~ingargio/cis307/readings/threads2.html</a></li>
	</ul>
      <li>Use getpack to check for new versions (and report)</li>
      <li>Christian Sunesson reports that MSIE can't properly display .java
        files as text even though they are served with content-type:
	text/plain!!!  Look into writing a CGI wrapper for displaying
	sourcecode.</li>
      <li>Research:
        <ul>
	  <li><a href="http://rsb.info.nih.gov/plasma/source.html">http://rsb.info.nih.gov/plasma/source.html</a></li>
	  <li><a href="http://www.byte.com/bmark/bdoc.htm">http://www.byte.com/bmark/bdoc.htm</a></li>
	  <li><a href="http://www.chat.net/~jeske/Projects/ScriptPerf/">http://www.chat.net/~jeske/Projects/ScriptPerf/</a></li>
	  <li><a href="http://www.xml.com/pub/a/Benchmark/exec.html">http://www.xml.com/pub/a/Benchmark/exec.html</a></li>
	  <li><a href="ftp://ftp.tuwien.ac.at/perf/benchmark/aburto/faq/">ftp://ftp.tuwien.ac.at/perf/benchmark/aburto/faq/</a></li>
	  <li><a href="http://www.cs.arizona.edu/icon/library/fprogs.htm">http://www.cs.arizona.edu/icon/library/fprogs.htm</a></li>
	  <li><a href="http://www.webcom.com/nazgul/change.html">http://www.webcom.com/nazgul/change.html</a></li>
	  <li><a href="http://www.uni-karlsruhe.de/~uu9r/lang/html/lang-all.en.html">http://www.uni-karlsruhe.de/~uu9r/lang/html/lang-all.en.html</a></li>
	</ul>
      </li>
    </ul>
  </div>
  </div>
  </td>
  </tr>
</table>
