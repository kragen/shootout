<!--#set var="TITLE" value="Object Instantiation" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory, object instantiation" --> 

<?php require("../../html/testtop.php");
      testtop("Object Instantiation"); ?>

<h4>About this test</h4>
<p>Please Note:  This test will needs to be re-designed a little to
  avoid the creation of invariant objects.</p>
<p>For this test, each program should be implemented in the <a
  href="../../method.php#sameway"><i>same way</i></a>.</p>
<p>This test attempts to measure the speed of object instantiation in
  OO languages.  It measures a mixture of creation of objects from
  base and derived classes.</p>
<p>These classes are also used in the <a href="../methcall/">Method
  Calls</a> test.  (See that page for more description of the test).</p>
<p>The correct output looks like <a href="Output">this</a>.</p>

<h4>Observations</h4>
<p>The <a href="objinst.se">SmallEiffel solution</a> (submitted by
  Steve Thompson) is implemented in multiple files.  See also the <a
  href="../Include/toggle.e">Toggle</a> class and the <a
  href="../Include/nth_toggle.e">Nth_Toggle</a> class.</p>
<p>A modest speedup could be achieved in the Perl solution by using an
  array as the base object data structure, instead of the hash we use
  here.  I have so far resisted doing this however, because the speedup
  still does not affect Perl's overall ranking in this test, and I feel
  that it is far more common to see hashes used as the base object data
  structure in Perl.  Further modest speedup could be achieved by using
  the method argument array directly (e.g. $_[0], $_[1], ...), but
  again this doesn't improve Perl's ranking and IMHO only furthers the
  prejudice that Perl is not easy to read.  I'm content to wait to see
  the improvements Perl 6 will bring to OOP in Perl.</p>

<h4><a href="alt/">Alternates</a></h4>
<p><i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i></p>
<ul>
  <li>Here's an alternate <a href="alt/objinst.cmucl2.cmucl">CMUCL</a>
 program that uses defclass to define objects as opposed to the use of
 defstruct in the current entry.</li>
</ul>

  </tr>
</table>
<?php require("../../html/footer.php"); ?>
