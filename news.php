<?php require("html/header.php");
      require("nav.html");
      require("html/toptabs.php");

      $parts = Explode('/', $_SERVER["SCRIPT_NAME"]);
      $current = $parts[count($parts) - 1];

      toptabs($current);
?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
    <td id="leftcol" width="20%">
      <div id="navcolumn">
        <div id="methodology" class="toolgroup">
	  <div class="label">
            <strong>Methodology</strong>
          </div>
	  <div class="body">
	    <div><a href="#news">News</a></div>
	  </div>
	</div>
      <div class="strut">&nbsp;</div>
    </td>
    <td>
      <div id="bodycol">
        <div id="apphead"><h2>News</h2></div>
	<div class="app" id="news">
	  <p>This page contains notices of major changes to the Shootout.
	    Note that you can also view the <a href="recent.php">
	    Activity Log</a> to see which files have changed recently.</p>

<?php require("http://alioth.debian.org/export/projnews.php?group_id=10039&limit=20&flat=0&show_summaries=1"); ?>

<b>2004-05-27</b>
<ul>
  <li><b>The shootout is revived as a Debian Alioth project!</b></li>
  <li>All interpreters and compilers updated to Debian unstable revisions.
    Anything unavailable as a Debian package omitted from project.  At this
    point that means <a href="lang/bigforth">bigforth</a> and
    <a href="lang/mercury">mercury</a> are not included.</li>
</ul>

<b>2001-12-12</b>
<ul>
<li><b>Due to wanting to get on with other things,
I'm freezing the shootout as is, with no further updates planned.
It isn't complete, just abandoned (for now).
</b>
</ul>

<b>2001-10-25</b>
<ul>
<li>
  BIG NEWS: Aldo Calpini has put a huge amount of work into porting
  my shootout to Microsoft Windows.  He even includes some new languages
  and some commercial compilers that run on Windows.  <a
  href="http://dada.perl.it/shootout">Please click here to check it
  out</a>.
  Many thanks to Aldo!  (Please note that there may be
  differences between his work and mine).
</ul>

<b>2001-07-08</b>
<ul>
<li>Upgraded <a href="lang/smlnj/">SML/NJ</a> to 110.0.7.
<li>Upgraded <a href="lang/ruby/">Ruby</a> to 1.6.4.
<li>
  Started adding <a href="lang/njs/">NJS Javascript</a>, thanks to
  David Hedbor for submitting all the solutions so far.
</ul>

<b>2001-07-06</b>
<ul>
<li>
  We're back after that <a href="slashhole.shtml">Slashdotting</a>,
  but I need to monitor my bandwidth usage and if things get rough I
  may have to go off-line again.  I do have a very generous offer for
  another host I can use for the shootout, so the future looks bright.
  Sorry for the inconvenience.
</ul>

<b>2001-07-03</b>
<ul>
<li>
  The shootout gets <a href="slashhole.shtml">slashdotted</a>, so I
  took down my web server.
</ul>

<b>2001-06-28</b>
<ul>
<li>
  Now each test has a link on the index page (over the data table) to
  allow you to view CPU times minus process startup time.  The startup
  time is calculated from the <a href="bench/hello/">Hello World</a>
  (null program) test.  You'll see the biggest change for the languages
  with the largest startup time: Java, Erlang and XEmacs.  This is an
  experiment, and won't really be canonified until I'm satisfied it is
  realistic.
</ul>

<b>2001-06-25</b>
<ul>
<li>
  I've refined the definition of the <a href="bench/wc/">wordcount
  test</a>, and increased the size of its input so it runs a little
  longer now.
<li>
  I've moved the language specific performance hints to the <a
  href="lang/">summary pages</a>.
</ul>

<b>2001-06-24</b>
<ul>
<li>
  I've written clearer, more restrictive rules for the following
  tests:
  <a href="bench/prodcons/">Producer Consumer</a>, 
  <a href="bench/strcat/">String Concatenation</a>. 
  Because of this, a few entries had to be moved to the alternates
  section on the respective test pages.
</ul>

<b>2001-06-19</b>
<ul>
<li>
  Upgraded to GCC/G++ 3.0.  A number of G++ programs slowed down
  dramatically.
</ul>

<b>2001-06-17</b>
<ul>
<li>
  New test: <a href="bench/hello/">Hello World</a>.  This is basically
  a <i>null program</i> test, for the purpose of measuring program
  startup time.
</ul>

<b>2001-06-10</b>
<ul>
<li>
  The language summary pages now include a link to the script I use to
  build each language, so you can see how they are built.  This is
  to support my intention for total documentation of this project.
<li>
  Added a <a href="todo.php">Todo List</a>.  It seems to keep getting
  longer and longer.
</ul>

