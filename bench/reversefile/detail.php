<!--#set var="TITLE" value="Reverse a File" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Reverse a File"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is used as a multiple of the input data size.
  So if N is 2, the test is fed 2 copies of the input data on standard
  input.</p>

<?php cmp_test("reversefile", $_SERVER['QUERY_STRING']);?>
