<!--#set var="TITLE" value="Echo Client/Server" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->
<?php require("../../html/testtop.php");
      testtop_nav("Echo Client/Server"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>N is the number of echos the client requests from the server.</p>

<?php cmp_test("echo", $_SERVER['QUERY_STRING']);?>