<b>2001-06-10</b>
<ul>
<li>
  I have obsoleted the <a href="bench/ary/">Array Test</a> and <a
  href="bench/ary2/">Array Test II</a>, and replaced them with a new
  <a href="bench/ary3/">Array Test</a>.  The original 2 were flawed in
  that they were, in some cases, measuring the array initilization,
  not just array accessing.  I'm currently inclined to avoid the issue
  of loop overhead, which the <a href="bench/ary2/">Array Test II</a>
  was intended to show.  In some ways, loop overhead is part of the
  necessary expense of iterating over a loop while accessing its
  elements, and I'm not likely to go around unrolling all the other
  micro-benchmarks.  Still, it is interesting to note the effects, and
  so those old pages remain archived, and won't go away.  They just
  will not be updated anymore, nor included in the overall scoring.
</ul>

<b>2001-06-09</b>
<ul>
<li>
  Increased (3x) the run-time of the <a href="bench/sieve/">Sieve</a> test.
<li>
  Now each detail page allows you to limit choose only languages you
  wish to compare, <a
  href="http://shootout.alioth.debian.org/bench/echo/detail.php?g%2B%2B=on&gcc=on&java=on&ocaml=on">for
  example</a>.  The detail graphs were getting rather cluttered, and I
  thought this would be one nice way to unclutter them.
</ul>

<b>2001-05-31</b>
<ul>
<li>
 Memory sizes for all threaded programs (using LinuxThreads, that is)
 were calculated incorrectly.  (i.e. all the Java programs and all the
 programs in the <a href="bench/prodcons/">Producer/Consumer</a> test
 that use native Linux threads).  I've made a fix to my minibench test
 harness so that only <i>main threads</i> are counted for memory usage.
 This is probably still somewhat suspect, but should be closer than the
 wacky numbers previously reported.  Figuring out the main thread and
 memory usage should still be considered voodoo.
</ul>

<b>2001-05-28</b>
<ul>
<li>
 The shootout now runs on a completely dedicated test host and is
 rsynced back to my web server after updates.  Having a dedicated host
 should minimize variability in timings from run to run.
</ul>

<b>2001-05-28</b>
<ul>
<li>Upgraded Java to 1.3.1-b24.
<li>Rebuilt Bash, Bigloo, Gawk, GForth, Guile, Mawk, Mercury, MLton,
Ocaml, Perl, Pike, Python, Ruby, SML/NJ, SmallEiffel, Tcl, XEmacs and
the languages below with GCC 2.95.3.  After the rebuild some
SmallEiffel programs (ones that use the dictionary class) no longer
complete, and the threaded Rep program fails to start.
<li>Upgraded Erlang to Beam 5.0.2 (OTP R7B-2).
<li>Upgraded Haskell to 5.00.1.
<li>Upgraded Lua to 4.0.
<li>Upgraded PHP to 4.0.5.
<li>Upgraded Rep to 0.13.6.
</ul>

<b>2001-05-26</b>
<ul>
<li>Upgraded GCC/G++ to 2.95.3
</ul>

<b>2001-05-23</b>
<ul>
<li>
  The <a href="download/">download tarball</a> is now updated nightly
  so it will not get out of date.
<li>
  To emphasize the distinction between natively compiled and interpreted
  languages, now the names of natively compiled languages are highlighted
  in <b><i>bold italics</i></b> where they appear in most places.
</ul>

<b>2001-05-22</b>
<ul>
<li>Upgraded Bash to 2.05.
</ul>

<b>2001-05-19</b>
<ul>
<li>
  Individual <a href="lang/">language pages</a> now show where a
  language does worse than its average ranking.  This may be useful
  to hint which programs could possibly be better optimized.
<li>
  I have expanded the page on <a href="method.php">Methodology</a>, and
  now include an explicit list of <a href="method.php#flaws">recognized
  flaws</a> in this shootout.
</ul>

<b>2001-05-17</b>
<ul>
<li>
  Added <a href="lang/mlton/">MLton</a>, another SML compiler that is
  somewhat faster than <a href="lang/smlnj/">SML/NJ</a>.
</ul>

<b>2001-05-16</b>
<ul>
<li>Upgraded Ruby to 1.6.3.
<li>Upgraded Tcl to 8.3.3.
</ul>

<b>2001-05-14</b>
<ul>
<li>
  New test, <a href="bench/wc/">Wordcount</a>, counts the number of
  lines, words, and characters in the input.
</ul>

<b>2001-05-08</b>
<ul>
<li>Released version 0.1.10.  See the <a href="download/">download page</a>.
</ul>

<b>2001-05-06</b>
<ul>
<li>
  New experimental feature: each language now has its own local
  <a href="lang/">summary page</a>.
