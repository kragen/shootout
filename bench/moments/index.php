<!--#set var="TITLE" value="Statistical Moments" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
statistical moments" --> 

<?php require("../../html/testtop.php");
      testtop("Statistical Moments"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented to do the <a
  href="../../method.php#sameway"><i>same thing</i></a>, following
  the guidelines below:</p>
<p>This test reads a list of (double precision floating point)
  numbers from standard input, and calculates the statistics using
  double floating point: median, mean, average deviation, standard
  deviation, variance, skew, kurtosis.  For this test, it's okay
  to avoid line-oriented I/O and read the entire contents of the
  input file all at once (since all the numbers need to be in
  memory together in order to do the calculations).</p>
<p>
  <a href="/data/shootout/moments/Input">Input</a> file.
  <a href="/data/shootout/moments/Output">Output</a> file.
</p>

<!--
<h4>Observations</h4>
<p>
 -->

<h4>Acknowledgements</h4>
<p>This test was proposed by Bill Lear who provided the C++ solution.</p>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
