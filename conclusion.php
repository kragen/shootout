<!--#set var="KEYWORDS" value="performance, benchmark, computer,
algorithms, languages, compare, cpu, memory" --> 
<?php $title="Computer Language Shootout Conclusion";
      require("html/header.php");
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
      <div id="apphead"><h2>Conclusion</h2></div>
      <div class="app">
<p>After comparing all these languages, I have come to the conclusion
  that the best musical instrument is the <a
  href="http://www.brave.com/bo/scrapbook/photogallery/2001pix.htm">accordian</a>!
  Everybody Polka!</p>

<p>No, really, <i><b>there is no conclusion!</b></i></p>

<p>This is a work in progress.  I'm still far more concerned with
  learning and having fun than reaching a conclusive result.  I
  put it on the web because I thought it would interest others.
  Even though I put disclaimers on the page, and I try not to
  make any claims, I see some people say the shootout shows that
  &quot;language X is faster than language Y&quot;.</p>

<p>That claim is probably premature and hence, bogus.  I suppose you
  could make the claim that, in &quot;Doug's word frequency test, on
  a PII-450 running Linux 2.4, given a certain input, language X is
  faster than language Y&quot; Assuming, of course, that I haven't
  made any mistakes.  Some of my tests are also arguably poorly
  designed and meaningless.  (Hey, if you have some better ideas,
  please write to me).</p>

<p>Benchmarks are notoriously misleading, and perhaps mine aren't any
  better, although I do try.  Benchmarks tell you about results in a
  very specific case.  Drawing a general conclusion is problematic.</p>

<p>If you feel you must draw a conclusion, you should also ask yourself
  what it really means ... after all if performance were the only
  criteria for choosing a language, we'd all be programming in pure
  assembler.  It's best to keep it all in perspective.  Programmer
  efficiency is usually much more important, and I do not even try to
  measure that.</p>

<p>I just want to emphasize that I'm not making any claims based on
  these pages, and if you do, it is at your own peril.  For instance,
  when I fixed some bugs in my memory sampling method, many of the
  memory scores came out completely differently.  It could happen
  again.</p>

<p>There is no conclusion because you are basically looking at my lab
  notes, not a completed research project.</p>

<p>Sure, I hope that eventually I'll have a nice conclusion posted
  here.  Or at least confirmation that the tests are valid, and make a
  decent benchmark to discriminate between languages.  But even then,
  the most we'll be able to talk about are speed, memory and code
  size.  These are not necessarily the most important factors when
  choosing a language.  If I had x86 assembler as a language entry, it
  would most likely win in the speed and memory categories, but would
  you use it to write a complex application?</p>

    </div></div>
    </td>
  </tr>
</table>
<?php require("html/footer.php"); ?>
