<?php $title="Shootout Documentation";
      $keywords = "performance, benchmark, computer, algorithms, languages, compare, cpu, memory";
      require("html/header.php");
      require("html/toptabs.php");
      $parts = Explode('/', $_SERVER["SCRIPT_NAME"]);
      $current = $parts[count($parts) - 1];

      toptabs($current) ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
    <td id="leftcol" width="20%">
      <div id="navcolumn">
        <div id="documentation" class="toolgroup">
	  <div class="label">
	    <strong>FAQ</strong>
	  </div>
	  <div class="body">
	    <div>Local Documentation
	      <div><a href="#ack">Acknowledgements</a></div>
	      <div><a href="#faq">Frequently Asked Questions</a></div>
	      <div><a href="#methods">Methodology</a></div>
	      <div><a href="#perftip">Performance Tips</a></div>
	      <div><a href="#rules">Rules for Benchmark Writers</a></div>
	      <div><a href="#editorial">Editorial</a></div>
	      <div><a href="#conclusions">Conclusions</a></div>
	      <div><a href="#todo">Todo List</a></div>
	    </div>
	    <div><a href="#links">Interesting Links</a></div>
	</div>
      </div>
      <div class="strut">&nbsp;</div>
    </td>
    <td>
      <div id="bodycol">
        <div id="apphead"><h2>Documentation</h2></div>
	<div class="app" id="projecthome" >

	<h3>Local Documentation</h3>
        <p>The following links provide some background and documentation about
	the shootout, the methods and measurement techniques used in the
	shootout, things left to do, frequently asked questions, and a set of
	useful links.

	<ul>
	  <div id="ack">
	    <li><p><strong>Acknowledgements</strong></p>
	      <p>The <a href="/ack.php">acknowledgements</a> section tries to
	        list the many helpful and inspirational sources (and people)
		who have made the shootout possible.</p></li></div>

	  <div id="faq">
	    <li><p><strong>Frequently Asked Questions</strong></p>
	      <p>The <a href="/faq.php">FAQ</a> contains questions frequently
	        asked by people curious about the shootout, its methodology,
		and why things are done certain ways in the project.</p></li></div>
	
	  <div id="methods">
	    <li><p><strong>Methodology</strong></p>
	      <p>The <a href="/method.php">methodology</a> page discusses the
	        techniques the project uses to gauge language performance.  It
		also discusses pitfalls and weaknesses in the current
		implementation.</p></li></div>

	  <div id="perftip">
	    <li><p><strong>Performance Tips</strong></p>
	      <p>This <a href="/perf_tips.php">section</a> documents tips we've
	        been made aware of for speeding up programs in various
		languages.  The language specific hints have been moved to the
		respective <a href="lang/">language summary pages</a>, so this
		page now just contains the general hints.</p></li></div>

	  <div id="rules">
	    <li><p><strong>Rules for Benchmark Writers</strong></p>
	      <p>These <a href="rules_for_writers.php">rules</a> codify the
	        experience gained in writing the shootout.  There are many
		pitfalls to the art and science of measuring performance.  
		This section attempts to share some of this information.</p></li></div>

	  <div id="editorial">
	    <li><p><strong>Editorial</strong></p>
	      <p>A few <a href="/editorial.php">notes</a> from the original
	        author of the Shootout giving his thoughts on the experience.
	      </p></li></div>

	  <div id="conclusions">
	    <li><p><strong>Conclusions</strong></p>
	      <p><a href="/conclusion.php">Conclusions</a> that can be drawn
	        from the measurements made in the shootout.</p></li></div>

	  <div id="todo">
	    <li><p><strong>Todo List</strong></p>
	      <p>The shootout is a work in progress.  There is always
	        <a href="/todo.php">more to do</a>.</p></li></div>
	</ul>

	<div id="links">
	<h3>Interesting Links</h3>
	<p>If you enjoy benchmarks, the following links might be of interest
	to you:</p>
	<ul>
	  <p class="infomark"><a href="http://www.dadgum.com/james/shootout.html">
	    Erlang and the Great Computer Language Shootout</a>:  Here
	    the author makes some valid comments about the Shootout
	    benchmarks, and provides some better-performing implementations.
	    Most of his comments have been incorporated into the shootout.</p>
	  <p class="infomark"><a href="http://www.lissett.com/ben/bench1.htm">
	    OO Richards Bench</a>:  Object-oriented version of the Richards
	    benchmark.</p>
	  <p class="infomark">The <a href="http://merd.sourceforge.net/pixel/language-study/scripting-language/">
	    Scriptometer</a> tries to measure whether a programming language
	    is suitable for Script-Oriented Programming</p>
	  <p class="infomark">The <a href="http://scutigena.sourceforge.net">
	    Scutigena</a> project is like the Shootout, and would have been a
	    good thing to get involved with if I had known about it
	    before-hand!  :-)</p>
	  <p class="infomark">Keith Lea used some of the shootout benchmarks to
	    show that <a href="http://kano.net/javabench">Java is Faster than
	    C++</a>.  My own SableVM and GIJ tests don't bear this out, but
	    perhaps using Sun's JVM would make a difference...</li>
	  <!-- busted link
	  <p class="infomark"><a href="http://wwwipd.ira.uka.de/~prechelt/Biblio/jccpprt_computer2000.ps.gz">An empirical comparison of C, C++, Java, Perl, Python, Rexx, and Tcl for a search/string-processing program</a> by Lutz Prechelt (gzipped Postscript).</p> -->
	  <p class="infomark">A Comparison of Programming Languages for Scientific Processing by D. McClain <small>Unfortunately, this reference is no longer available.</small></p>
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
