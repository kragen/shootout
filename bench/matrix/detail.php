<!--#set var="TITLE" value="Matrix Multiplication" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Matrix Multiplication"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the number of times we multiply 2 matrices.</p>

<?php cmp_test("matrix", $_SERVER['QUERY_STRING']);?>
