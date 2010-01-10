<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<p class="timestamp"><? printf('%s GMT', gmdate("d M Y, l, g:i a", $Changed)) ?></p>

<dl>
<dt><a href="#compare" name="compare">&nbsp;How to compare these programming language measurements</a></dt>
<dd>
<dl> 

<dd>
<p>There are 4 sets of up-to-date measurements. Measurements for different OS/machine combinations are shown on different color-coded pages.</p>
</dd>

<dt><a href="#several" name="several">Compare performance for <b>3 or 4 <i>or more</i> programming languages</b></a></dt>
<dd>
<p>Example <span class="u32q"><a
href="./u32q/which-programming-languages-are-fastest.php?calc=calculate&amp;gpp=on&amp;gcc=on&amp;java=on&amp;javaxint=on&amp;jruby=on" title="Which programming languages are fastest?">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span> select <a href="./u32q/which-programming-languages-are-fastest.php?calc=calculate&amp;gpp=on&amp;gcc=on&amp;java=on&amp;javaxint=on&amp;jruby=on" title="Which programming languages are fastest?">all benchmarks</a> select <a href="./u32q/which-programming-languages-are-fastest.php?calc=calculate&amp;gpp=on&amp;gcc=on&amp;java=on&amp;javaxint=on&amp;jruby=on" title="Which programming languages are fastest?">all languages</a> in the drop-down menus.</p>
</dd>

<dt><a href="#onebenchmark" name="onebenchmark">Compare the performance of <b>all the programs for one benchmark</b></a></dt>
<dd>
<p>Example <span class="u64q"><a
href="./u64q/benchmark.php?test=spectralnorm&amp;lang=all" title="Compare programs that calculate an eigenvalue using the power method">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span> select <a href="./u64q/benchmark.php?test=spectralnorm&amp;lang=all" title="Compare programs that calculate an eigenvalue using the power method">spectral-norm</a> select <a href="./u64q/benchmark.php?test=spectralnorm&amp;lang=all" title="Compare programs that calculate an eigenvalue using the power method">all languages</a> in the drop-down menus.</p>
</dd>

<dt><a href="#comparetwo" name="comparetwo">Compare program speed and size for <b>2 language implementations</b></a></dt>
<dd>
<p>Example <span class="u64"><a
href="./u64/benchmark.php?test=all&amp;lang=java" title="Compare the speed and size of Java 6 -server programs against C++ GNU g++ programs">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one core&nbsp;</a></span> select <a href="./u64/benchmark.php?test=all&amp;lang=java" title="Compare the speed and size of Java 6 -server programs against C++ GNU g++ programs">all benchmarks</a> select <a href="./u64/benchmark.php?test=all&amp;lang=java" title="Compare the speed and size of Java 6 -server programs against C++ GNU g++ programs">Java -6 server</a> in the drop-down menus.</p>
<p>Example <span class="u32"><a
href="./u32/benchmark.php?test=all&amp;lang=java&amp;lang2=python" title="Compare the speed and size of Java 6 -server programs against Python CPython programs.">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one core&nbsp;</a></span> select <a href="./u32/benchmark.php?test=all&amp;lang=java&amp;lang2=python" title="Compare the speed and size of Java 6 -server programs against Python CPython programs">all benchmarks</a> select <a href="./u32/benchmark.php?test=all&amp;lang=java&amp;lang2=python" title="Compare the speed and size of Java 6 -server programs against Python CPython programs">Java -6 server</a> select <a href="./u64/benchmark.php?test=all&amp;lang=java&amp;lang2=python" title="Compare the speed and size of Java 6 -server programs against Python CPython programs">Python CPython</a> in the drop-down menus.</p>
</dd>

<dt><a href="#measurements" name="measurements">Compare measurements of <b>all the programs for one language</b></a></dt>
<dd>
<p>Example select <a href="./u64/measurements.php?lang=java" title="Compare performance measurements of all the accepted Java 6 -server programs">Java -6 server</a> in the drop-down menu.</p>
</dd>

</dl>
</dd>



<dt><a href="#measure" name="measure">&nbsp;How programs were measured</a></dt>
<dd>
<dl>
<dt><a href="#process" name="process">The Process</a></dt>
<dd>
<ol>
<li>Each program was run and measured at the smallest input value, program output redirected to a file and compared to expected output. As long as the output matched expected output, the program was then run and measured at the next larger input value until measurements had been made at every input value.</li>

