<!--#set var="TITLE" value="Count Lines/Words/Chars" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" --> 

<?php require("../../html/testtop.php");
      testtop("Count Lines/Words/Chars"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented to do the <a
  href="../../method.php#samething"><i>same thing</i></a>, following
  the guidelines below:</p>
<p>Each program reads the input from standard input, and counts the
  lines, words (whitespace delimited tokens), and characters, and
  outputs each count.  The programs should not read the input by more
  than 4K at a time.  To give a baseline of expected performance I
  allow <a href="wc.bash">bash</a> to use an external process (wc).
  All other solutions should be implemented natively.</p>
<p>This test is essentially the same as the wordcount test from <a
  href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html">
  Timing Trials, or, the Trials of Timing: Experiments with Scripting
  and User-Interface Languages</a> by Brian W. Kernighan and
  Christopher J. Van Wyk.</p>
<p>Note that as in the original version of this test, whitespace is
  defined as space, newline and tab characters.  This is a little
  different from the Unix <b>wc</b> command, which defines a few more
  characters to be whitespace.</p>
<p>The programs can assume that the file ends in a newline, and they
  should be able to handle arbitrarily long lines.</p>

<p><a href="/data/shootout/wc/Input">Input</a> file (it
  is repeated N times).<br></p>
<p>The correct output (for N = 500, i.e. a 500 copies of the input)
  looks like this:
<pre>
  12500 68500 3048000
</pre></p>

<h4>Observations</h4>
<p>The original <a href="alt/wc.gcc2.gcc">C program</a> is significantly
  slower than the version <a href="wc.gcc">here</a> which bypasses
  stdio.</p>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
