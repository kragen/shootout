<!--#set var="TITLE" value="Sum a Column of Integers" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
sum a column" --> 

<?php require("../../html/testtop.php");
      testtop("Sum a Column of Integers"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>.</p>
<p>This test sums a column of integers from an input file.  It mostly
  measures speed of line-oriented I/O and conversion of string to
  integer.  Each test should read integers line by line from stdin,
  one integer per line, sum the integers and print the sum.  For
  this test, I would like to see programs use a language's built-in
  line-oriented I/O functions used, as opposed to rolling your own.
  As each line should be read one at a time, the programs should run
  in constant space.</p>
<p>For this test, each program can assume that no line will exceed 128
  characters (including newline).</p>
<p><a href="/bench/sumcol/Input">Input</a> file (it
  is repeated N times).</p>
<div class="donemessage">
  <p>The correct output (for N = 100, i.e. 100 copies of the input)
  looks like this:
  <pre>
    <?php require("Output"); ?>
  </pre></p>
</div>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>Quentin Crain submitted a nice short <a href="alt/sumcol.python2.python">
  Python</a> solution using map/reduce, however this solution reads all
  input at once, instead of line by line.</li>
  <li>Paul Foley contributed a couple alternates for CMUCL <a
  href="alt/sumcol.cmucl3.cmucl">[1]</a>, <a href="alt/sumcol.cmucl4.cmucl">
  [2]</a>.</li>
  <li>John Goerzen contributed a very concise <a href="alt/sumcol.ghc2.ghc">
  Haskell</a> implementation.  It's not as fast as the current version.</li>
</ul>

<h4>Acknowledgements</h4>
<p>Henrik Grubbström contributed a <a href="sumcol.pike2.pike">Pike</a>
  program that avoids the overhead of line-oriented I/O, and is almost
  10 times faster than the <a href="sumcol.pike">original</a> that
  reads input line by line.</p>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
