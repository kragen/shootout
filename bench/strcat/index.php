<!--#set var="TITLE" value="String Concatenation" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory, string concatenation" --> 

<?php require("../../html/testtop.php");
      testtop("String Concatenation"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>, according to
  the following specification.</p>

<p>
<table border="0" bgcolor="#c0e0e0" align="center" width="50%">
<tr><th align="center">pseudocode for strcat test</th></tr>
<tr><td><pre><br>
 s is initialized to the null string
 repeat N times:
   append "hello\n" to s
 count the number of individual characters in s
 print the count
</pre></td></tr><tr><td>
<li>
 There should be N distinct string append statements done in a loop.
<li>
 After each append the resultant string should be 6 characters longer
 (the length of "hello\n").
<li>
 <b>s</b> should be a string, string buffer, or character array.  The
 program should not construct a list of strings and join it.
</td></tr></table></p>

<p>This test should probably be called the <i>string append</i> test
  because many of the solutions append a suffix onto an existing
  <i>string</i> data structure.  Languages with immutable strings
  will have to construct a new string out of 2 previous strings,
  which will be much slower.</p>
<p>This is an extremely simple test that measures speed of a language's
  string append (or concatenation) operator (or most similar feature)
  in a loop.  An implementation that does its own memory management
  should not pre-allocate the entire buffer necessary to hold the
  resultant string, but should grow the string buffer as necessary.
  For example, the <a href="strcat.gcc">C program</a> doubles the size
  of the string buffer whenever it is necessary to add more data than
  will fit into the buffer.  Any strategy that allocates more than
  this at one time is too much of a cheat.</p>
<p>Due to the number of alternative ways of <i>concatenating a string</i>
  in various languages, each language is allowed 2 entries.  At least
  one entry should use the closest thing to a <i>native string</i> and
  its <i>concatenation operator</i>.  A second entry may use a more
  efficient way of implementing concatenation (e.g. append), but it
  should still do the operation N times in a loop as shown in the
  pseudocode above.</p>

<h4>Observations</h4>
<p>The following programs exceed the time limit (300 CPU seconds) and
  are disqualified:
  <a href="strcat.bash">Bash</a>, 
  <a href="strcat.guile2.guile">Guile (2)</a>, 
  <a href="strcat.ghc2.ghc">Glasgow Haskell Compiler (2)</a>, 
  <a href="strcat.java2.java">Java (2)</a>, 
  <a href="strcat.se">SmallEiffel</a>,
  <a href="strcat.smlnj2.smlnj">SML/NJ (2)</a>,
  <a href="strcat.xemacs2.xemacs">XEmacs (2)</a>.</p>
<p>This test shows how well a language handles string allocation with
  respect to string concatenation.  For instance, Perl is highly
  optimized for this operation, and <a
  href="strcat.java2.java">Java's</a> native string concatentation
  operator is so bad it exceeds the time limit for this test.  (We can
  use Java's <a href="strcat.java">StringBuffer</a> to do an
  analogous string append, which is much faster).</p>
<p>Josef Svenningsson observes that when using the <a
  href="strcat.ghc2.ghc">++ operator</a> in Haskell it is much faster
  to prepend the string rather than to append it (making the
  complexity linear instead of quadratic), with performance comparable
  to the Tcl solution above.  Josef also contributed the fast (and
  more Haskell idiomatic) <a href="strcat.ghc">version of this
  test</a>.</p>

<h4>Acknowledgements</h4>
<p>This test was suggested by Ben Tilly.</p>
<p>Friedrich Dominicus who supplied the SmallEiffel solution, also
  supplied a patch to std_lib/string.e to fix a bug in the string
  append function in SmallEiffel version 0.77.  (This is no longer
  needed with the newer version of SmallEiffel 0.76.  Yes, SmallEiffel
  version numbers count down!)</p>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>You can produce repeated strings in Perl via the <b>x</b> operator,
  but this <a href="alt/strcat.perl2.perl">program</a> does not really
  follow the test guideline that the program should to N individual
  string concatenations in a loop.  Here's a similar program in <a
  href="alt/strcat.python2.python">Python</a> from Hans Nowak.  And
  one in <a href="alt/strcat.pike3.pike">Pike</a> from Per Hedbor.</li>
  <li>Here are some programs that join a list of strings:
    <a href="alt/strcat.erlang3.erlang">Erlang</a>, 
    <a href="alt/strcat.ghc3.ghc">Haskell</a>, 
    <a href="alt/strcat.guile3.guile">Guile</a>, 
    <a href="alt/strcat.mercury3.mercury">Mercury</a>.
  </li>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>

