<!--#set var="TITLE" value="Heapsort" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Heapsort"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the size of the array of random numbers that
  we sort.</p>

<?php cmp_test("heapsort", $_SERVER['QUERY_STRING']);?>
