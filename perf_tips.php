<!--#set var="TITLE" value="Computer Language Performance Tips" -->
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
      <div id="apphead"><h2>Speeding Up Your Programs</h2></div>
      <div class="app">
      <p>The point of this page is mostly to document tips I've been made
      aware of for speeding up programs in various languages.  I've moved
      the language specific hints to the <a href="lang/">language summary
      pages</a>.  This page now just contains the general hints.</p>
      <h3>General Hints for better performance</h3>
      <ul>
        <li>If you play really loud music, your programs will run faster and
	  have fewer bugs.  (Ha ha, just kidding :-).</li>
	<li>Find the compiler switches to turn on optimization, if available.
	  With gcc (and many C compilers) -O2 will do maximal code optimization
	  short of making space/speed tradeoffs.</li>
	<li>Find whatever tools your language provides for profiling, and use
	  them to get a feel for where things are slow.</li>
	<li>Avoid system calls whenever possible.  Move them outside of loops
	  whenever possible.</li>
	<li>Use call by reference instead of call by value, unless you are
	  passing fairly small data structures.</li>
	<li>Avoid passing long argument lists to functions/subroutines.  Keep
	  your argument lists short.</li>
	<li>Avoid memory to memory copys, but prefer them to doing extra system
	  calls for small/moderate amounts of memory.</li>
	<li>For object oriented languages, avoid instantiating objects inside
	  loops.  This can cause a lot of memory copies and garbage collection.</li>
	<li>Avoid reading/writing files line by line (or even character by
	  character), instead read them into a buffer (4K-16K should be
	  sufficient).  Some languages provide facilities to make this easy,
	  some don't.</li>
	<li>Hoist loop invariants out of loops.</li>
	<li>Find out if there is a builtin function that does what you need.
	  Implementing the equivalent in the language itself is bound to be
	  slower.  For example, most scripting languages allow you to copy an
	  aggregate data structure in one statement, implementing this on your
	  own by looping over the structure would be a waste of time.</li>
	<li>For scripting languages, learn how to extend them in C.</li>
	<li>Get to know your language!  These points and many more are well
	  documented for many languages, and I can only present a few of the
	  salient issues here.</li>
      </ul>
    </td>
  </tr>
</table>

<?php require("html/footer.php") ?>
