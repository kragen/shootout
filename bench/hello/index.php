<!--#set var="TITLE" value="Hello World" -->
<!--#set var="KEYWORDS" value="performance, benchmark,
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.  Each program
  just prints out &quot;hello world&quot; and exits.
<p>
  The correct output (for N = 1) looks like this:
<pre>
  <!--#include virtual="Output" -->
</pre>
<p>
  The purpose of this test is to try to show relative startup costs of
  the different languages.  In order to measure startup costs, this
  test is run differently than the others, each test program is run N
  times in a loop by a shell script wrapper.
<p>
  I use the results of this test to calculate CPU times on other tests
  without startup time.  To do this I take the CPU time result of this
  test for each language, divide by the number N, and subtract from the
  CPU score on the other test pages.  You can view those new scores by
  clicking on the link labelled: <i>[cpu minus startup time]</i> on the
  other test pages.  (It doesn't make much sense to click on that link on
  this page, but I haven't gotten around to specializing the construction
  of the table on this page :-).

<h4>Observations</h4>
<p>
  A number of the programs run so quickly so that memory can't be
  measured by my memory sampling method.  For this test, you should
  really ignore the memory results.

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
