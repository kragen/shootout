<!--#set var="TITLE" value="Producer/Consumer Threads" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory, producer consumer,
producer/consumer, threads, mutex, condition variable" --> 

<?php require("../../html/testtop.php"); ?>

<h4>About this test</h4>
<p>
  <b>Please Note:</b> this test is due for an overhaul, so that
  languages that use kernel threads are not penalized (as noted
  below).
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.
<p>
  This is a test of thread synchronization using a simple threaded
  Producer/Consumer synchronized by a mutex and a condition variable.
  Each test should be implemented using pre-emptive threads, preferably
  Linux Kernel Threads.


<p>
<table border="0" bgcolor="#c0e0e0" align="center" width="50%">
<tr><th align="center">(partial) pseudocode for threaded producer/consumer test</th></tr>
<tr><td><pre><br>

 producer thread:
   for i = 1 through n:
     lock mutex to enter critical section
     while count not equal zero wait for condition variable
     put value of i into data buffer
     increment count
     signal condition that resource is ready (data buffer full)
     increment produced

 consumer thread:
   repeat: 
     lock mutex to enter critical section
     while count equal zero wait for condition variable
     retrieve value of i from data buffer
     decrement count
     signal condition that resource is ready (data buffer empty)
     increment consumed

 main thread:
   start producer
   start consumer
   join threads
   print values of produced and consumed

</pre></td></tr><tr><td>
</td></tr></table>


<h4>Observations</h4>
<p>
  Haskell and MLton appear to be so much faster because they do not
  use Linux kernel threads, which are fairly heavyweight when doing
  things like switching thread context.
<p>
  Most of the compiled languages here allow you to build threaded
  applications by linking to thread-safe libraries.  Some of the
  interpreted languages allow you to build threaded and unthreaded
  apps easily.  With Perl, though, you must build a separate threaded
  version of Perl.  So for this test, I use a special version of Perl
  that I have built with threading enabled, and for all the
  non-threaded tests, I use a regular old Perl built without threads.

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<li>
  Brad Knotwell contributed a <a href="alt/prodcons.python2.python">Python
  program</a> that uses Python's synchronized Queue class.  This
  solution is significantly faster, but it isn't really doing the same
  thing as the others.  Other languages offer thread-safe synchronized
  Queues too (e.g. Perl's Thread::Queue).
<li>
  Bernd Paysan submitted forth entries for <a
  href="alt/prodcons.bigforth2.bigforth">bigforth</a> and <a
  href="alt/prodcons.gforth2.gforth">gforth</a> that use Forth's
  cooperative tasker.  These programs don't need a mutex because they
  aren't pre-emptive.
<li>
  Cheyenne Wills contributed a producer/consumer <a
  href="alt/prodcons.icon2.icon">example</a> using Icon's co-routine feature.
</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->