<li>If the program gave the expected output within an arbitrary cutoff time (now 120 seconds) the program was measured again repeatedly (5 more times) with output redirected to /dev/null.</li>

<li>If the program didn't give the expected output within an arbitrary timeout (usually one hour) the program was forced to quit. If measurements at a smaller input value had been successful within an arbitrary cutoff time (now 120 seconds), the program was measured again repeatedly (5 more times) at that smaller input value, with output redirected to /dev/null.</li>

<li>The measurements shown on the website are either
<ul><li>within the arbitrary cutoff - the lowest time and highest memory use from repeated measurements</li>
<li>outside the arbitrary cutoff - the sole time and memory use measurement</li></ul></li>

<li>For sure, programs taking 4 and 5 hours were only measured once!</li>
</ol>
</dd>

<dt><a href="#time" name="time">How did you measure <strong>Time-used?</strong></a></dt>
<dd>
<p>Each program was run as a child-process of a Python script using <a href="http://docs.python.org/library/subprocess.html#popen-objects">Popen</a>.</p>
<ul>
<li><b>CPU&nbsp;secs</b>: The script child-process usr+sys rusage time was taken using <a href="http://docs.python.org/library/os.html?highlight=os.wait3#os.wait3">os.wait3</a><br /></li>
<li><b>Elapsed&nbsp;secs</b>: The time was taken before forking the child-process and after the child-process exits, using <a href="http://docs.python.org/library/time.html?highlight=time.time#time.time">time.time()</a></li>
</ul>
<p><strong>Time measurements include program startup time.</strong></p>
</dd>

<dt><a href="#memory" name="memory">How did you measure <strong>Memory-used?</strong></a></dt>
<dd><p>By sampling GTop proc_mem for the program and it's child processes every 0.2 seconds. Obviously those measurements are unlikely to be reliable for programs that run for less than 0.2 seconds.</p>
</dd>

<dt><a href="#gzbytes" name="gzbytes">How did you measure <strong>Code-used?</strong></a></dt>
<dd><p>We started with the source-code markup you can see, removed comments, removed duplicate whitespace characters, and then applied minimum GZip compression. The Code-used measurement is the size in bytes of that GZip compressed source-code file.</p>
</dd>

<dt><a href="#cpuload" name="cpuload">How did you measure <b>&asymp; CPU Load?</b></a></dt>
<dd><p>The GTop cpu idle and GTop cpu total was taken before forking the child-process and after the child-process exits, The percentages represent the proportion of cpu not-idle to cpu total for each core.</p>
</dd>

</dl>
</dd>


<dt><a href="#contribute" name="contribute">&nbsp;How to contribute programs</a></dt>
<dd>
<dl>

<dt><a href="#diff" name="diff">How much effort should I put into getting the program correct?</a></dt>
<dd><p>Do design-iteration on your machine, or in a language newsgroup. Only contribute programs which give correct results on your machine - <b>diff the program output with the provided output file before you contribute the program</b>.</p>
</dd>

