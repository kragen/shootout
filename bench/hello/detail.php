<!--#set var="TITLE" value="Hello World" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Hello World"); ?>
      

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the number of times the Hello World program
  is run.</p>

<?php cmp_test("hello", $_SERVER['QUERY_STRING']);?>
