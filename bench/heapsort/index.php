<!--#set var="TITLE" value="Heapsort" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory, heapsort" --> 

<?php require("../../html/testtop.php"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.
<p>
  This test implements a in-place heap sort function that takes
  arguments (N, ARY), where N is the number of elements in the array
  ARY, starting from index 1.  ARY is passed by reference.  We use
  the heapsort algorithm from <i>Numerical Recipes in C</i>, section
  9.2, pg 247.  The values that are sorted are randomly generated
  double-precision floating point numbers.  We use the same naive
  (and lightweight) pseudo-random number generator used in the <a
  href="../random/">Random Number Generator</a> test.
<p>
  For the given value of <b>N = 1000</b>, each test should output the
  answer: <!--#include virtual="Output" -->

<h4>Observations</h4>
<p>
  In order to be able to add bigloo I had to use different constants
  for the random function since bigloo's fixnums have 2 less bits than
  a C integer.
<p>
  The SmallEiffel <a href="heapsort.se">program</a> uses an externally
  defined <a href="../Include/randomnumber.e">class</a> to generate
  the random numbers to sort.
<p>
  The following programs are currently disqualified because they don't
  output the correct answers:
  <a href="heapsort.bigforth">bigforth</a>, 
  <a href="heapsort.njs">njs</a>, 
  <a href="heapsort.rep">rep</a>.


<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<li>
  The Perl code uses a local alias (typeglob) for the passed array
  (thanks to Matthew Harris).  Perl is normally call-by-value, but in
  this program, the array could be very large, and you wouldn't to
  pass it (and have it returned) by value.  You could also pass the
  array by reference as in <a href="alt/heapsort.perl2.perl">this
  example</a>, but then you have to explicitly dereference the array
  reference which is a little slower than using the typeglob.
</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
