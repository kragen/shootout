<!--#set var="TITLE" value="Computer Language Shootout Acknowledgements" -->
<!--#set var="KEYWORDS" value="performance, benchmark, computer,
algorithms, languages, compare, cpu, memory" --> 
<?php require("html/header.php");
      require("html/toptabs.php");
      require("html/testnav.php");
     
      $current = "index.php";
      toptabs($current); ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
<?php benchlist(".");
      nav_list_end(); ?>
  <td>
    <div id="bodycol">
      <div id="apphead"><h2>Acknowledgements</h2></div>
      <div class="app">
<p>I've received help and inspiration from various sources, friends and
  friendly net-folks, and I'll try to mention them all here.</p>
<p>At early stages of this project I came across two web pages that had
  a lot of interesting stuff on benchmarking.  I've used ideas on
  methodology, benchmarks, and target languages from both of these
  prior works, which are both useful for review in their own right
  (but are a little dated at this point, IMHO).</p>
<ul>
  <li><a href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html">
  Timing Trials, or, the Trials of Timing: Experiments with Scripting
  and User-Interface Languages</a> by Brian W. Kernighan and Christopher
  J. Van Wyk.  This is an interesting study to read, but it does have
  some flaws (as I'm sure mine does, or any benchmark for that
  matter).  For instance, it uses Ackermann's function as a measure
  of function call efficiency, which I feel is inappropriate.  It's
  probably better to test function call efficiency in an iterative
  style, rather than a recursive style, because those languages that
  implement tail-call elimination (like functional languages), will
  perform vastly better due to that optimization.</li>
  <li><a href="http://www.lib.uchicago.edu/keith/crisis/"> My Programming
  Language Crisis</a> by Keith Waclena.  Keith wrote a great <a
  href="http://www.lib.uchicago.edu/keith/crisis/disclaimer.html">disclaimer</a>,
  which I think pretty much applies almost word for word for this
  project :-) Keith also came up with a very interesting method for
  quantifying some more qualitative aspects of different computer
  languages.  Unfortunately, it's a little incomplete, and definately
  out of date now, but he raises lots of good points.</li>
</ul>

<p>Here's a list of participants who have helped me to implement better
  tests.  Please also check the comments of the test programs where I
  try to give accurate attribution if I did not write the test myself.
  Needless to say, if you find any mistakes you can attribute them
  solely to me!</p>
