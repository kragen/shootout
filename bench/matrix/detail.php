<!--#set var="TITLE" value="Matrix Multiplication" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Matrix Multiplication"); ?>

<center><h2>Measurements while N varies</h2></center>
<p>
  The test parameter N is the number of times we multiply 2 matrices.

<?php #$file = "../../html/cmp_test.pl?$_SERVER['QUERY_STRING']";
      #require($file);
      require("../../html/detail.php"); ?>
