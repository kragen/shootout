<!--#set var="TITLE" value="Object Instantiation" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Object Instantiation"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of iterations of the main object instantiation loop.</p>

<?php cmp_test("objinst", $_SERVER['QUERY_STRING']);?>
