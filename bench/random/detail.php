<!--#set var="TITLE" value="Random Number Generator" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Random Number Generator"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the number of random numbers generated.</p>

<?php cmp_test("random", $_SERVER['QUERY_STRING']);?>
