<!--#set var="TITLE" value="Sieve of Eratosthenes Benchmark" -->
<!--#set var="KEYWORDS" value="performance, benchmark, ackerman,
sieve, eratosthenes, erastosthenes, primes, c, eiffel, erlang, gawk,
awk, guile, java, perl, python, tcl, computer, language, compare, cpu,
memory" -->

<?php require("../../html/testtop.php");
      testtop("Sieve of Eratosthenes"); ?>

<h4>About this test</h4>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>.</p>
<p>The test programs are written to find the count of the primes from 2
  up to 8192 and then print the count.  Each program can take a single
  command line parameter to tell it how many times to find the count.
  For this test the number of iterations (N) is shown in the current
  graph above.  Visit the <a href="detail.php">detail page</a> to
  see results for different values of N.</p>
<p>The algorithm used is a naive implementation of the Sieve of
  Eratosthenes.  The intention was to see how each language compares
  when using similar data structures and operations, (i.e. arrays,
  loops, loop counters, integer math ...).  Each implementation should
  match as closely as possible the logic and data structures used in
  the <a href="sieve.gcc">C version</a>.</p>
<p>The exceptions here are the purely functional languages: Erlang,
  Mercury, Haskell(GHC) and SML.  Since they don't implement loops and
  arrays like the imperative languages shown here, the tests for these
  languages have been written with recursive implementations.</p>

<h4>Observations</h4>
<p>The following programs exceed the time limit (300 CPU seconds) and
  are disqualified:
  <a href="sieve.bash">Bash</a></p>
<p>In general, the memory usages shown here are due to the differing
  run-time systems of each language, the actual memory requirements
  for this test should be fairly minimal.</p>
<p>At much higher values of N (e.g. 1000), the C++/STL program is the
  winner.</p>
<p>The results for SML/NJ and Mercury are probably more indicative that
  I'm a lousy functional programmer.  I'm working on that ...</p>
<p>Dave Thomas contributed the <a href="sieve.ruby">ruby</a> program
  which is speedier than my original because it uses Ruby's Array
  constructor to initilize the array.  I believe the reason it appears
  to use more memory is that the the garbage collector does not get
  invoked until we reach a limit ... which is not reached during this
  test.</p>
<p>At least on my machine, it is a big win to use a char array instead of
  an array of integers.  This alone will give more than a 2X improvement
  in speed.  The cause may be related to L2 cache size.</p>

<h4>About the Sieve of Eratoshthenes</h4>
<p>This method of finding prime numbers is named after its inventor,
  Eratosthenes of Cyrene (now in Libya), who lived from 276 to 197 BC.
  After studying in Alexandria and Athens he became the director of
  the Library in Alexandria.  After Eratosthenes, the science of prime
  numbers was pretty much stagnant until Fermat came along in the 17th
  century.  Eratosthenes is also known for his fairly accurate
  measurements of the Earth's circumference, tilt, and distance from
  the sun and moon.</p>

<p>The Sieve of Eratosthenes method goes like this.  Suppose we wish to
  find all prime numbers from 2 to N:

<ul>
  <li>Keep a list of the numbers 2 to N, in order.</li>
  <li>Start with all numbers marked prime.</li>
  <li>From the lowest to the highest number ...</li>
  <li>If a number is marked, then unmark all multiples of the number.</li>
  <li>Then come back to the next number and repeat.</li>
  <li>When we're done, only the primes remain marked.</li>
</ul>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>I find it helps Forth's <i>readability</i> to add lots of <a
  href="alt/ann.sieve.forth">annotation</a>, otherwise I get lost
  as to what's on the stack.</li>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
