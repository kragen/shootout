<!--#set var="TITLE" value="Hashes, Part II" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
nested loops" --> 

<?php require("../../html/testtop.php"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.
<p>
  In this test, we create 10000 hash entries, then add them into a new
  hash N times.  
<p>
  This is an attempt to improve on the original <a href="../hash/">hash
  test</a>.  In this test, we try to avoid the cost of creating the
  hash key strings by creating a limited set of keys (10000), with
  (hopefully) less expensive means than sprintf() which the original
  test used.  In this test the hash keys are created by turning an
  integer into a string.  The reason this method of hash key creation
  is chosen is to keep the CPU used in hash key creation to a minimum.
  Some hash table implementations may be penalized somewhat by having
  to deal with many similar keys.  (But a good one won't :-)
<p>
  The correct output (for N = 10) looks like this:
<pre>
  <!--#include virtual="Output" -->
</pre>
<p>

<h4>Observations</h4>
<p>
  The following programs exceed the time limit (300 CPU seconds) and
  are disqualified:
  <a href="hash2.bash">bash</a>.
<p>
  SmallEiffel version 0.77 was able to complete this test in about
  7CPU seconds.  The new version (0.76, they count backwards?!) dumps
  core.
<p>
  The <a href="hash2.gcc">C program</a> uses a simple Hash Table
  implemented in this header file: <a
  href="../Include/simple_hash.h">simple_hash.h</a>.

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<li>
  Miguel Sofer submitted a somewhat faster version of the <a
  href="alt/hash2.tcl2.tcl">Tcl program</a> that avoids having to
  check if the new hash key exists in the second loop.  However, all
  the other programs do handle the situation where the new hash key
  may or may not exist already, so I've put this solution in the
  alternates section.
</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
