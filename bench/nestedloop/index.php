<!--#set var="TITLE" value="Nested Loops" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
nested loops" --> 

<?php require("../../html/testtop.php"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.
<p>
  This is just a simple test to try to measure loop overhead for a
  loop that does something a number of times.

<h4>Observations</h4>
<p>
  The following programs exceed the time limit (300 CPU seconds) and
  are disqualified: 
  <a href="nestedloop.bash">bash</a>.

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<li>
  Miguel Sofer contributed another <a href="alt/nestedloop.tcl2.tcl">Tcl
  program</a>, which reads nicely, but is fractionally slower than the
  current Tcl contestant.
<li>
  In Ocaml, it can be faster to write your loops using <a
  href="nestedloop.ocaml">recursion</a>.  A slightly slower version
  that uses Ocaml's imperative loop control is shown <a
  href="alt/nestedloop.ocaml2.ocaml">here</a>.
</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
