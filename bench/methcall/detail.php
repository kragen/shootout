<!--#set var="TITLE" value="Method Calls" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Method Calls"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of method calls.</p>

<?php cmp_test("methcall", $_SERVER['QUERY_STRING']);?>
