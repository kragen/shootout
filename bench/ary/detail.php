<!--#set var="TITLE" value="Array Access" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Array Access"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of array elements we access.</p>

<?php cmp_test("ary", $_SERVER['QUERY_STRING']);?>
