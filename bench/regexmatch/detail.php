<!--#set var="TITLE" value="Regular Expression Matching" -->
<!--#set var="KEYWORDS" value="performance, benchmark, regular, 
expression, computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Regular Expression Matching"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>

<p>N is the number of times we extract a list of phone numbers from the
  test input data.  (The input data is only read once).</p>

<?php cmp_test("regexmatch", $_SERVER['QUERY_STRING']);?>
