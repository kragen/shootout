<!--#set var="TITLE" value="Hash (Associative Array) Access" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory, hash access, associative
array access" --> 

<?php require("../../html/testtop.php");
      testtop("Hash (Associative Array) Access"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.
<p>
  This test is basically the same as the associative array test from <a
  href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html"> Timing
  Trials, or, the Trials of Timing: Experiments with Scripting and
  User-Interface Languages</a> by Brian W. Kernighan and Christopher
  J. Van Wyk.  This test makes use of sprintf(), which is very
  expensive and pretty much swamps the hash table processing.  So I
  find this test pretty meaningless.
<p>
  To make the point about sprintf(), I rewrote the Ocaml program so
  that it constructs its hash keys as efficiently as it can ... and 
  it's speed improved noticeably.
<p>
  Please refer to my second <a href="../hash2/">hash test</a> which
  tries to avoid the cost of hash key string generation.
<p>
  The correct output (for N = 20000) looks like this:
<pre>
  <!--#include virtual="Output" -->
</pre>
<p>

<h4>Observations</h4>
<p>
  The <a href="hash.gcc">C program</a> uses a simple Hash Table
  implemented in this header file: <a
  href="../Include/simple_hash.h">simple_hash.h</a>.
<p>
  Jochen Schmidt contributed a <a href="hash.cmucl">Common Lisp
  program</a> that uses a custom formatting function instead of
  <i>princ-to-string</i>, for a five-fold overall speedup.

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<!-- link died
<li>
  Based on previous work by Jacques Bouchard we can vastly improve the
  SmallEiffel performance with a custom Hash Map class to replace
  SmallEiffel's DICTIONARY class.  (See his web page: <a
  href="http://mageos.ifrance.com/bouchard/">
  http://mageos.ifrance.com/bouchard/</a>.  Here's an example
  alternative <a href="alt/hash.se2.se">SmallEiffel program</a> using
  the custom hash_map which is implemented in these files: <a
  href="../Include/hash_item.e">hash_item.e</a> and <a
  href="../Include/hash_map.e">hash_map.e</a>.  I have slightly
  modified this code so that the hash_code method for a string is now
  a utility function, and so that a find() method on a non-existant
  key does not fail.
 -->
<li>
  Mark Baker contributed another <a
  href="alt/hash.python2.python">Python</a> program that map, filter,
  and len to improve performance.  This solution is faster, but not
  enough to improve Python's rank.  It also uses a little more memory,
  but it's nice and short and a good example of using these higher
  order functions.  Since it doesn't really implement the same
  operations as the other programs (same way), I've put it in the
  alternates section for now.

</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
