<!--#set var="TITLE" value="Matrix Multiplication" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
matrix multiplication" --> 

<?php require("../../html/testtop.php");
      testtop("Matrix Multiplication"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented to do the <a
  href="../../method.shtml#sameway"><i>same thing</i></a>, multiply 2
  matrices.  For this test, I would like to see solutions that do not
  manually unroll the loops.
<p>
 This test is inspired by another small language comparison: <a
 href="http://www.networkcomputing.com/unixworld/tutorial/005/005.html">
 <i>The What, Why, Who, and Where of Python</i></a> By Aaron
 R. Watters.  I based the Perl, Python, and Tcl programs on the
 programs from that article.  You might note that I have sped some of
 them up a bit by removing some loop invariants (esp. subscript
 references).
<p>
 The correct output from each test program should look like this:
<pre>
<!--#include virtual="Output" -->
</pre>

<h4>Observations</h4>
<p>
 The following programs exceed the time limit (300 CPU seconds) and
 are disqualified:
 <a href="matrix.gawk">Gawk</a>, 
 <a href="matrix.mawk">Mawk</a>
<p>
 The OCaml solution is just as fast as the C/C++ solutions, until we
 add the <i>-funroll-loops</i> optimization option to our gcc/g++
 programs, which naturally gives them a small advantage.

<p>
 Per Hedbor contributed a <a href="matrix.pike">Pike</a> program that
 uses Pike's builtin class to do Matrix Math.  This gives Pike a large
 advantage in this test.  I think it is okay for Pike to use this
 module in this test because it is distributed with the core Pike
 distribution.  It is also very illustrative of how binary extension
 modules can give interpreted languages all the speed you need.

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<li>
  Here's my original <a href="alt/matrix.pike2.pike">Pike program</a>,
  that does not use Pike's Matrix Math class.
<li>
  Brian Gregor contributed the original <a
  href="alt/matrix.ghc2.ghc">Haskell program</a>.
<li>
  Paul Foley submitted a <a href="alt/matrix.cmucl2.cmucl">CMUCL
  program</a> that uses ROW-MAJOR-AREF instead of one-dimensional
  arrays.
<li>
  Anton Ertl submitted an alternative for <a
  href="alt/matrix.gforth2.gforth">GForth</a> that uses integers.
<li>
  Jorge Acereda Maciá submitted an interesting alternative for <a
  href="alt/matrix.gforth3.gforth">GForth</a> that generates inlined
  code at compile time.
</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
