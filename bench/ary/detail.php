<!--#set var="TITLE" value="Array Access" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Array Access"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of array elements we access.</p>

<?php #include virtual="../../html/cmp_test.pl?$QUERY_STRING"
      require("../../html/detail.php"); ?>
