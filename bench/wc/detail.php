<!--#set var="TITLE" value="Sum a Column of Numbers" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Count Lines/Words/Characters"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is used as a multiple of the input data size.
  So if N is 2, the test is fed 2 copies of the input data on standard
  input.</p>

<?php cmp_test("wc", $_SERVER['QUERY_STRING']);?>
