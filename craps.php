<!--#set var="TITLE" value="Computer Language Shootout Scorecard" -->
<!--#set var="KEYWORDS" value="performance, benchmark, computer,
algorithms, languages, compare, cpu, memory, lines of code" --> 
<?php require("html/header.php");
      require("html/toptabs.php");
      require("html/testnav.php");

      $parts = Explode('/', $_SERVER["SCRIPT_NAME"]);
      $current = $parts[count($parts) - 1];

      toptabs($current) ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
  <?php benchlist("."); ?>
    <div id="helptext" class="toolgroup">
      <div class="label">
        <strong>Notes:</strong>
      </div>
      <div class="body">
        <div><a href="#">Not all languages are tested in every benchmark</a></div>
        <div><a href="http://shootout.alioth.debian.org/bench/report.txt">What solutions have not been implemented yet?</a></div>
        <div><a href="http://alioth.debian.org/tarballs.php/?group_id=10039">Where can I get a copy of the shootout?</a></div>
      </div>
    </div>
									            <div id="admfun" class="toolgroup">
      <div class="label">
        <strong>Other Language Comparisons</strong>
      </div>
      <div class="body">
        <div><a href="compare/binext/">Creating Binary Extensions</a></div>
      </div>
    </div>
    <?php nav_list_end(); ?>
    <td>
      <div id="bodycol">
        <div id="apphead">
	  <h2>Which languages is best?  Here's the Shootout Scorecard!</h2>
	</div>
	<div class="app" id="projecthome">
	  <div class="warningmessage">
	    <p>Warning!  This page is <i><b>just for fun</b></i> :-)</p>
	  </div>
	  <p><b>Please bear in mind that this is a work in progress, if you
	    come back tomorrow, everything may be different.</b></p>
	  <p>Some people have suggested that I summarize the results, or
	    declare a winner.  In order to satisfy this request, I have come
	    up with a unique and subtle quantification system to score
	    languages on their overall performance, which I call the
	    <i><b>Completely Random and Arbitrary Point System!</i></b>, or
	    <i><b>CRAPS!<sup><small>[TM]</small></sup></b></i>, for short.
	    (See bottom of page for a brief description of this analytical
	    marvel).</p>
	  <p>The scores in the Scores table can reflect CPU, Memory and/or
	    Lines of Code (LOC).  The lower a language's measured CPU, Memory,
	    or LOC is for a test, the more points it gets.  But the language
	    doesn't get any points if it is missing an entry for a test (an
	    incentive to complete all tests :-).  You can choose a multiplier
	    for any of CPU, Memory and LOC scores below.  By default, we just
	    show the CPU score alone.  Also, each test is weighted, because
	    some tests are more important than others (the default weights in
	    the table below reflect my personal preferences).  But you can
	    change the weights and the multipliers however you like, because
	    after all, benchmark results should reflect the priorities of the
	    person viewing them.</p>
	  <p>Once you have selected the weights and multipliers to your
	    satisfaction, you can recalulate the scores and use the resulting
	    URL on your language advocacy page as the final proof of your
	    favorite language's supremacy!  Think of the glory.</p>
	  <p>Of course, it's also possible that my results are 
	    <a href="method.php#flaws">flawed</a>, and playing with this silly
	    CGI is just a waste of time.</p>
	  <br>
          <?php require("html/craps_funcs.php");
                do_craps($_SERVER['QUERY_STRING']); ?>
          <br>
	  <p>The <b>CRAPS!</b> point system works thusly:</p>
	  <ul>
	    <li>For each test, add the max and min CPU, this is the base
	      score.  (We do the same for Memory and LOC scores).</li>
	    <li>For each language, subtract its CPU from the base score,
	      normalize to between 0 and 10 then multiply by the weight of
	      the test (a number between 0 and 5), this is the language's
	      score for that test.  If a language does not have an entry for
	      a test its score is zero.  (Again we do the same for Memory
	      and LOC).</li>
	    <li>Then the CPU/Memory/LOC scores are multiplied by their
	      respective Mulipliers and the resulting scores are added together
	      to the get final score.</li>
	    <li>Add up all the scores for each language for each test, and put
	      them on this nice web page.</li>
	    <li>And the result is <b>CRAPS!</b>.</li>
	  </ul>
        </div>
      </div>
    </td>
  </tr>
</table>
<?php require("html/footer.php"); ?>
