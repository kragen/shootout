<?   // Copyright (c) Isaac Gouy 2004 ?>


<div>This FAQ is short. You can read it really quickly.</div>




<!-- WHERE CAN I? ////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Where can I&#133;?</h3></td></tr>


<tr class="b"><td>Where can I send <b>suggestions</b> and comments and programs?</td></tr>

<tr><td><p>You can send suggestions and comments without subscribing to the mailing list - <a href="http://alioth.debian.org/sendmessage.php?touser=1230" title="Send your suggestion or comment without subscribing to the mailing list">use the <b>message form</b></a>.

 You can contribute faster more-elegant programs - send them, and your suggestions, to the <a href="miscfile.php?sort=<?=$Sort;?>&file=mailinglist&title=mailing list" title="Mailing list archives, posting and subscription"><b>mailing list</b></a>.</p></td></tr>



<tr class="b"><td>Where can I see more?</td></tr>
<tr><td>
<p>You can look at our other Shootout websites - </p>


<p><a class="arevGreat" href="<?=GREAT_SITE;?>index.php?sort=<?=$Sort;?>" >The Great Computer Language Shootout</a> includes programming language implementations that have more than a few completed benchmark programs.
</p>

<p><a class="arevSandbox" href="<?=SANDBOX_SITE;?>index.php?sort=<?=$Sort;?>" >The Sandbox</a> includes programming languages that only have a few completed benchmark programs, some really obscure programming languages; and some new benchmarks we're developing.
</p>

<p><a class="arevCore" href="<?=CORE_SITE;?>index.php?sort=<?=$Sort;?>" >The Computer Language Shootout</a> includes a smaller selection of programming languages. 
</p>

<tr class="b"><td>Where can I download the <b>data</b> from?</td></tr>

<tr><td><p>You can <b>download</b> a <a href="miscfile.php?sort=<?=$Sort;?>&file=download&title=Download data" title="Not yet available">zip file of timings and memory use ~100KB</a>.</p></td></tr>



<tr class="b"><td>Where can I see what other people think about the Language Shootout?</td></tr>

<tr><td><p>You can start by reading the <a href="miscfile.php?sort=<?=$Sort;?>&file=mailinglist&title=mailing list" title="Mailing list archives, posting and subscription">mailing list archives.</a></p></td></tr>



<tr class="b"><td>Where can I download the program sources and build scripts?</td></tr>

<tr><td><p>You can browse the CVS tree on <a href="http://alioth.debian.org/projects/shootout"  title="The Great Computer Language Shootout project page on Alioth at Debian.org">Alioth&nbsp;Debian.org</a>.
</td></tr>

<tr><td><p>You can <b>download</b> all the program sources and builds scripts as a <a href="miscfile.php?sort=<?=$Sort;?>&file=download&title=Download Tarball" title="Not yet available">
compressed tarball ~1.5MB</a>. The current distribution is only suitable for the adventurous.
</p></td></tr>


<tr class="b"><td>Where can I find out more?</td></tr>

<tr><td><p>The <b>project is hosted</b> by <a href="http://alioth.debian.org/projects/shootout"  title="The Great Computer Language Shootout project page on Alioth at Debian.org">Alioth&nbsp;Debian.org</a>.
</p></td></tr>

<tr><td><p>You could learn about <a href="miscfile.php?sort=<?=$Sort;?>&file=benchmarking&title=benchmarking" title="Benchmarking suites and language comparison links"><b>benchmarking</b></a>.
</p></td></tr>



</table>




<!-- WHAT DOES ... MEAN? /////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;What does &#133; mean?</h3></td></tr>



<tr class="b"><td><a name="fullcpu">What does Full CPU Time mean?</a></td></tr>

<tr><td>
<p>Full CPU Time means <b>program run-time</b> including program <b>startup time</b>. So for Java that includes the time to startup a JVM.</p>