<li>Upgraded Python to 2.1.
</ul>

<b>2001-05-05</b>
<ul>
<li>Now the tables on the test index pages can be sorted by the
different metrics (cpu, mem, lines of code).
</ul>

<b>2001-05-04</b>
<ul>
<li>
  New experimental metric!  I now also rate languages on number of
  lines of code in the test programs.  
</ul>

<b>2001-05-03</b>
<ul>
<li>Upgraded Mercury to 0.10.1.
</ul>

<b>2001-05-02</b>
<ul>
<li>Upgraded Haskell to 5.00.
<li>
  I investigated Linux's BSD process accounting feature as a means of
  fixing the memory measurement inaccuracies, but it won't work.  Read
  about it on the <a href="method.php">Methodology</a> page.  Memory
  numbers have improved in accuracy, but should still be treated with
  caution.
</ul>

<b>2001-05-01</b>
<ul>
<li>
  Modified the following tests to run for a longer time: 
  <a href="bench/methcall/">Method Calls</a>, 
  <a href="bench/objinst/">Object Instantiation</a>.
<li>Added the Ocaml byte compiler for comparison.
</ul>

<b>2001-04-30</b>
<ul>
<li>Added a couple new pages: <a href="editorial.php">Editorial</a>
and <a href="conclusion.shtml">Conclusion</a>.
<li>Upgraded Perl to 5.6.1.
</ul>

<b>2001-04-29</b>
<ul>
<li>
  Modified the following tests to run for a longer time: 
  <a href="bench/ary/">Array</a>, 
  <a href="bench/ary2/">Array II</a>, 
  <a href="bench/except/">Exceptions</a>, 
  <a href="bench/sieve/">Sieve</a>.  The longer run-times should allow
  my memory sampling technique to work better, and it should also help
  discriminate better between the compiled programs that complete
  these tests very quickly.
</ul>

<b>2001-04-28</b>
<ul>
<li>
  I discovered a problem in how I was measuring memory, which mostly
  affected the compiled languages.  This problem has been mostly
  fixed, but there is still a possibility of error in the memory
  sampling technique that I use.  I feel more confident about the
  memory numbers now.  There will be more news on this later.  The
  CPU measurements do seem to hold up fairly consistently.
</ul>

<b>2001-04-27</b>
<ul>
<li>
  Upgraded Ocaml to 3.01.  This upgrade allowed Ocaml to pull even
  with G++ in terms of CPU speed for now.
</ul>

<b>2001-04-26</b>
<ul>
<li>Upgraded Pike to 7.2.30.
<li>Upgraded SmallEiffel to 0.76.
<li>Added mawk to compare to gawk.  mawk blows gawk's socks off for
the most part.
</ul>

<b>2001-04-16</b>
<ul>
<li>Back from vacation :-)  Started off adding in PHP with a
contribution from Alexander Klimov.
</ul>

<b>2001-01-30</b>
<ul>
<li>
  I've added areas under each test so that I can more easily display
  some of the alternate submissions I've received.
</ul>

<b>2001-01-30</b>
<ul>
<li>
  I've started re-organizing the <a href="bench/strcat/">String
  Concatenation</a> test.  Now languages can offer 2 solutions for
  this test.  See that test page for details.
<li>
  Released version 0.1.10.
</ul>
  

<b>2001-01-27</b>
<ul>
<li>
  The Shootout has a new server!  www.bagley.org has moved to
  minami.bagley.org as a CNAME.  minami is a dual 450Mhz Pentium-II
  CPU server with 1GB of RAM and 4x9GB SCSI drives.  A complete
  rebuild of all benchmark results takes just about 6 hours on minami.
  The rebuild on minami has shown that a few languages have switched
  positions on individual tests, but the overall <a
  href="craps.php">CRAPS ratings</a> stayed the same.
</ul>

<b>2001-01-16</b>
<ul>
<li>Added the <a href="bench/ary2/">Array Access II</a> test.
</ul>

<b>2001-01-15</b>
<ul>
<li>
  Even more CRAPS.  Now the <a href="craps.php">Scorecard</a> can
  include Memory in the Score.
<li>
  I've added in all the missing C++ programs (by copying the C
  programs for now, yes, I'm lazy).  I just wanted to see how C++
  would score if all programs were finished.
</ul>

<b>2001-01-09</b>
<ul>
<li>
  The <a href="craps.php">Scorecard</a> page is now CGI, and you can
  adjust the test weights to your preference.
</ul>

<b>2001-01-03</b>
<ul>
<li>
  I've increased the run-times of most of the tests.  This should help
  minimize startup costs.
</ul>

<b>2001-01-01</b>
<ul>
<li>
  Per Hedbor pointed out I had a bad bug in some of my <a
  href="bench/echo/">echo client/server</a> programs (a missing
  wait()).  Now the timings should be much more accurate.
