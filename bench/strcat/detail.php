<!--#set var="TITLE" value="String Concatenation" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("String Concatenation"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of times we concatenate a suffix on a string.</p>

<?php cmp_test("strcat", $_SERVER['QUERY_STRING']);?>
