<!--#set var="TITLE" value="Rules for Benchmark Writers" -->
<!--#set var="KEYWORDS" value="performance, benchmark, computer,
algorithms, languages, compare, cpu, memory" --> 
<?php require("html/header.php");
      require("nav.html");
      require("html/toptabs.php");
      require("html/testnav.php");
     
      $current = "index.php";
      toptabs($current); ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
<?php benchlist(".");
      nav_list_end(); ?>
  <td>
    <div id="bodycol">
      <div id="apphead"><h2>Rules for Benchmark Writers</h2></div>
      <div class="app">
      <p>Throughout the course of working on this shootout, I've encountered
      many of the pitfalls of benchmarking.  Most of the language benchmarks
      that I see on the web have the same mistakes.  So I've decided to
      write down some guidelines that I think language benchmarks should
      follow.  Maybe this will be of use to others who want to do the same
      thing.</p>
      <ol>
        <p><li>The most important rule: allow experts in each language to review
	  and comment on your tests.  Because if you are writing all the tests
	  by yourself, <i>you <b>will</b> overlook some obvious optimizations
	  </i>.</li></p>
	<p><li>In order to support Rule 1, you should document everything.  In
	  the spirit of <b>full disclosure</b> you should at least include:</li></p>
	  <p></p><ul>
	    <li>Publish how you built each language.  This should include any
	      configuration/build options other than the default.  If you
	      installed the languages from binaries, tell where you obtained
	      them.  Others should be able to duplicate your work exactly.</li>
	    <li>Publish the details of your test platform.  At a minimum, you
	      should tell the CPU type, RAM, and OS version.  It might help to
	      give versions of libraries, as appropriate.</li>
	    <li>Publish the versions of the languages you have tested.</li>
	    <li>Publish the source code and input data.  If you just publish a
	      table of results, or worse, make a claim &quot;In my test,
	      language A ran 5 times faster&quot;, please do everyone a favor
	      and get serious!</li>
	    <li>Publish <i>how</i> you ran each test and measured your results.
	      Did you use /bin/time?  Did you implement your own internal timer
	      routines?</li>
	  </ul>
        <p><li>You should run the tests for a long enough time.  Just how long
	  may be dependant on what you want to show.  It is probably best to
	  show the performance corresponding to a range of input sizes or
	  run-times.</li></p>
	<p><li>Make an effort to understand and explain what it is you are
	  actually measuring.  Benchmarks may not be measuring what you think
	  they measure.  In the original <a href="bench/hash/">Hash Test</a>,
	  it became apparent that the timings were largely affected by the
	  performance of the routine used to convert an integer to a hex
	  string.  Also, in many tests we repeat operations in a loop in order
	  to get test timings that are long enough to measure.  Some languages
	  may optimize away invariant calculations in a loop.  And some
	  languages may be able to implement very efficient loops, while others
	  may implement very slow loop control structures.  You might want to
	  do a <a href="bench/nestedloop/">null loop test</a> to see the
	  overhead looping has in each language.  Even more confusingly, any
	  single language is likely to have a variety of looping syntaxes, each
	  of a different speed.</li></p>
	<p><li>Most benchmarks I've seen only show CPU performance.  I think
	  it is important to also show memory usage. It is also nice to know
	  Lines of Code and process <a href="bench/hello/">Startup Time</a>.
	  For compiled languages, it is also good to show how long it takes to
	  compile your test programs.</li></p>
	<p><li>You should ensure that your test programs do not cause swapping,
	  or at least you should detect if a test starts to swap, and report
	  that in your results.</li></p>
	<p><li>In order to minimize differences in run-times of the same test
	  program between separate test runs, you should try to run your tests
	  on a dedicated host.  In any case, you should at least try to stop
	  all other unnecessary processes, and document what approach you have
	  taken to avoid interference by external processes.</li></p>
	<p><li>The more tests you can run the better.  It is very hard to make
	  a general conclusion even if you run dozens of tests.  If you just
	  run a handful of tests, it is impossible.</li></p>
      </ol>

<?php require("html/footer.php"); ?>
