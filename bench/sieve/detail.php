<!--#set var="TITLE" value="Sieve of Eratosthenes Benchmark" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
sieve, eratosthenes, erastosthenes, primes, c, eiffel, erlang, gawk,
awk, guile, java, perl, python, tcl, computer, language, compare, cpu,
memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Sieve of Eratosthenes Benchmark"); ?>
      
<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of times we compute the number of primes from 2
  through 8192.</p>

<?php cmp_test("sieve", $_SERVER['QUERY_STRING']);?>
