<?php require("html/header.php");
      require("nav.html");
      require("html/toptabs.php");
      $parts = Explode('/', $_SERVER["SCRIPT_NAME"]);
      $current = $parts[count($parts) - 1];

      toptabs($current) ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
    <td id="leftcol" width="20%">
      <div id="navcolumn">
        <div id="methodology" class="toolgroup">
	  <div class="label">
	    <strong>Methodology</strong>
	  </div>
	  <div class="body">
	    <div><a href="#cpu">Measuring CPU</a></div>
	    <div><a href="#mem">Measuring Memory</a></div>
	    <div><a href="#loc">Measuring Lines of Code</a></div>
	    <div><a href="#running">How Test Programs Are Built And Run</a></div>
	    <div><a href="#graphing">How Tests Are Graphed</a></div>
	    <div><a href="#guidelines">Test Program Guidelines</a></div>
	    <div><a href="#types">Types of Tests</a></div>
	    <div><a href="#sameway">Tests That Call For Implementations To Be Written The <i>Same Way</i></a></div>
	    <div><a href="#samething">Tests That Call For Implementations To Do The <i>Same Thing</i></a></div>
	    <div><a href="#platform">Testing Platform</a></div>
	    <div><a href="#flaws">Flaws in the Shootout</a></div>
	</div>
      </div>
      <div class="strut">&nbsp;</div>
    </td>
    <td>
      <div id="bodycol">
        <div id="apphead"><h2>Testing Methodology</h2></div>
	<div class="app" id="projecthome" >
        <div class="h3" id="intro"><h3>Intro</h3></div>
          <p>The intention of this page is to try to give some insight into
            how the project handles some of the pitfalls of doing language
	    benchmarks.</p>
	  <div class="h3" id="cpu"><h3>Measuring CPU</h3></div>
	  <p>Doug wrote a simple <em>benchmark framework</em> of scripts and
	    Makefiles so it is easy to plug in new benchmark tests and programs
	    and re-generate the data and plots.  Each test is executed as a
	    sub-process of a <a href="bin/minibench">Perl script</a> that
	    measures the total child CPU (user + system) time.</p>
	  <p>Since he wanted the measurement method to require zero special code
	    in the test programs, he made it work so that the measurement is
	    done entirely externally to the test program.  This means that the
	    startup costs of each test program will be included in the CPU
	    time measurement, but we don't really want to include this startup
	    cost.  We avoid startup costs by doing 2 things: running a pre-test,
	    where the program is loaded and run for a small input, and also by
	    running the test long enough so that the startup costs are
	    amortized over a long enough run-time so they become less
	    significant.  Currently, some tests may not run really long enough
	    to fully minimize startup costs fairly for all contestants.  Work
	    continues on this problem.</p>
	  <p>This is also the reason we run each test program over a set of
	    different input sizes.  It allows us to see at what point startup
	    costs have less of an effect.</p>
	  <p class="infomark">Please note that startup times can now be
	    factored out of the displayed results on each test index page by
	    clicking on the link <b>[cpu minus startup time]</b>.  This is done
	    by calculating the startup time of a single invocation of the test
	    process from the results of the null-program
	    (<a href="bench/hello/">Hello World</a>) test and subtracting it
	    from the results on the given test.</p>
	  <p>The measured run-times of each test program do vary somewhat from
	    run-to-run, but this was largely fixed by moving to a host
	    dedicated to running only the shootout test programs.  We try to
	    reduce caching effects by running one pre-test.  We try to make up
	    for run-to-run variation by running each test program 3 times, and
	    taking the minimum CPU time and the maximum Memory Usage out of
	    the 3 runs.</p>
        <div class="h3" id="mem"><h3>Measuring Memory</h3></div>
	  <p>While the test is running as a sub-process, the parent samples its
	    resident memory size (VmRSS) multiple times a second.  If the test
	    requires more than one process, their memory sizes are summed.
	    Note that in Linux, programs that use kernel threads show up with
	    multiple entries in the process table, one for each thread.  To
	    avoid overcounting memory of threaded processes (which used to
	    happen), we now only count memory of the main thread (the only
	    thread, if an unthreaded process).  We determine the main thread by
	    checking for SIGCHLD being registered as the exit_signal in the
	    second to last field of /proc/{pid}/stat.  Voodoo, huh?  (The memory
	    measurement should only be considered &quot;ballpark&quot;, as it
	    is an &quot;experimental&quot; feature.)  If the program causes
	    significant swapping it is killed.</p>
	  <p>Unfortunately, this sampling method has proven unreliable, and in
	    spite of our efforts, has an unresolvable race condition that we can
	    only minimize, and not fix completely.  Keep this in mind when
	    looking at the memory measurement results.  They should be viewed
	    as <i>experimental</i> and possibly wildly inaccurate.  However,
	    in practice, the innacuracies only seem to occur when the test
	    program completes very quickly.  For instance if a test completes
	    in 0.01 seconds, and my sampling granularity is 0.02 seconds, then
	    there's a good chance the memory size reported will be pretty
	    inaccurate.  Tests are run long enough so that this generally isn't
	    a problem, but it's not that easy to do when trying to include both
	    compiled (fast) languages, and interpreted (slow) languages on the
	    same graph.</p>
	  <p>Linux's BSD process accounting was investigated for measuring
	    memory size, but this appears to be unsuitable.  The size recorded
	    by this feature is the vmsize, not the resident set size, which has
	    little bearing on system performance.</p>
        <div class="h3" id="loc"><h3>Measuring Lines of Code</h3></div>
	  <p>An experimental <i>lines of code</i> metric is also reported.  For
	    each test language, a <a href="bin/loc">script</a> is used to remove
	    blank lines and comments (both to end-of-line, and block styles),
	    and then count the number of code lines left.  Of course, this is a
	    very naive method of estimating code complexity.  You should
	    realize that many solutions could be shorter, but there is some
	    extra complexity added in order to provide a faster solution.  The
	    real value of these results is not known (and could encourage poor
	    coding style) so please do not overly emphasize this metric when
	    reviewing the reports.</p>
	  <p>The lines of code counter is not currently smart enough to
	    recognize internal program documentation formats (e.g. Perl POD,
	    Lisp/Python function definitions, Eiffel and Erlang module
	    meta-information, etc).  A proper lines of code counter would not
	    count these types of things.</p>
	  <p>Offering a Lines of Code metric is problematic, as it could lead to
	    obfuscated submissions (watch it, you Perl-mongers! :-).  We reserve
	    the right to format the code entries as <strong>we</strong> see fit,
	    whatever the Lines of Code count may be.  Code entries <em>should
	    </em> be written as if the lines of code were not being measured.
	    That being said, friendly suggestions on proper code formatting will
	    be gratefully accepted.  If that leads to more compact code, so be
	    it!</p>
        <div class="h3" id="running"><h3>How Test Programs Are Built And Run
	  </h3></div>
	  <p>Some people have asked how each test is compiled and or invoked,
	    and this information is now available from the <b>log</b> link in
	    the results tables for each test.  This log captures the commands
	    used to build the program (if any), the output of those commands,
	    and the format of the command used to invoke the test program.</p>
	  <p>Each benchmark program is written to take a single numeric command
	    line parameter, which can be used as the number of test iterations
	    or as an input parameter.  If the parameter is null, then it is
	    assumed to be 1.  If the test produces any output, it is captured
	    in an output file and automatically compared to a sample output
	    file.  So every time a benchmark test is run it is also tested for
	    correctness.  This command line parameter is ignored on those tests
	    that simply take their input from stdin.</p>
        <div class="h3" id="graphing"><h3>How Tests Are Graphed</h3></div>
	  <p>For plotting, Doug wrote a <a href="/~doug/plot/">Perl script</a>
	    that wraps the Perl <em>Chart</em> class.</p>
        <div class="h3" id="guidelines"><h3>Tests Program Guidelines</h3></div>
	  <p>The general guidelines for test programs are:
	  <ol>
	    <li>They should first be written to be as fast as possible within
	      the specific guidelines as specified on the test page.</li>
	    <li>They should be as memory conservative as possible.  For
	      instance, in the <a href="bench/sumcol/">Sum a column of Numbers
	      </a> test, the program should run in constant space.  So in
	      general, programs should not try to be faster by reading all the
	      input at once, just for the sake of speed, unless the specific
	      guidelines on the test page allow that (as in the <a href=
	      "bench/reversefile/">Reverse a File</a> test).
	  </ol>
        <div class="h3" id="types"><h3>Types of Tests</h3></div>
	  <ul>
	    <li><strong>Latency vs. Throughput Tests</strong>
	    <p>In the world of benchmarking sometimes benchmarks will test how
	      long it takes to perform a task (sometimes called Latency tests),
	      other benchmarks test how many operations can be performed in a
	      given amount of time (sometimes called Throughput tests).
	      Currently, all of the tests in this project are Latency tests.
	      We are interested in working out a method for doing Throughput
	      tests, but it is problematic when designing a test over multiple
	      languages how to measure the number of completed work units.
	      </p></li>
	    <li><strong>Micro vs. Macro Tests</strong>
	    <p>Some tests might be referred to as <em>micro</em> benchmarks, in
	      that they measure the speed of just a line or two of source code
	      (e.g. the <a href="bench/strcat/">String Concatenation</a> test).
	      Other tests that measure more than just a few statements are
	      <em>macro</em> benchmarks, and are intended to measure a more
	      realistic (larger) mixture of code.  An example of this would be
	      the <a href="bench/sieve/">Sieve of Eratosthenes</a> test.  None
	      of the tests is currently very large, though.  Most of them fit
	      easily within one page of code.</p></li>
	  </ul>
        <div class="h3" id="sameway"><h3>Tests That Call For Implementations To Be Written The <em>Same Way</em></h3></div>
	  <p>Some tests are specified to be written using the same logic and
	    data structures.  The goal of this kind of test is to try to measure
	    languages doing the same operations, as closely as possible.  (Since
	    functional languages have such a different mode of expression, they
	    are allowed more leeway).</p>
	  <p>This kind of test is useful when considering questions like
	    &quot;Is array subscripting faster in Perl or Python?&quot;, or
	    &quot;Are hash table insert/lookup operations faster in Tcl or
	    Ruby?&quot;.  An example of this kind is the <a href=
	    "bench/sieve/">Sieve of Eratosthenes</a> test.</p>
	  <p>Since the purpose of the <strong>same way</strong> tests is to try
	    to compare, side by side, the same kind of operation in one language
	    as in another, they often use code that is naive and unidiomatic by
	    design.</p>
        <div class="h3" id="samething"><h3>Tests That Call For Implementations To Do The <em>Same Thing</em></h3></div>
	  <p>These other tests have a specific goal, but how they achieve the
	    results is fairly open.  We may add constraints like it has to
	    solve the problem in constant space, or cannot read in the input
	    file all at once, but at most in 4K chunks.  How it does this is
	    entirely up to the implementor.  These kinds of tests are free to
	    use the most appropriate, idiomatic code for a solution.<p>
	  <p>This kind of test useful when considering questions like
	    &quot;Is it faster to write a word frequency counter in Perl or
	    Shell?&quot;.  The <a href="bench/wordfreq/">Word Frequency</a>
	    test is a <strong>same thing</strong> test.
        <div class="h3" id="platform"><h3>Testing Platform</h3></div>
	  <p>Tests are currently running on a single-processor 1.1 Ghz
	    AMD Athlon server with 256MB of RAM and a 20GB IDE disk.</p>
	  <p class="infonote">Offers of processing time on more powerful
	    equipment would be greatly appreciated!</p>
        <div class="h3" id="flaws"><h3>Flaws in the Shootout</h3></div>
	  <p>Coming up with a benchmark that is meaningful and which does not
	    mislead in various ways is hard, as almost everyone has observed.
	    We might as well trot out the canonical quotation: &quot;There are
	    lies, damn lies, and benchmarks&quot;.</p>
	  <p>This shootout has many flaws, like any other language benchmark.
	    Just to be obvious about it, we'll try to document them here.  We
	    attempt to be as accurate as possible, but some testings issues
	    are effectively an optimization problem requiring various bad
	    choices to be selected from.</p>
	  <p>Flaws:</p>
	  <ul>
	    <li>
	      <p>A number of tests are biased towards scripting languages.</p>
	    </li>
	    <li>
	      <p>A number of tests are biased towards compiled languages.</p>
	    </li>
	    <li><p>A number of tests are biased towards imperative (vs.
	      functional) languages.</p></li>
	    <li><p>As mentioned above, the CPU measurements <em>include</em>
	      startup time.  For those languages with significant startup
	      costs (like <a href="lang/java">Java</a>), this may seriously
	      affect the measured CPU time.  While we try to minimize the
	      effect of startup costs by running the tests for a longer time,
	      a number of tests could probably be run longer still to be truly
	      fair.  You should be able to see the effect of startup time by
	      comparing Java and other languages on the test detail page (<a
	      href="bench/sieve/detail.php?bigloo=on&gcc=on&java=on&ocaml=on">
	      example</a>).</p>
	      <p>As mention above, a feature exists to allow you to subtract
	      startup times by clicking on a link on each test page.</p></li>
	    <li><p>Also as mentioned above, the current method for measuring
	      Memory usage is flawed.  It is problematic to reliably measure
	      the memory usage of a subprocess under Linux at the moment.  So
	      bear in mind that reported memory numbers may be unreliable,
	      especially for programs that run very quickly.</p></li>
	    <li><p>Some languages are not tested on their strengths, but
	      mostly on their weaknesses.  Case in point: <a href="lang/php/">
	      PHP</a>.  PHP is a fine web scripting language that provides a
	      <em>multitude</em> of built-in convenience functions to simplify
	      writing code for common CGI tasks.  Since this shootout is a
	      basic language test, and there are currently no plans to have any
	      CGI scripting tests, the fact that PHP is somewhat slower <em>in
	      these tests</em> than other scripting languages is hardly an
	      argument against its use as a web scripting language.</p></li>
	    <li><p>In some cases we are not really measuring the speed of a
	      language, but the skill of the test implementor for that given
	      language.  This has been somewhat ameliorated by helpful
	      contributions by kindly netizens.  It's possible that many
	      solutions could still be rewritten to be faster.</p></li>
	    <li><p>Quality of test implementation in some languages is largely
	      dependent on the on-line documentation for that language.  Is it
	      comprehensive and well-done, including tutorials and examples?
	      If so, the language stands a much better chance of a fair
	      treatment in our clumsy hands.  If the documentation is somewhat
	      lacking or if people are expected to buy a book in order to
	      become a good programmer in the given language, then the chances
	      of our being able to quickly learn enough to do justice to that
	      language are virtually nil.  Of course, if you want to send
	      <a href="/~doug/contact.shtml">us</a> a book to improve our skills
	      in any given language, please feel free to do so :-)</p></li>
	    <li><p>Older solutions are occasionally revisited to see if they
	      can be improved.  It is surprising that this can happen, even
	      after various people have already worked it over a few times.
	      This really is a work in progress, and solutions may continue to
	      evolve.</p></li>
	    <li><p>All artificial language performance benchmarks, this one
	      included, <em>do not measure real-world performance</em>.  One
	      should not choose a language based only on its benchmark ranking,
	      even if you believe the benchmark to be fair.  In an ideal world,
	      we would choose the language that makes us most productive,
	      <strong>and</strong> which can be optimized fairly easily, when
	      that optimization is needed.  That means a good language will
	      include a profiler tool to allow you to measure which parts of
	      your application are slow, so you can rewrite those parts to be
	      faster.  Many scripting languages allow you to rewrite the slow
	      parts in C, which should be just about all you need for speed.
	      Of course, a badly designed application may be difficult to
	      profile and speed up.  But that's the fault of the programmer,
	      not the language.</p></li>
	    <li><p>You should keep in mind that you may get significantly
	      different results on a different platform.  For instance, some
	      language compilers for Windows are better optimized than the
	      corresponding compiler that run under Linux.  You may also see
	      significantly different results on different CPUs, due to
	      instruction sets and cache sizes.  Ideally a comparison of
	      languages would include a few different platforms and CPUs, but
	      we don't currently have the resources to do that.</p></li>
	    <li><p>Like most benchmarks, the tests in this shootout are written
	      so that they do the thing we want to measure over and over in a
	      loop.  Of course, we are including the overhead of performing the
	      loop in our measurement.  You many want to take a look at the
	      <a href="bench/nestedloop/">nestedloop</a> test, and consider
	      that for some languages all their tests will be slowed down by the
	      overhead of doing loops.</p></li>
	    <li><p>The shootout has in the past had errors that produced
	      misleading measurements.  It's possible that the benchmark
	      framework still contains bugs.  For instance, when the race
	      condition in the memory sampling code was minimized, a number of
	      the memory measurements came out very differently.</p></li>
	  </ul>
<?php require("html/footer.php"); ?>
