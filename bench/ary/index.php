<!--#set var="TITLE" value="Array Access" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory, array access" --> 

<?php require("../../html/testtop.php");
      testtop("Array Access"); ?>

<div class="h4"><h4>About this test</h4></div>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>.</p>
<p>Originally this test was pretty much the same as the array test from
  <a href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html">
  Timing Trials, or, the Trials of Timing: Experiments with Scripting
  and User-Interface Languages</a> by Brian W. Kernighan and Christopher
  J. Van Wyk.  My original implementation</a> of this test was pretty
  close to the Kernighan and Wyk version.  I also did an experiment of
  manually unrolling the loop around the array.  These two versions of
  the test are now obsoleted and superceded by this page.</p>
<p>This test is supposed to just test array access via subscripting.
  However, the original test didn't take into account array
  initilization overhead, and so in this version we create an array
  and then re-use it many times.</p>
<p>Note that one loop counts down from the end of the array to the
  beginning.  This is to give the advantage to a random-access data
  structure, as an <i>array</i> should be, and not just any sequence
  data structure, as such as a <i>list</i>.</p>
<p>The correct output (for N = 1000) looks like this:
<pre>
  <?php require("Output"); ?>
</pre>

<!--
<h4>Observations</h4>
<p>

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
</ul>
 -->

  </tr>
</table>

<?php require("../../html/footer.php"); ?>