<ul>
  <li>I'd like to thank my friend, Bill Lear, for most of the programs
  written in <a href="lang/g++">C++/STL</a>.</li>
  <li>My friend, Phil Chu, helped with the Java Word Frequency test and
  has been helpful in discussion of the benchmark framework.</li>
  <li>Another friend from work, Kerry Clendinning, wrote a very clever
  first version of the C Word Frequency test, which inspired me to
  write a not-so-clever, but slightly faster version.</li>
  <li>Maurice Castro, who I encountered on the erlang-questions mailing list,
  kindly helped out with a few of the <a href="lang/erlang/">Erlang</a>
  tests, including the Erlang word frequency program.  He has a book on
  Erlang: Erlang in Real Time (ISBN: 0864447434).</li>
  <li>Roberto Ierusalimschy, one of Lua's creators, was kind enough to
  contribute many of the <a href="lang/lua/">Lua</a> programs.</li>
  <li>Dave Thomas gave me some tips to speed up some of my <a
  href="lang/ruby/">Ruby</a> programs.  Dave has a new book on Ruby:
  <a
  href="http://www1.fatbrain.com/asp/bookinfo/bookinfo.asp?theisbn=0201710897">
  Programming Ruby: A Pragmatic Programmers Guide</a>.  Check it out.</li>
  <li>Fredrik Noring from <a href="http://www.roxen.com">Roxen</a> along
  with some of his friends and colleagues (Per Hedbor, Marcus
  Comstedt, Henrik Grubbström and Martin Nilsson) contributed a number
  of the <a href="lang/pike/">Pike</a> programs.  The <a
  href="http://www.roxen.com/products/webserver/">Roxen WebServer</a>
  and Roxen Platform are written in Pike.</li>
  <li>Hans Nowak has made some suggestions for improving the speed of some
  of my <a href="lang/python/">Python</a> programs.</li>
  <li>Friedrich Dominicus sent me some suggestions for speeding up a few
  programs.  He has now sent a few <a
  href="lang/se/">Eiffel</a> programs, and has contributed a number of
  examples in <a href="lang/cmucl/">Common Lisp</a>.</li>
  <li>Tony Bowden helped me improve the speed of a couple <a
  href="lang/perl/">Perl</a> programs.</li>
  <li>Benedikt Rosenau has contributed a number of new <a
  href="lang/ocaml/">Ocaml</a>, <a href="lang/guile/">Guile/Goops</a>,
  and <a href="lang/ghc/">Haskell</a> programs and has also suggested
  improvements to some of my previous test programs.</li>
  <li>Kristoffer Lawson contributed a few <a href="lang/tcl/">Tcl</a>
  programs, and gave me some hints to speed up some of my old ones.</li>
  <li>Miguel Sofer has also kindly offered a few faster <a
  href="lang/tcl/">Tcl</a> programs.</li>
  <li>Markus Mottl has contributed new version of a number of <a
  href="lang/ocaml/">Ocaml</a> programs, both speeding some up,
  and making the code more beautiful and idiomatic.</li>
  <li>Steve Fink has contributed a couple of <a href="lang/bash/">bash</a>
  program solutions, and has provided some speedups for a few <a
  href="lang/perl/">Perl</a> programs.</li>
  <li>Brad Knotwell has contributed to some of the <a
  href="lang/python/">Python</a> and <a href="lang/guile/">Guile</a>
  programs.</li>
  <li>Sven Hartrumpf has offered some suggestion to improve timings of
  <a href="lang/bigloo/">Bigloo</a> programs.</li>
  <li>Manuel Serrano, Bigloo's creator, has offered advice on how to write
  <a href="lang/bigloo/">Bigloo</a> programs for performance.</li>
  <li>Julian Assange has contributed a number of new and improved <a
  href="lang/ghc/">Haskell</a> programs.</li>
  <li>Steve Thompson contributed a number of the <a href="lang/se/">Eiffel</a>
  programs.</li>
  <li>Mark Baker sent in a number of suggestions for speeding up <a
  href="lang/python/">Python</a> code.</li>
  <li>Andrew Dalke also sent in a number of improvements to the <a
  href="lang/python/">Python</a> programs.</li>
  <li>Larry Zappaterrini contributed information on <a
  href="compare/binext/java/">using JNI to extend Java with C</a>.</li>
  <li>Ralph Becket helped out a lot with some <a
  href="lang/mercury/">Mercury</a> programs.</li>
  <li>Fred Bremmer has helped improve the speed of some of the <a
  href="lang/python/">Python</a> programs.</li>
  <li>Branko Vesligaj helped speed up a few of the <a href="lang/tcl/">Tcl</a>
  programs noticeably.</li>
  <li>Anton Ertl has made some helpful suggestions about the shootout, and
  has contributed a few of the <a href="lang/gforth/">GForth</a> solutions.</li>
  <li>Andrew D. McDowell has contributed some <a href="lang/cmucl/">Common
  Lisp</a> programs.</li>
  <li>Danny Valenzuela (Dirus) helped out with some faster and cleaner
  Java solutions.</li>
  <li>Stephen Weeks contributed a number of SML solutions for <a
  href="lang/mlton/">MLton</a>, which I also used for <a
  href="lang/smlnj/">SML/NJ</a>.</li>
  <li>Bulent Murtezaoglu has helped provide faster <a href="lang/cmucl/">Common
  Lisp</a> programs.</li>
  <li>Jeff Siskind has helped porting some Scheme programs to his 
  <a href="lang/stalin/">Stalin</a> compiler.</li>
  <li>Paul Foley has contributed a few new version of the <a
  href="lang/cmucl/">Common Lisp</a> programs.</li>
  <li>Bengt Kleberg has helped with the Scheme programs.</li>
  <li>Vasco Costa made some helpful comments about the C code.</li>
</ul>
    </div></div>
    </td>
  </tr>
</table>
<?php require("html/footer.php"); ?>
