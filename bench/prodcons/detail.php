<!--#set var="TITLE" value="Producer/Consumer Threads" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      testtop_nav("Producer/Consumer Threads"); ?>

<p>N is the number of items produced/consumed.</p>

<?php cmp_test("prodcons", $_SERVER['QUERY_STRING']);?>
