<!--#set var="TITLE" value="Reverse a File" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
reverse a file" --> 

<?php require("../../html/testtop.php");
      testtop("Reverse A File"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented to do the <a
  href="../../method.php#samething"><i>same thing</i></a>, following
  the guidelines below:</p>
<p>This test reverses the input file from stdin, line by line.  This is
  like the <i>tail</i> test in <a href=
  "http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html">
  Timing Trials, or, the Trials of Timing: Experiments with Scripting
  and User-Interface Languages</a> by Brian W. Kernighan and
  Christopher J. Van Wyk.</p>
<p>In this test, it's okay to use input methods other than line-oriented
  I/O, such as reading the entire input from stdin, as long as each
  read is no more than 4096 bytes at a time.</p>
<p><a href="/data/shootout/reversefile/Input">Input</a> file (100K, it
  is repeated N times).  <a href="/data/shootout/reversefile/Output">Output
  </a> file (500K, for N=5).</p>
<p>For this test, solutions can assume that the file ends with a
  trailing newline.</p>

<h4>Observations</h4>
<p>Perl and Ruby are ideally suited for this little test, and they both
  implement a one-line solution.</p>
<p>The original <a href="alt/reversefile.perl3.perl">Perl</a> program
  from the Kernighan and Wyk study is sub-optimal.  Ben Tilly suggested
  a <a href="alt/reversefile.perl2.perl">one-liner</a> that is very
  concise and noticeably faster.</p>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>If we were reading from a file instead of standard input, we could
  use mmap, as shown in <a href="alt/reversefile.g++2.g++">this C++
  example</a>, which uses Bill Lear's mmap class.</li>
  <li>Here are some alternate solutions in OCaml:
  <a href="alt/reversefile.ocaml3.ocaml">pattern matching</a>
  <a href="alt/reversefile.ocaml5.ocaml">array</a> (faster still).</li>
  <li>It was significantly slower to iterate over the list of lines in <a
  href="alt/reversefile.python2.python">Python</a>, than it was to use
  the map() function (<a href="alt/reversefile.python3.python">here</a>),
  or the current Python submission, which is faster still.</li>
  <li>Here's another version using (<a href="alt/reversefile.se2.se">
  SmallEiffel</a>), which uses an array of strings rather than the current
  linked list, and is noticeably slower.</li>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
