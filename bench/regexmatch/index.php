<!--#set var="TITLE" value="Regular Expression Matching" -->
<!--#set var="KEYWORDS" value="performance, benchmark, regular,
expression, expressions, matching, c, perl, python, computer,
language, compare, cpu, memory, recursion" -->

<?php require("../../html/testtop.php");
      testtop("Regular Expression Matching"); ?>

<h4>About this test</h4>
<p><b>Please Note:</b> this test is due for an overhaul, because of the
  variety of solutions for this test that aren't really using regular
  expressions.  I'll probably split this into 2 tests, one that does
  some kind of parsing/pattern matching, and another that calls for
  NFA regular expressions with capture buffers.</p>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>.</p>
<p>The purpose of this test is to extract strings that look like
  phone numbers from a file and print them in a standard format.  For
  the sake of this test, we aren't interested in I/O performance, so we
  read the file into an array before starting, then extract the phone
  numbers from the array N times, and on the last iteration, we print
  the extracted numbers in the standard format.  See the <a href=
  "detail.php">detail page</a> for different values of N.</p>
<p>Each program can assume that no line will exceed 128 characters
  (including newline).</p>
<p><a href="/bench/regexmatch/Input">Input</a> file.
  <a href="/bench/regexmatch/Output">Output</a> file.</p>
<p>The telephone number pattern we are trying to match can be described
  this way:
  <ul>
    <li>there may be zero or one telephone numbers per line of input.</li>
    <li>a telephone number may start at the beginning of the line or be
    preceeded by a non-digit, (which may be preceeded by anything).</li>
    <li>it begins with a 3-digit <i>area code</i> that looks like this
    (DDD) or DDD (where D is [0-9]).</li>
    <li>the <i>area code</i> is followed by one space,</li>
    <li>which is followed by the 3 digits of the <i>exchange</i>: DDD</li>
    <li>the <i>exchange</i> is followed by a space or hyphen [ -]</li>
    <li>which is followed by the last 4 digits: DDDD</li>
    <li>which can be followed by end of line or a non-digit (which may be
    followed by anything).</li>
  </ul>
</p>

<p>For the C program I wasn't going to implement my own regular
  expressions from scratch, I use the <a href=
  "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre"> Perl
  Compatible Regular Expressions</a> (PCRE) library.</p>
<p>The C++ program uses Bill Lear's <a href=
  "http://sourceforge.net/projects/regx/">PCRE library for C++</a>.</p>
<p>Markus Mottl helped me use his <a href="http://pcre-ocaml.sourceforge.net/">
  PCRE library for Ocaml</a>.</p>
<p>The Java program uses a 3rd party, mostly-Perl5-compatible regexp
  library, called ORO.  Apparently this package, once available from
  oroinc.com (defunct), is now maintained by the <a href=
  "http://jakarta.apache.org/oro/">Apache Jakarta project</a>.</p>
<p>Bigloo's regular <a href="regexmatch.bigloo">grammar facility</a> is
  very powerful.  I wish all languages offered this feature.  I think it
  shows that while it's nice to be able to do complex pattern matching,
  it is really more important how easily you can do something with the
  matched data.</p>
<p>I have been a little sloppy in this test specification, and some
  languages don't implement the same exact pattern matching.  I'll try
  to fix this soon by adding more test strings to the input to take
  care of some of the sloppy cases.</p>

<h4>Observations</h4>
<p>Erlang's regular expression support is minimal, it doesn't support
  captures (backreferences), and strings are represented as linked
  lists, so it doesn't do very well on this test.</p>

</td></tr>
</table>

<?php require("../../html/footer.php"); ?>