<dt><a href="#implement" name="implement">How should I implement programs?</a></dt>
<dd><p>Prefer plain vanilla programs - after all we're trying to compare language implementations not programmer effort and skill. We'd like your programs to be easily viewable - so please format your code to fit in <b>less than 80 columns</b> (we don't measure lines-of-code!).</p>
</dd>

<dt><a href="#input" name="input">How should I implement data-input?</a></dt>
<dd><p>Programs are measured across a range of input-values; programs are expected to either take a single command-line parameter or read text from <b>stdin</b>.</p>
<p>(Look at what the other programs do.)</p>
</dd>

<dt><a href="#output" name="output">How should I implement data-output?</a></dt>
<dd><p>Programs should write to <b>stdout</b>. Program output is redirected to a log-file and diff'd with the expected output.</p>
<p>(Look at what the other programs do.)</p>
</dd>

<dt><a href="#credit" name="credit">How should I identify my program?</a></dt>
<dd><p>Include a header comment in the program like this:</p>
<pre>
/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by &#8230;
   modified by &#8230;
*/
</pre>
</dd>

<dt><a href="#unroll" name="unroll">How should I implement loops?</a></dt>
<dd><p>Don't manually unroll loops!</p></dd>


<dt><a href="#stepbystep" name="stepbystep">Finally! <b>How to contribute programs</b></a></dt>

<dd><p>Attach the full source-code file of a tested program. Please don't paste source-code into the description field. Please don't contribute patch-files.</p>
<p>Before contributing programs</p>
<ul>
<li><b>debian issue their own security certificate</b> - your web browser will complain.</li>
<li>read and accept the <a href="license.php" title="Read the revised BSD license"><b>Revised&nbsp;BSD&nbsp;license</b></a> - all contributed programs are published under this revised BSD license.</li>
<li><a href="http://alioth.debian.org/account/register.php"><b>create an Alioth ID</b></a> and login.</li>
</ul>

<p>Follow these instructions <b>step-by-step</b></p>
<ol>
<li>Start from the bottom. <b>Attach</b> the program source-code file - do this first because it's easy to forget.</li>
<li>Say in the <b>Description</b> how this program fixes an error or is faster or was missing or &#8230; Give us reasons to accept your program.</li>
<li>Each <b>Summary</b> text <em><b>must</b></em> be unique! Follow this convention:<br />
language, benchmark, your-name, date, (version)<br />
<em>Ruby nsieve Glenn Parker 2005-03-28</em><br />
</li>
<li><b>Category</b>: select the language implementation</li>
<li><b>Group</b>: select the benchmark</li>
<li>click the Submit button</li>
</ol>

<p>Now <b>start from the bottom</b> of the
   <a href="https://alioth.debian.org/tracker/?atid=413100&amp;group_id=30402&amp;func=browse"  title="Play the Benchmarks Game - Submit New">
   <b>"Play the Benchmarks Game" Submit-New</b></a> form and work your way up.
</p>
</dd>

<dt><a href="#track" name="track">How can I track what happens to the program I contributed?</a></dt>
<dd>

<p>You created an <a href="#aliothid">&darr;&nbsp;Alioth ID</a> with a valid email address so you'll receive email updates when your program is accepted and measured.</p>
</dd>

<dt><a href="#reportbugs" name="reportbugs">Where can I report bugs&#8230; request features?</a></dt>
<dd>
<p>Tell us about content mistakes, inconsistencies, bad installs <em>etc</em></p>
<p>Please <a href="http://alioth.debian.org/account/register.php"><b>create an Alioth ID</b></a>, login and <a href="https://alioth.debian.org/tracker/?atid=411002&amp;group_id=30402&amp;func=browse"><b>Report a Bug</b></a>.</p>
<p>Tell us about the latest language updates <em>etc</em> - add a <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><b>Feature Request</b></a>.</p>
<p>(<b>debian issue their own security certificate</b> - your web browser will complain.)</p>
</dd>

</dl>
</dd>


<dt><a href="#gloss" name="gloss">&nbsp;What does &#8230; mean?</a></dt>
<dd>
<dl>

<dt><a href="#inputvalue" name="inputvalue">What does N mean?</a></dt>
<dd><p>N means the value passed to the program on the command-line (or the value used to create the data file passed to the program on stdin). Larger N causes the program to do more work - mostly measurements are shown for the largest N, the largest workload.</p>
<p>Read <a href="#measure">&darr;&nbsp;How programs were measured</a></p>
</dd>

<dt><a href="#cpuloadpercent" name="cpuloadpercent">What does '27% 34% 28% 67%' &asymp; CPU Load mean?</a></dt>
<dd><p>When the program was being measured: the first core was not-idle about 27% of the time, the second core was not-idle about 34% of the time, the third core was not-idle about 28% of the time, the fourth core was not-idle about 67% of the time.</p>
<p>When <em>all the programs</em> show &asymp; CPU Load like this '0% 0% 0% 100%' you are probably looking at measurements of programs forced to use just one core - the fourth core (rather than being allowed to use any or all of the CPU cores).</p>
<p>Read <a href="#cpuload">&darr;&nbsp;How did you measure &asymp; CPU Load?</a></p>
</dd>

<dt><a href="#alternative" name="alternative">What does Interesting Alternative Program mean?</a></dt>
<dd><p>Interesting Alternative Program means that the program doesn't implement the benchmark according to the arbitrary and idiosyncratic rules of The Computer Language Benchmarks Game - but we felt like showing the program anyway.</p>
</dd>

<dt><a href="#suffixes" name="suffixes">What do #2 #3 mean?</a></dt>
<dd><p>Nothing - they are arbitrary suffixes that identify a specific program.</p>
</dd>

</dl>
</dd>







<dt><a href="#faqs" name="faqs">&nbsp;FAQs</a></dt>
<dd>
<dl>

<dt><a href="#languagex" name="languagex">Why don't you include language X?</a></dt>
<dd>
<p><b>Why don't you</b> use our measurement scripts and publish measurements for language X?</p>
<p>The Python script "bencher does repeated measurements of program cpu time, elapsed time, resident memory usage, cpu load while a program is running, and summarizes those measurements" - <a href="<?=DOWNLOAD_PATH;?>bencher.tar.bz2"><b>download bencher</b></a> and unpack into your ~ directory and read the license before use.</p>
<p>As an alternative, you should take a look at these Python measurement scripts designed for statistically rigorous Java performance evaluation - <a href="http://www.elis.ugent.be/JavaStats">JavaStats</a></p>
</dd>

<dt><a href="#java" name="java"><b>What about Java</b>?</a></dt>
<dd><p>In these (x86 Ubuntu&#8482; : Intel&#174; Q6600&#174; quad-core) examples we measured elapsed time once the Java program had started: in the first case, we simply started and measured the program 66 times; in the second case, we started the program once and repeated measurements again and again and again 66 times without restarting the JVM; and then discarded the first measurement leaving 65 data points.</p>
<p>The usual startup measurements and the "Java 6 steady state" approximations (and JVM time) are shown alongside for comparison.</p>


<table>
<tr>
<th>"1.6.0_16"&nbsp;</th>
<th colspan="2">&nbsp;started&nbsp;65&nbsp;times&nbsp;</th>
<th colspan="2">&nbsp;repeated&nbsp;65&nbsp;times&nbsp;</th>
<th colspan="3">&nbsp;</th>
</tr>

<tr>
<th>&nbsp;</th>
<th class="num">mean</th>
<th class="num">&#963;</th>
<th class="num">mean</th>
<th class="num">&#963;</th>
<th class="num">&nbsp;&nbsp;usual&nbsp;startup</th>
<th class="num">&nbsp;approx.</th>
<th class="num">&nbsp;JVM&nbsp;time</th>
</tr>

<tr>
<td>meteor&nbsp;contest&nbsp;&nbsp;</td>
<td>0.23s</td>
<td>0.01</td>
<td>0.12s</td>
<td>0.00</td>
<td>0.31s</td>
<td>0.13s</td>
<td>(14&nbsp;sec)</td>
</tr>

<tr>
<td>spectral&nbsp;norm&nbsp;&nbsp;</td>
<td>4.08s</td>
<td>0.23</td>
<td>3.96s</td>
<td>0.02</td>
<td>4.11s</td>
<td>3.96s</td>
<td>(4&nbsp;min)</td>
</tr>

<tr>
<td>pidigits&nbsp;&nbsp;</td>
<td>5.03s</td>
<td>0.14</td>
<td>4.65s</td>
<td>0.10</td>
<td>5.00s</td>
<td>4.55s</td>
<td>(5&nbsp;min)</td>
</tr>

<tr>
<td>fasta&nbsp;&nbsp;</td>
<td>7.50s</td>
<td>0.21</td>
<td>6.91s</td>
<td>0.12</td>
<td>7.51s</td>
<td>-</td>
<td>-</td>
</tr>

<tr>
<td>mandelbrot&nbsp;&nbsp;</td>
<td>11.91s</td>
<td>0.81</td>
<td>11.46s</td>
<td>0.06</td>
<td>10.95s</td>
<td>11.40s</td>
<td>(13&nbsp;min)</td>
</tr>

<tr>
<td>binary&nbsp;trees&nbsp;&nbsp;</td>
<td>20.69s</td>
<td>0.69</td>
<td>15.35s</td>
<td>0.43</td>
<td>19.18s</td>
<td>15.40s</td>
<td>(17&nbsp;min)</td>
</tr>

<tr>
<td>fannkuch&nbsp;&nbsp;</td>
<td>18.74s</td>
<td>0.66</td>
<td>18.56s</td>
<td>0.48</td>
<td>18.43s</td>
<td>18.59s</td>
<td>(20&nbsp;min)</td>
</tr>

<tr>
<td>nbody&nbsp;&nbsp;</td>
<td>24.94s</td>
<td>0.02</td>
<td>25.07s</td>
<td>1.22</td>
<td>25.03s</td>
<td>24.69s</td>
<td>(27&nbsp;min)</td>
</tr>

</table>


<p>Loading Java bytecode, profiling and dynamic compilation do take time but not enough time to make much of a difference in these examples.</p>

<p>The obvious differences show where there is a mismatch between program structure and JVM optimization - even though methods have been fully compiled the JVM continues using the <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr"><b>on-stack-replacement</b></a>. The opportunity to use the fully optimized compiled methods seems only to arise <em>the next time</em> the code block is invoked - whether that's in 10 seconds or 10 days.</p>

<p>To highlight that mismatch, "Java 6 steady state" approximations are shown in the measurement tables alongside the usual startup measurements.</p>
</dd>


<dt><a href="#machine" name="machine">What machine are you running the programs on?</a></dt>
<dd>
<p>We use a <b>quad-core 2.4Ghz Intel<sup>&#174;</sup> Q6600<sup>&#174;</sup></b> machine with 4GB of RAM and 250GB SATA II disk drive.</p>
<p>The out-of-date measurements used a single-processor 2.2Ghz AMD&#8482; Sempron&#8482; machine with 512MB of RAM and 40GB IDE disk drive; and a single-processor 2Ghz Intel<sup>&#174;</sup> Pentium<sup>&#174;</sup> 4 machine with 512MB of RAM and 80GB IDE disk drive.</p>
</dd>

<dt><a href="#os" name="os">What OS are you using on the test machine?</a></dt>
<dd><p>We use <b>Ubuntu&#8482; 9.04 Linux</b> Kernel 2.6.28-17-generic</p>

<p>The out-of-date measurements used Debian Linux 'unstable', Kernel 2.6.18-3-k7 and Gentoo Linux gentoo-sources-2.6.20-r6</p>
</dd>

<dt><a href="#previous" name="previous">Where can I see previous programs?</a></dt>
<dd>
<p>Periodically we go through and remove slower programs from the website (if there's a faster program for the same language implementation). <b>We don't remove those programs from the "Play the Benchmarks Game" tracker.</b></p>
<p>You can see previous programs by browsing though the <a href="http://alioth.debian.org/tracker/?atid=413100&amp;group_id=30402&amp;func=browse"><b>Play the Benchmarks Game tracker items</b></a> and looking at the attached source code files. Log In with your Alioth Id, you will be able to create and save a query to search for particular tracker items.</p>
</dd>

<dt><a href="#contest" name="contest">Why don't you accept every program that gives the correct result?</a></dt>
<dd><p>We are trying to show the performance of various programming language implementations - so we ask that contributed programs not only give the
correct result, but also <b>use the same algorithm</b> to calculate that result.</p>
<p>We do show one contest where you can use different algorithms - <a href="./u64/benchmark.php?test=meteor&amp;lang=all">meteor-contest</a>.</p>
</dd>




<dt><a href="#history" name="history">Why do you continue to show out-of-date measurements?</a></dt>

<dd>
<p><img src="<?=IMAGE_PATH;?>fresh_png_11dec2009.php"
   alt=""
   title=""
   width="400" height="225"
 /></p>
<p>The out-of-date measurements are for many different programming languages. The program source code written in those other programming languages is interesting.</p>
</dd>

<dd>
<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="" href="./gp4/benchmark.php?test=nbody&amp;lang=all">mid 2008</a></p>
<h3><span class="gp4">
<a title=""
href="./gp4/benchmark.php?test=nbody&amp;lang=all">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<p class="timestamp"><a title="" href="./debian/benchmark.php?test=nbody&amp;lang=all">late 2007</a></p>
<h3><span class="debian">
<a title=""
href="./debian/benchmark.php?test=nbody&amp;lang=all">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
</table>
</dd>

<dt><a href="#why" name="why">Why make these comparisons between programming languages?</a></dt>
<dd>
<ol>
<li>To show working programs written in <i>less familiar</i> programming languages</li>
<li>To show <i>the least</i> we should expect from performance comparisons</li>
<li>To show how difficult it can be to make <i>meaningful</i> comparisons</li>
</ol>
</dd>

</dl>
</dd>


</dl>