<p>You can see how startup time varies between languages from the <a href="benchmark.php?test=hello&lang=all&sort=<?=$Sort;?>" title="Compare performance on the startup benchmark">startup benchmark</a> programs.</p>
<p>(Flaw #1 - normally we'd time a specific block of code within a program, and exclude startup time.)</p>
</td></tr>




<tr class="b"><td><a name="cpu">What does CPU Time mean?</a></td></tr>

<tr><td><p>The CPU Time is the measured CPU time minus the average program startup time for the language.</p></td></tr>


</table>



<!-- HOW SHOULD I IMPLEMENT ...? /////////////////////////////////////// -->


<table class="div">
<tr><td><h3 class="rev">&nbsp;How should I implement&#133;?</h3></td></tr>


<tr class="b"><td><a name="sameway">How should I implement a same way program?</a></td></tr>

<tr><td><p>Use the same algorithm and data structures. As-far-as possible the languages should be doing the same operations.
</p><p>The <b>same way</b> programs aim to answer questions like "Is array subscripting faster in Perl or Python?" and 
"Are hash table update operations faster in Tcl or Ruby?". For example the <a href="benchmark.php?test=sieve&lang=all&sort=<?=$Sort;?>" title="Compare performance on the primes benchmark">primes</a> programs.</p>
<p>The same way programs often seem naive and unidiomatic.</p> 


<p>(Flaw #2 - we'd like to compare apples & apples, but normally we'd solve problems using different approaches depending on the language.)</p>      
</td></tr>



<tr class="b"><td><a name="samething">How should I implement a same thing program?</a></td></tr>

<tr><td><p>Use whatever algorithm and data structure you like, within the stated constraints. We may
specify that the problem has to be solved in constant space, or that reads can be no larger than 4K, or ...
</p><p>The <b>same thing</b> programs aim to answer questions like "Is it faster to write a word frequency counter in Perl or Bash?".
For example the <a href="benchmark.php?test=wordfreq&lang=all&sort=<?=$Sort;?>" title="Compare performance on the word-frequency benchmark">word-frequency</a> programs.</p>
<p>The same thing programs are free to use the most appropriate, idiomatic code for a solution.       
</td></tr>



<tr class="b"><td><a name="samething">How should I implement&#133;?</a></td></tr>

<tr><td><p>
<ol>
<li>Keep to the spirit-of-the-specification not just the wording.</li><li>Write the program to be as-fast-as possible.</li><li>Write the program to conserve memory as-much-as possible.</li>
<li>Write the program as-if lines of code were not being measured.</li>
</ol>     
</p></td></tr>


</table>




<!-- HOW DID YOU MEASURE...? /////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;How did you measure&#133;?</h3></td></tr>


<tr class="b"><td>How did you measure <b>CPU time?</b></td></tr>

<tr><td><p>Each program was run as a child-process of a Perl script. The script waits for the child-process to exit and takes usr+sys times with (<a href="http://packages.debian.org/stable/interpreters/libbsd-resource-perl" title="Debian package 'perl BSD::Resource - BSD process resource limit and priority'">BSD::Resource::times</a>)[2,3].</p>
<p>The Full CPU time includes program <b>startup time</b>. You can see how startup time varies between languages from the <a href="benchmark.php?test=hello&lang=all&sort=<?=$Sort;?>" title="Compare performance on the startup benchmark">startup benchmark</a> programs.</p><p>
Each program was run once pre-test to reduce cache effects. Each program was then run 3 times. We show the lowest measured CPU time and the highest memory usage, from the 3 runs.</p>

</td></tr>



<tr class="b"><td><a name="memory">How did you measure <b>memory usage?</b></a></td></tr>

<tr><td><p>In a very approximate and unreliable way. We sampled the child-process resident memory size (VmRSS) multiple times a second. We identified the main thread by checking for SIGCHLD being registered as the exit_signal in the second to last field of /proc/{pid}/stat.</p>
<p>There's a race condition. When the program completes quickly, this sampling technique will fail.       
</td></tr>



<tr class="b"><td><a name="codelines">How did you measure <b>lines-of-code?</b></a></td></tr>

<tr><td><p>In a haphazard and approximate way - blank lines and comments were removed, and then we counted the lines that remain.</p><p>
We reserve the right to format the code entries as we see fit, whatever the lines-of-code count may be. 
</td></tr>



<tr class="b"><td>What machine are you running the programs on?</td></tr>

<tr><td><p>The current <b>test machine</b> is a single-processor 1.1 Ghz AMD Athlon machine with 256 MB of RAM and a 20GB IDE disk drive.</p></td></tr>




<tr class="b"><td>What OS are you using on the test machine?</td></tr>

<tr><td><p>Debian 'unstable', Kernel 2.6.8-1-k7</p></td></tr>


</table>




<!-- WHY DON"T YOU INCLUDE...? /////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Why don't you include&#133;?</h3></td></tr>



<tr class="b"><td>Why don't you include REBOL&#153;?</td></tr>

<tr><td><p>REBOL&#153; is a commercial product.<p></td></tr>



<tr class="b"><td>Why don't you include my favourite language?</td></tr>

<tr><td><p>Maybe we will when you write 15 of the benchmark programs in your favourite language, and contribute them to "The Great Computer Language Shootout" :-)</p></td></tr>



<tr class="b"><td>What kind of programming languages will you accept?</td></tr>

<tr><td><p>Programming languages that can be used to write most of our benchmark programs!</p><p> 
<ol><b>Must have</b>
<li>A <a href="http://www.debian.org" title="The Debian.org website">Debian package</a> (either from Debian itself, or the primary authors of the language.)
</br>Or build and install with <code>./configure && make && make install</code> and a default target of <code>/usr/local.</code></li>
<li>Documentation.</li>
<li>Command-line argument handling.</li>
<li>32-bit Integers.</li>
<li>Double precision floating point numbers.</li>
<li>Dynamic hash tables and sequences (arrays or lists).</li>
<li>Line-oriented read & write from stdin & stdout.</li>
</ol>
<ol><b>Should have</b>
<li>Buffered stdio.</li>
<li>Exception handling.</li>
<li>Regular Expressions (preferably Perl compatible).</li>
<li>Concurrency (threads, coroutines, &#133;)</li>
<li>TCP/IP Sockets.</li>
<li>Object-oriented programming features.</li>
</ol>
</p></td></tr>


</table>




<!-- PLEASE WILL YOU INCLUDE...? /////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Please will you include&#133;?</h3></td></tr>



<tr class="b"><td>Please will you include my favourite language?</td></tr>

<tr><td><p>Is the language &#133;<ol>
<li><b>Free?</b> The hope is that people who come across the shootout
will be motivated to learn a new language, and since the barriers
to learning a new language are far lower for a free implementation,
those are the prefered languages for display.  While commercial
languages are not officially disqualified, there do not
seem to be many compelling reasons to include them.</li>
<li><b>Open source?</b>  Programming languages should
be open source.  As language users, when we find a problem but do
not have access to the source code it is very frustrating.  If
you have ever had to maintain production software for a compiler
that is no longer available from a vendor, with no available bug
fixes, you will soon understand this requirement.</li>
<li><b>Used?</b> There are way too many dead languages and unused project languages.</li>
<li><b>Interesting?</b> Is there something significant and interesting about the language that will be obvious from these benchmark programs?</li>
</ol></p>
<p>We will accept <b>and reject</b> languages in a capricious, unfair, biased fashion :-)</p>
</td></tr>


</table>



<!-- WHEN? /////////////////////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;When&#133;?</h3></td></tr>

<tr class="b"><td>When will the Language Shootout be finished?</td></tr>

<tr><td><p>There will always be new languages, new implementations of old languages, more sensible benchmarks, faster more-elegant programs, new operating systems, better graphics&#133;</p>

<p>The Computer Language Shootout will never be finished - the project team will change over time, and the measurements and presentation will change with them.</p>

</td></tr>



</table>



<!-- WHO? /////////////////////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Who&#133;?</h3></td></tr>



<tr class="b"><td>Who started "The Great Computer Language Shootout"?</td></tr>

<tr><td><p>Doug Bagley created "The Great Computer Language Shootout", and it was active until 2001.</p><p>Aldo Calpini ported that to create <a href="http://dada.perl.it/shootout/" title="The Computer Language Shootout for MS Windows programming languages">"The Great Win32 Computer Language Shootout"</a> - it was last updated June 2003.</p><p>In mid-2004 (here on Alioth&nbsp;Debian.org) Brent Fulgham revived the <a class="arevOld" href="<?=OLD_SITE;?>index.php?sort=<?=$Sort;?>" >Old Great Computer Language Shootout</a>.</p><p>Then things really started to change. First, the <a href="<?=CORE_SITE;?>index.php?sort=<?=$Sort;?>" >website was redesigned</a>. Then some benchmarks were deprecated. Then all kinds of new benchmarks were added.</p><p>Who knows where it will end?</p></td></tr>


<tr class="b"><td>Who has contributed?</td></tr>

<tr><td><p>So many people that we have an <a href="miscfile.php?sort=<?=$Sort;?>&file=acknowledgements&title=acknowledgements" title="Acknowledgements to those who have contributed to The Great Computer Language Shootout">acknowledgements page</a>!</p></td></tr>


</table>





<!-- WHY? /////////////////////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Why&#133;?</h3></td></tr>



<tr class="b"><td>Why are you doing this?</td></tr>

<tr><td><p>To learn and to <b>have fun</b>.</p><p>We will continue as long as the fun holds out.</p></td></tr>


</table>


