<!--#set var="TITLE" value="Nested Loops" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Nested Loops"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>

<p>The test parameter N is the number of times each nested loop iterates.</p>

<?php cmp_test("nestedloop", $_SERVER['QUERY_STRING']);?>
