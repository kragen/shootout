<!--#set var="TITLE" value="Fibonacci Numbers" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
fibonacci numbers" --> 

<?php require("../../html/testtop.php");
      testtop("Fibonacci Numbers"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>. (For this
  test, all solutions must use recursion as specified below. For a
  number of languages other (iterative) techniques may be much faster,
  but that would make it a different test.)</p>
<p>Each program recursively computes Fibonacci numbers using this
  algorithm:</p>

<p>
<table cellpadding="8" align="center" bgcolor="#c0e0e0">
<tr><td>
 <pre><br>
 Fib(0) -> 1
 Fib(1) -> 1
 Fib(N) -> Fib(N-2) + Fib(N-1)</pre>
</td></tr>
</table></p>

<p>Please note that this definition specifies that fib(0) = 1.  It may
 be more correct to define fib(0) = 0, although I've seen plenty of
 references that define it either way.</p>

<p>What do rabbits, spiral patterns found in plants, the shell of the
  nautilus, Greek architecture, and the golden ratio have in common?
  The Fibonacci sequence.  There are many many web pages and books
  about the Fibonacci sequence and how it relates to many topics
  natural and mathematical.</p>

<h4>Observations</h4>
<p>The following programs exceed the time limit (300 CPU seconds) and
  are disqualified: 
  <a href="fibo.bash">bash</a>.
</p>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>Kristoffer Lawson provided an <a href="alt/fibo.tcl2.tcl">alternate
  Tcl</a> program that illustrates that you can also return values from
  the last evaluated expression, and that in some cases this may be faster
  than to use <b>return</b>.  In this case, it is fractionally faster, but
  the change doesn't really come close to the next competitor (Ruby).  I
  felt the version using <b>return</b> was probably more realistic Tcl
  coding style.</li>
<li>Benedikt Rosenau contributed an interesting variation for the <a
  href="alt/fibo.ocaml2.ocaml">Ocaml program</a>, and Tom Burt
  submitted a very fast <a href="alt/fibo.ocaml3.ocaml">Ocaml
  program</a> that is fully tail recursive.</li>
<li>Chris Stith contributed an iterative solution in <a
  href="alt/fibo.perl2.perl">Perl</a>.  For other than small values of
  N, this solution runs faster than any of the recursive solutions.</li>
<li>Here's an iterative version in <a
  href="alt/fibo.python2.python">Python</a> from Paul Winkler, and
  another <a href="alt/fibo.python3.python">Python</a> program from
  Fredrik Lundh.</li>
<li>Paul Foley contributed a few <a href="alt/fibo.foley.cmucl">alternates
  for CMUCL</a> that use iteration and the external <a href=
  "http://www.math.uio.no/cltl/clm/node347.html">SERIES</a> package.</li>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
