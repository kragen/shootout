<!--#set var="TITLE" value="Spell Checker" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
spell checker" --> 

<?php require("../../html/testtop.php");
      testtop("Spell Checker"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>.</p>
<p>This is a simple spell checker performance test.  The goal is to
  test line oriented I/O and hashes (associative arrays).</p>
<p>Each test should read in a dictionary (just a list of words, about
  350KB).  Then it should read words from standard input and print
  those words which do not appear in the dictionary.  To simplify
  things a little, we assume that for both the dictionary and standard
  input there is only one word per line.  The dictionary is based on
  /usr/dict/words, but we only use words that consist entirely of
  lowercase letters.</p>
<p>For this test, each program can assume that no line will exceed 128
  characters (including newline).</p>
<p><a href="/bench/spellcheck/Usr.Dict.Words">Dictionary</a>.<br>
  <a href="/bench/spellcheck/Input">Input</a> file (it is 
  repeated N times).<br>
  <a href="/bench/spellcheck/Output">Output</a> file (for
  N=1).<br></p>

<!--
<h4>Observations</h4>
<p>
 -->

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>While all the tests currently read the input data a line at a time
  from standard input, Bill Lear submitted a <a href=
  "alt/spellcheck.g++_mmap.g++">version of the C++ program that uses
  mmap</a> to avoid the I/O overhead.  This version is noticeably
  faster than the original.</li>
  <li>Roberto Ierusalimschy contributed a couple of Lua solutions, this
  version of the <a href="alt/spellcheck.lua2.lua">Lua program</a> reads the
  file all at once, versus line by line and is faster.  Of course, it
  uses memory in proportion to the size of the input.</li>
  <li>Dave Thomas gave me some tips on speeding up Ruby programs, and
  contributed the <a href="alt/spellcheck.ruby2.ruby">ruby2</a> program
  that gains a speed boost by turning off the garbage collector.</li>
  <li>Fredrik Noring contributed another version of the Pike program <a
  href="alt/spellcheck.pike2.pike">pike2</a>, which avoids the cost of
  line-oriented I/O.  This extra version is only included here to
  illustrate the speedup of switching from line-oriented I/O to
  block-oriented I/O.  Any language should be able to use a similar
  technique to achieve a similar speedup.</li>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
