<?   // Copyright (c) Isaac Gouy 2004 ?>


<div>This FAQ is short. You can read it really quickly.</div>




<!-- WHERE CAN I? ////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Where can I&#133;?</h3></td></tr>


<tr class="b"><td>Where can I send <b>suggestions</b> and comments and programs?</td></tr>

<tr><td><p>You can <a href="http://alioth.debian.org/sendmessage.php?touser=1230">send suggestions and comments</a>, or you can <a href="miscfile.php?sort=<?=$Sort;?>&file=mailinglist&title=mailing list">post email directly to the <b>mailing list</b></a>.</p></td></tr>



<tr class="b"><td>Where can I see more languages?</td></tr>
<tr><td>

<p>For clarity, just one or two implementations of the same language are shown on:
<ul>
<li> <a class="arevMain" href="<?=MAIN_SITE;?>index.php?sort=<?=$Sort;?>" >The Great Computer Language Shootout</a>
<p>Main language implementations.</p>
</li>
</ul>
</p>


<p>More languages and language implementations are shown on: 
<ul>
<li><a class="arevGreater" href="<?=GREATER_SITE;?>index.php?sort=<?=$Sort;?>" >The Greater Computer Language Shootout</a>
<p>Languages with a decent number of completed benchmark programs.</p>
</li>

<li><a class="arevDev" href="<?=DEV_SITE;?>index.php?sort=<?=$Sort;?>" >The DEV Computer Language Shootout</a>
<p>Languages which only have a few completed benchmark programs, and benchmarks that are still under development.</p>
</li>

</ul>
</p>


<tr class="b"><td>Where can I download the <b>data</b> from?</td></tr>

<tr><td><p>You can <b>download</b> a <a href="miscfile.php?sort=<?=$Sort;?>&file=download&title=Download data">zip file of timings and memory use ~100KB</a>.</p></td></tr>



<tr class="b"><td>Where can I see what other people think about the Language Shootout?</td></tr>

<tr><td><p>You can start by reading the <a href="miscfile.php?sort=<?=$Sort;?>&file=mailinglist&title=mailing list">mailing list archives.</a></p></td></tr>



<tr class="b"><td>Where can I download the program sources and build scripts?</td></tr>

<tr><td><p>You can browse the CVS tree on <a href="http://alioth.debian.org/projects/shootout">Alioth&nbsp;Debian.org</a>.
</td></tr>

<tr><td><p>You can <b>download</b> all the program sources and builds scripts as a <a href="miscfile.php?sort=<?=$Sort;?>&file=download&title=Download Tarball">
compressed tarball ~1.5MB</a>. The current distribution is only suitable for the adventurous.
</p></td></tr>


<tr class="b"><td>Where can I find out more?</td></tr>

<tr><td><p>The <b>project is hosted</b> by <a href="http://alioth.debian.org/projects/shootout"><b>Alioth&nbsp;Debian.org</b></a>.
</p></td></tr>

</table>




<!-- WHAT DOES ... MEAN? /////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;What does &#133; mean?</h3></td></tr>



<tr class="b"><td><a name="fullcpu">What does Full CPU Time mean?</a></td></tr>

<tr><td>
<p>The Full CPU Time includes program <b>startup time</b>. You can see how startup time varies between languages from the <a href="benchmark.php?test=hello&lang=all&sort=<?=$Sort;?>">startup benchmark</a> programs.</p>
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
"Are hash table update operations faster in Tcl or Ruby?". For example the <a href="benchmark.php?test=sieve&lang=all&sort=<?=$Sort;?>">primes</a> programs.</p>
<p>The same way programs often seem naive and unidiomatic.       
</td></tr>



<tr class="b"><td><a name="samething">How should I implement a same thing program?</a></td></tr>

<tr><td><p>Use whatever algorithm and data structure you like, within the stated constraints. We may
specify that the problem has to be solved in constant space, or that reads can be no larger than 4K, or ...
</p><p>The <b>same thing</b> programs aim to answer questions like "Is it faster to write a word frequency counter in Perl or Bash?".
For example the <a href="benchmark.php?test=wordfreq&lang=all&sort=<?=$Sort;?>">word-frequency</a> programs.</p>
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

<tr><td><p>Each program was run as a child-process of a Perl script. The script waits for the child-process to exit and takes usr+sys times with (<a href="http://packages.debian.org/stable/interpreters/libbsd-resource-perl">BSD::Resource::times</a>)[2,3].</p>
<p>The Full CPU time includes program <b>startup time</b>. You can see how startup time varies between languages from the <a href="benchmark.php?test=hello&lang=all&sort=<?=$Sort;?>">startup benchmark</a> programs.</p><p>
Each program was run once pre-test to reduce cache effects. Each program was then run 3 times. We show the lowest measured CPU time and the highest memory usage, from the 3 runs.
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



<tr class="b"><td>Why don't you include Mono C#?</td></tr>

<tr><td><p>Mono has a buglet which makes the <a href="http://lists.ximian.com/archives/public/mono-devel-list/2004-September/007766.html">CPU times unreliable</a>.</p></td></tr>



<tr class="b"><td>Why don't you include my favourite language?</td></tr>

<tr><td><p>Maybe we will when you write 15 of the benchmark programs in your favourite language, and contribute them to "The Great Computer Language Shootout" :-)</p></td></tr>



<tr class="b"><td>What kind of programming languages will you accept?</td></tr>

<tr><td><p>Programming languages that can be used to write most of our benchmark programs!</p><p> 
<ol><b>Must have</b>
<li>A <a href="http://www.debian.org">Debian package</a> (either from Debian itself, or the primary authors of the language.)
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
<p>We will accept and reject languages in a capricious, unfair, biased fashion :-)</p>
</td></tr>


</table>




<!-- WHO? /////////////////////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Who&#133;?</h3></td></tr>



<tr class="b"><td>Who started "The Great Computer Language Shootout"?</td></tr>

<tr><td><p>Doug Bagley created "The Great Computer Language Shootout"</p><p>Aldo Calpini ported that to create <a href="http://dada.perl.it/shootout/">"The Great Win32 Computer Language Shootout"</a></p><p>Brent Fulgham revived "The Great Computer Language Shootout" here on <a href="http://alioth.debian.org/projects/shootout">Alioth&nbsp;Debian.org</a></p></td></tr>


<tr class="b"><td>Who has contributed?</td></tr>

<tr><td><p>So many people that we have an <a href="miscfile.php?sort=<?=$Sort;?>&file=acknowledgements&title=acknowledgements">acknowledgements page</a>!</p></td></tr>


</table>





<!-- WHY? /////////////////////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev">&nbsp;Why&#133;?</h3></td></tr>



<tr class="b"><td>Why are you doing this?</td></tr>

<tr><td><p>To learn and to <b>have fun</b>.</p><p>We will continue as long as the fun holds out.</p></td></tr>


</table>


