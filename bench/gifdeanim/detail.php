<!--#set var="TITLE" value="GIF deanimation" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->
<?php require("../../html/testtop.php");
      testtop_nav("Ackermann's Function"); ?>
      
<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the number of times we extract the GIF frames.</p>

<?php cmp_test("gifdeanim", $_SERVER['QUERY_STRING']);?>
