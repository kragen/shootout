<!--#set var="TITLE" value="Hashes, Part II" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory" -->

<?php require("../../html/testtop.php");
      require("../../html/cmp_test.php");
      testtop_nav("Hashes, Part II"); ?>

<div class="h4"><h4>Measurements while N varies</h4></div>
<p>The test parameter N is the number of times the first hash is added
  into the second hash.</p>

<?php cmp_test("hash2", $_SERVER['QUERY_STRING']);?>

