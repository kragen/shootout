<!--#set var="TITLE" value="Lists" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Ackermann's Function"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of times we run a function that tests list operations.</p>

<?php cmp_test("lists", $_SERVER['QUERY_STRING']);?>
