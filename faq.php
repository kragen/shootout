<?php $title = "Frequently Asked Questions";
      require("html/header.php");
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
	    <strong>FAQ</strong>
	  </div>
	  <div class="body">
	    <div><a href="#intro">Introduction</a></div>
	    <div><a href="#why_doing">Why are you doing this?</a></div>
	    <div><a href="#fair">Is your shootout a fair comparison?</a></div>
	    <div><a href="#fav_lang">Will you include my favorite language X?</a></div>
	    <div><a href="#proprietary">Will you compare REBOL/Limbo/Miranda/Clean?</a></div>
	    <div><a href="#gwydion">Will you include Gwydion Dylan?</a></div>
	    <div><a href="#pascal">Will you include Pascal/Prolog/Ada?</a></div>
	    <div><a href="#apl">Will you include Fortran/APL?</a></div>
	    <div><a href="#super_opt">Will you try recompiling language X with
	    super-hyper-optimization and all these configure switches?</a></div>
	    <div><a href="#numerical">Why are you doing all these numerical tests in scripting languages?</a></div>
	    <div><a href="#cool_test">Will you include my idea for a cool test?</a></div>
	    <div><a href="#old_code">I sent you a faster program, and you told me you posted it, but I still see the old code?</a></div>
	    <div><a href="#platform">What kind of platform are the tests run on?</a></div>
	    <div><a href="#sparc">Why don't you run the tests on Sparc/Alpha/PPC/etc?</a></div>
	    <div><a href="#naive">Why do many of your solutions seem naive and unidiomatic?</a></div>
	    <div><a href="#time_to_code">Why don't you also measure the time it took to write the code?</a></div>
	    <div><a href="#maintain">Why don't you also measure engineering quality?</a></div>
	    <div><a href="#accordion">Do you like accordian music</a></div>
	</div>
      </div>
      <div class="strut">&nbsp;</div>
    </td>
    <td>
      <div id="bodycol">
        <div id="apphead"><h2>Frequently Asked Questions</h2></div>
	<div class="app" id="projecthome" >
        <div class="h3" id="intro"><h3>Intro</h3></div>
        <p>The following questions are frequently asked by people curious
	about the shootout, its methodology, and why things are done
	certain ways in the project.</p>
	<hr>
	
        <div class="h3" id="why_doing"><h3>Q: Why are you doing this?</h3></div>
	<p>To learn and to have fun.  We'll continue as long as the fun holds out.</p>
	<hr>

        <div class="h3" id="fair"><h3>Q: Is your shootout a fair comparison?</h3></div>
	<p>Not really.  As stated on the home page: <strong>It's a work in
	progress</strong>.  Maybe in a year it will be at a point where it is
	&quot;fair&quot;.  Feel free to help out or come back later and decide
	for yourself.  Thanks.</p>
	<hr>
	    
        <div class="h3" id="fav_lang"><h3>Q: Will you include my favorite language X?</h3></div>
	<p>We already have more than we can handle :-) but we <i>might</i> if
	your language:
	<ol>
	  <li>Is Free.  The hope is that people who come across the shootout
	    will be motivated to learn a new language, and since the barriers
	    to learning a new language are far lower for a free implementation,
	    those are the preffered languages for display.  While commercial
	    languages are not <em>officially</em> disqualified, there do not
	    seem to be many compelling reasons to include one.</li>
	  <li><p>Is distributed with source code!  Programming languages should
	    be open source.  As language users, when we find a problem but do
	    not have access to the source code it is very frustrating.  If
	    you have ever had to maintain production software for a compiler
	    that is no longer available from a vendor, with no available bug
	    fixes, you will soon understand this requirement.</p>
	    <p>In my testing of languages I have found bugs in half a dozen
	    of the languages, and I have been able to submit bug reports,
	    sometimes with patches, to the language authors.  I think that's
	    the way things should work.</p></li>
	  <li><p>Is available as a <a href="http://www.debian.org">Debian</a>
	    package (either from Debian itself, or the primary authors of
	    the language.)</p>
	    <p>As an <em>absolute minimum</em> it must build and install with
	    <code>./configure && make && make install</code> (on Linux), with
	    a default target of /usr/local.</p></li>
	  <li>Is in current use and development.  (I might make exceptions for
	    something cool.  Like maybe Simula).  Unfortunately, since Mercury
	    has not been updated (according to their web site) for a couple
	    of years, they have been disabled for the time being.</li>
	  <li>Ideally, it should have a measurable userbase.</li>
	</ol>
	<p>Furthermore, the language <b>must</b> have the following features:</p>
	<ol>
	  <li>Documentation.</li>
	  <li>Ability to parse an integer from the command line.</li>
	  <li>32-bit Integers.</li>
	  <li>Double precision floating point numbers and the ability to
	    format them for output (equivalent to <code>printf("%.9f", f);</code>).</li>
	  <li>Hash tables and Sequences (Arrays and/or Lists).</li>
	  <li>Ability to read lines from standard input, write lines to
	    standard output.</li>
	</ol>
	<p>The language <b>should</b> have most of the following desireable
	  features:</p>
	<ol>
	  <li>Ability to read/write 4K buffers, bypassing standard I/O.</li>
	  <li>Process control (i.e. fork()/wait()).</li>
	  <li>Exception handling.</li>
	  <li>Regular Expressions (preferably Perl compatible).</li>
	  <li>Concurrency (Threads, Coroutines, etc.)</li>
	  <li>Internet Sockets.</li>
	  <li>Objects.</li>
	  <li>Ability to print out its own version number.</li>
	  <li>A module system, and separate compilation of modules (if
	    compiled).</li>
	</ol>
	<p>Exceptions may be granted, but only in a capricious, completely
	  unfair and biased fashion.  :-)</p>
	<hr>
	
        <div class="h3" id="proprietary"><h3>Q: Will you compare REBOL/Limbo/Miranda/Clean?</h3></div>
	<p><strong><a href="lang/clean">Clean</a> is now included</strong></p>
	<p>Last time I checked, the other languages either do not come with
	  source, or are commercial products.  As a matter of principle,
	  the project is currently limited to free, open-source languages.
	  Closed source languages are a bad idea.  In my most humble
	  opinion, of course.  If I make an exception to this, it will
	  probably only be for a language that is wildly popular (like
	  Java).</p>
	<hr>

        <div class="h3" id="gwydion"><h3>Q: Will you include Gwydion Dylan?</h3></div>
	<p>Originally, Doug declined because 3 files were needed just to do a
	&quot;hello world&quot; program in Dylan.</p>
	<p>In an excellent example of Open Source at work, the Gwydion Dylan
	compiler was modified to support a single-file mode.  And now that
	Brent is running things (and is a core Gwydion Dylan maintianer),
	we are happy to say that <a href="lang/gwydion">Gwydion Dylan</a>
	is now supported.</p>
	<p>Sometime soon, you will probably see Functional Developer in
	there as well...</p>
	<hr>
	
        <div class="h3" id="pascal"><h3>Q: Will you include Pascal/Prolog/Ada?</h3></div>
	<p><a href="lang/gnat">Ada</a> is now supported.</p>
	<p>Expect to see GNU Prolog supported at some point.  Pascal is a
	  lower priority, since it's really not that cool of a language.  ;-)</p>
	<hr>

        <div class="h3" id="apl"><h3>Q: Will you include Fortran/APL?</h3></div>
	<p><strong>Look for the A+ language soon.</strong></p>
	<p>It's been over twenty years since I've programmed in either of those
	languages.  IMHO, they are both fairly specialized, and probably
	wouldn't do so well in some of the tests I currently have in the
	shootout.  I'm not counting them out entirely, but I have a lot of
	work to do before I can even get to them.</p>
	<hr>
	
        <div class="h3" id="super_opt"><h3>Q: Will you try recompiling language
	X with super-hyper-optimization and all these configure switches?
	</h3></div>
	<p>In general, the languages are compiled and installed per the
	primary author's instructions for normal users (especially those
	installed as Debian packages.)  Other optimizations will have to
	be decided on a case-by-case basis.  In general, we don't want to
	use non-standard installations of the software.</p>
	<p>This has come up more than once with issue of <a href=
	"lang/php/">PHP</a>.  To be fair we have to apply the same rules
	to everyone.  If exceptions are made for one language, then the
	same special handling must be applied to all of them.</p>
	<p>In practice, very few people would install their compilers using
	non-standard switches.  If it was truly the best configuration, why
	is that not the standard?  The shootout attempts to be a test of
	relatively normal conditions.  Does PHP get configured with the
	<code>--enable-inline-optimization</code> flag in most binary
	distributions?  If yes, I'm willing to reconsider my position.  If no,
	then I think what I'm doing is fair.  As far as I know, PHP is the
	<strong>only</strong> language in the shootout that does not configure
	for performance &quot;out of the box&quot;.  Maybe the PHP developers
	should consider changing that situation.<p>
	<hr>
	
        <div class="h3" id="numerical"><h3>Q: Why are you doing all these numerical
	tests in scripting languages?</h3></div>
	<p>More generally maybe you mean <i>Test X</i> is not really
	appropriate for <i>Language Y</i>.</p>
	<p>This is true.</p>
	<p>But maybe it is meaningful to see two languages trying to do the
	same thing ... no matter whether you would ever normally use them to
	do that thing.  YMMV.</p>
	<p>We include tests like the <a href="bench/sieve">Sieve</a> because
	it's a classic.  Many of the other tests have appeared in other
	language comparisons.</p>
	<p>Tests that do a lot of line-oriented I/O are included because lots
	of people do that sort of thing with scripting languages.  Yes, we
	know it's a heck of a lot faster to do block I/O, and we'll try to
	have tests that do that too.</p>
	<hr>
	
        <div class="h3" id="cool_test"><h3>Q: Will you include my idea for a cool
	test?</h3></div>
	<p>Mmmmaybe.  Will you help?  Join the <a href=
	"http://lists.alioth.debian.org/mailman/listinfo/shootout-discuss">
	shootout-discuss</a> mailing list and join the fun!</p>
	<hr>
	
        <div class="h3" id="old_code"><h3>Q: I sent you a faster program, and you
	told me you posted it, but I still see the old code?</h3></div>
	<p>Try reloading when viewing the source code.  It is probably just
	cached.</p>
	<hr>
	
        <div class="h3" id="platform"><h3>Q: What kind of platform are the tests
	run on?</h3></div>
	<p>The current shootout host is a single-processor 1.1 Ghz AMD
	Athlon machine with 256 MB of RAM and a 20GB IDE disk drive.</p>
	<p>Not impressed?  Provide an alternative!</p>
	<hr>

        <div class="h3" id="sparc"><h3>Q: Why don't you run the tests on
	Sparc/Alpha/PPC/etc?</h3></div>
	<p>The shootout would gladly accept your kind hardware donations :-)
	Until then, I'm sorry, but I only own a few Intel boxes.</p>
	<hr>

	<div class="h3" id="naive"><h3>Q: Why do many of your solutions seem
	naive and unidiomatic?</h3></div>
	<p>There are two <i>kinds</i> of tests in the shootout, tests where
	solutions are supposed to do things in the <a href=
	"method.php#sameway"><b>same way</b></a> and tests where the
	solutions are supposed to do the <a href="method.php#samething">
	<b>same thing</b></a>.  Please refer to the <a href=
	"method.php#sameway">page about methodology</a> for a discussion of
	why the <b>same way</b> tests often show naive or unidiomatic code.
	It is intentional.</p>
	<hr>
	
	<div class="h3" id="time_to_code"><h3>Q: Why don't you also measure the time
	it took to write the code?</h3></div>
	<p>Because I don't just sit down and write one of the test programs
	and post it.  I work on it a little and come back over and over to
	see if I can make it better.  It wouldn't be fair, since I know
	some languages much better than others.  Furthermore, a number of
	the programs were not written by me.  There is just is no way for
	me to practically measure the time spent coding in this shootout.
	I will let someone else design a test of how long it takes to code
	something.</p>
	<hr>
	
        <div class="h3" id="maintain"><h3>Q: Why don't you also measure
	maintainability or productivity or some other more important software
	engineering quality?</h3></div>
	<p>Because this is simply a comparison of CPU, Memory and Lines of
	Code.  That's all I can and will and want to measure.  I'd love to
	see a comparison of some other metrics but I don't have the time and
	resources to do it myself.</p>
	<hr>
	
        <div class="h3" id="accordion"><h3>Q: Do you like <a href="http://www.brave.com/bo/">accordian music</a>?</h3></div>
	<p>Yes!</p>

<!--
        <div class="h3" id="why"><h3>Q: Why are you doing this?</h3></div>
	<p>
	<hr>
  
  -->
<?php require("html/footer.php"); ?>
