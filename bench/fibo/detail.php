<!--#set var="TITLE" value="Fibonacci Numbers" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Fibonacci Numbers"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the input to the Fibonacci function.</p>

<?php cmp_test("fibo", $_SERVER['QUERY_STRING']);?>