<li>Added a <a href="craps.php">scorecard</a>! Now see which
language is best!  Proven empirically!  Forever and all time! ;-)
<li>Added CMU Common Lisp.
<li>
  Now the table on each test page includes a link to a log of how each
  program is built/run.
</ul>

<b>2001-01-01</b>
<ul>
<li>Released version 0.1.9.
</ul>

<b>2000-12-30</b>
<ul>
<li>Added a <a href="bench/nestedloop/">nested loop</a> test. 
<li>Upgraded Tcl to version 8.3.2.
<li>Added <a href="bench/hash2/">another hash</a> test. 
</ul>

<b>2000-12-29</b>
<ul>
<li>Added a <a href="bench/matrix/">matrix multiplication</a> test. 
</ul>

<b>2000-12-24</b>
<ul>
<li>Added a <a href="bench/fibo/">Fibonacci numbers</a> test. 
</ul>

<b>2000-12-19</b>
<ul>
<li>Added a threaded <a href="bench/prodcons/">producer/consumer</a> test. 
</ul>


<b>2000-12-17</b>
<ul>
<li>Released version 0.1.8.
<li>
  I should note that a number of my sub-optimal Python solutions have
  been sped up with help from Hans Nowak and Joel Rosdahl.
</ul>

<b>2000-12-16</b>
<ul>
<li>
  Upgraded Pike from 7.0 to 7.1 (which is still in development).
</ul>

<b>2000-12-12</b>
<ul>
<li>
  Added <a href="bench/methcall/">method calls</a> and <a
  href="bench/objinst/">object instantiation</a> tests.
<li>
  Regenerated results for Lua programs, because some were incorrect
  due to bug in my head.
</ul>

<b>2000-12-10</b>
<ul>
<li>
  Added <a href="bench/strcat/">string concatenation</a> test.
<li>
  Added a page about <a href="method.php">methodology</a>.
</ul>

<b>2000-12-09</b>
<ul>
<li>
  Added <a href="bench/ary/">array access</a> and <a
  href="bench/hash/">hash access</a> tests. 
</ul>

<b>2000-12-06</b>
<ul>
<li>
  Just for fun, I've added XEmacs versions of <a
  href="bench/ackermann/ackermann.xemacs">ackermann</a> and <a
  href="bench/sieve/sieve.xemacs">sieve</a> tests :-)
</ul>

<b>2000-12-05</b>
<ul>
<li>
  Added a new test: an <a href="bench/echo/">Echo Client/Server</a>.
</ul>

<b>2000-12-03</b>
<ul>
<li>Replaced <a href="ChangeLog">ChangeLog</a> with automated <a
href="recent.php">Activity Log</a>.
<li>Fredrik Noring and various others from Roxen contributed a bunch
of Pike test programs.
</ul>

<b>2000-11-27</b>
<ul>
<li>Released version 0.1.7.
</ul>

<b>2000-11-26</b>
<ul>
<li>Replaced <i>benchtest</i> tool with <i>minibench</i> ... which has
lots more options.
</ul>

<b>2000-11-23</b>
<ul>
<li>Released version 0.1.6 with latest fixes.
<li>Dave Thomas offered some tips to speed up some of the Ruby programs.
</ul>

<b>2000-11-20</b>
<ul>
<li>Started new tests: lists, random number generator, heapsort
</ul>

<b>2000-11-19</b>
<ul>
<li>Released version 0.1.5.
<li>Fixed bug in benchtest causing incorrect accumulation of CPU time.
<li>Roberto Ierusalimschy has kindly provided a number of the Lua test
programs. 
</ul>

<b>2000-11-06</b>
<ul>
<li>Modified benchtest to use the GTop perl module.  Hopefully this
will be good for portability (at least to other Unices). 
</ul>

<b>2000-10-08</b>
<ul>
<li>Started <a href="bench/moments/">Statistical Moments</a> test.
<li>Released version 0.1.3.
</ul>

<b>2000-10-03</b>
<ul>
<li>Released version 0.1.2.
</ul>

<b>2000-10-02</b>
<ul>
<li>Created a distribution tarball.
</ul>

<b>2000-09-30</b>
<ul>
<li>Updated most languages to the very latest versions.
</ul>

<b>2000-09-25</b><ul>
<li>
  Now tests can define a range over which measurements are taken.  The
  range can be number of iterations, size of input datasets or a
  parameter passed to the test so it can use it as an input parameter.
<p>
  The first test in the range can be designated as the one used for
  correctness testing (comparing with expected output).  It can also
  serve to make sure input data is cached.
</ul>

<?php require("html/footer.php"); ?>
