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
	  <div><a href="http://shootout.alioth.debian.org/rules_for_writers.php">What do I need to know if I want to write a new benchmark?</a></div>
	  <div><a href="http://shootout.alioth.debian.org/perf_tips.php">How can I improve performance?</a></div>
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
	  <h2>A benchmark comparison of a number of programming languages.</h2>
	</div>
	<div class="app" id="projecthome" >
          <div class="h3" id="intro">
	    <h3>Intro</h3>
	    <p>This is an updated version of Doug Bagley's original
	      <a href="http://www.bagley.org/~doug/shootout">
	      Great Computer Language Shootout</a>, updated with new languages
	      and revised to work with modern compilers.</p>
            <p>Originally, the project goal was to compare all the major
	      scripting languages.  Later, compiled languages were added for
	      comparison and now are a major component of the benchmark.</p>
	    <p>The project goals have not changed substantially since Doug's
	      original project.  This work is continuing so that we all can
	      learn about new languages, compare them in various (possibly
	      meaningless) ways, and most importantly, have some fun!</p>
            <p>Someday, maybe, the results we present might be meaningful, but
	      please take the current results with a grain of salt.  You might
	      get different results on a different OS, on different hardware,
	      with newer releases of the languages, or even from run to run of
	      the same test.  You might even find that horrible bugs still lurk
	      in the testing <a href="method.php">method</a>.</p>
            <p><u>This is very much a work in progress!</u>  As it evolves we
	      may add, change, or remove languages, tests, or solutions.  Some
	      solutions as currently presented are unoptimized, and may be
	      optimized in the future (especially if people contribute better
	      solutions).</p>

	    <ul>
	      <p class="warningmark"><strong>Disclaimer No. 1:</strong> I'm just a beginner in many
	        of these languages, so if you can help me improve any of the
		solutions, please drop me an <a
href="mailto:(Brent Fulgham) bfulgham@users.alioth.debian(not .com).org">email</a>.  Thanks.</p>
              <p class="warningmark"><strong>Disclaimer No. 2:</strong> These pages are provided for
	        novelty purposes only.  Any other use voids the manufacturer's
		warranty.  Do not mix with alchohol.  Some contents may consist
		of recycled materials.  Contents packaged by weight.  Some
		settling of volume may occur.</p>
              <p class="warningmark"><strong>Disclaimer No. 3:</strong> <a href="http://www.lib.uchicago.edu/keith/crisis/disclaimer.html">ditto</a>.</p>
              <p class="warningmark"><strong>Disclaimer No. 4:</strong> Please read the pages on
	        <a href="method.php">Methodology</a>, the <a href="faq.php">
		FAQ</a>, and <a href="conclusion.shtml">Conclusions</a> before
		you flame.</p>
            </ul>
            <p>By the way, the word <em>Great</em> in the title refers to
	      quantity, not quality (history shall be the judge of that).
	      I saw a need for a more comprehensive language comparison than
	      what I could find out on the 'Net, and you are reading the
	      solution.  I wanted to see a comparison of more languages doing
	      more tests, and with (hopefully) the participation of more people.</p>
            <p>Aldo Calpini has put a huge amount of work into
	      <a href="http://dada.perl.it/shootout">porting the shootout to 
	      Microsoft Windows</a>.  He even includes some new languages and
	      some commercial compilers that run on Windows. Please
	      <a href="http://dada.perl.it/shootout">check it out</a>.
	      (Please note that there may be some differences in his port. It
	      is really a separate, derivative work). Many thanks to Aldo!</p>
          </div>
	  <div class="h3" id="download">
	    <h3>Download</h3>
	    <p>You can now download the entire shootout as a <a href=
	      "http://alioth.debian.org/tarballs.php/?group_id=10039">
	      compressed tarball</a>.  The current distribution is about 1.5MB
	      and it is approximately alpha quality (it is probably suitable
	      only for the adventurous).  The tarball is updated nightly.  I
	      will try to keep the <a href="news.php">News</a> up-to-date to
	      explain the new stuff.</p>
	  </div>
	  <div class="h3" id="links">
	    <h3>Links</h3>
	    <p>I found the following links of interest while working on this
	    project:</p>
	    <ul>
	      <!-- busted link
	  <li><a href="http://wwwipd.ira.uka.de/~prechelt/Biblio/jccpprt_computer2000.ps.gz">An empirical comparison of C, C++, Java, Perl, Python, Rexx, and Tcl for a search/string-processing program</a> by Lutz Prechelt (gzipped Postscript).</li> -->
	      <p class="infomark"><a href="http://huzhe.topcities.com/LanguageStudy.htm">A Comparison of Programming Languages for Scientific Processing</a> by D. McClain</p>
	      <p class="infomark"><a href="http://phaseit.net/claird/comp.lang.misc/language_comparisons.html"> Cameron Laird's personal notes on language comparisons</a></p>
	      <p class="infomark"><a href="http://directory.google.com/Top/Computers/Programming/Languages/">Computers > Programming > Language</a> at Google Web directory.</p>
	      <p class="infomark"><a href="http://www.tunes.org/Review/Languages.html">Review of existing Languages</a> at Tunes.org</p>
	      <p class="infomark"><a href="http://www.people.Virginia.EDU/~sdm7g/LangCrit/">Programming Language Critiques</a> by Steven D. Majewski</p>
	      <p class="infomark"><a href="http://www.angelfire.com/tx4/cus/shapes/index.html">OO Shape Examples</a> by Chris Rathman</p>
	      <p class="infomark"><a href="http://pleac.sourceforge.net/">PLEAC - Programming Language Examples Alike Cookbook</a></p>
	      <p class="infomark"><a href="http://www.uni-karlsruhe.de/~uu9r/lang/html/lang.en.html">Michael Neumann's page comparing some small programs over 100+ languages.</a></p>
	    </ul>
          </div>
        </div>
      </td>
    </tr>
  </table>

<?php require("html/footer.php"); ?>

<!-- nobody really reads the mail sent to these addresses ... can ya dig it? -->
<a href="mailto:charlescosgroveclean007@net-sieve.com">&nbsp;</a>
<a href="mailto:jack.bo.sh@infospeed.net">&nbsp;</a>
