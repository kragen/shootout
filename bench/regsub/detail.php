<!--#set var="TITLE" value="Regular Expression Substitution" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Regular Expression Substitution"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the number of times we do the regsub.</p>

<?php cmp_test("regsub", $_SERVER['QUERY_STRING']);?>
