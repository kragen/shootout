<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<h5><strong>Benchmarking programming languages</strong>?</h5>
<p>How can we benchmark a programming language?<br/>
We can't - we benchmark programming language implementations.</p>
<p>How can we benchmark language implementations?<br/>
We can't - <strong>we measure particular programs</strong>.</p><br/>

<p class="timestamp"><? printf('%s GMT', gmdate("d M Y, l, g:i a", $Changed)) ?></p>

<dl>
<dt><a href="#game" name="game">&nbsp;What kind of game is this?</a></dt>
<dd>
<dl>
<dd>
<p>A game begun years ago. A game with many players. A game with many winners.</p>
</dd>

<dt><a href="#win" name="win"><b>How do I win?</b></a></dt>
<dd>
<p>Learn something - look at several benchmarks and compare the program source code for a language you don't know, with a language you do know; compare them on different measures. Read <a href="flawed-benchmarks.php" title="Flawed Benchmarks - Are there any other kind?"><strong>Flawed Benchmarks</strong></a>. Write programs that improve the showing of your chosen language. Write the best program in your chosen language. </p>
</dd>

<dt><a href="#scored" name="scored"><b>How is the game scored?</b></a></dt>
<dd>
<p>On 3 measures - <a href="#measurecpu">&darr;&nbsp;Time-used</a>, <a href="#memory">&darr;&nbsp;Memory-used</a> and <a href="#gzbytes">&darr;&nbsp;Code-used</a>.</p>
</dd>

<dt><a href="#several" name="several"><b>How do I compare 3 or 4 or more language implementations?</b></a></dt>
<dd>
<p>Select "- all benchmarks -" and "- all languages -" in the drop-down menus. 
<a href="./u64/which-languages-are-fastest.php?calc=calculate&amp;gpp=on&amp;gcc=on&amp;java=on&amp;javaxint=on&amp;jruby=on">Select the language implementations you want to chart</a> (deselect those you want to remove).</p>
</dd>

<dt><a href="#oneone" name="oneone"><b>How do I compare 2 language implementations?</b></a></dt>
<dd>
<p>Click a "Compare ... against one other language implementation" link, or <a href="./u64/benchmark.php?test=all&amp;lang=java">Select "- all benchmarks -" and a language implementation</a> in the drop-down menus.</p>
</dd>

<dt><a href="#samebenchmark" name="samebenchmark"><strong>How can I find all the programs for a benchmark?</strong></a></dt>
<dd>
<p><a href="./u64/benchmark.php?test=spectralnorm&lang=all">Select that benchmark and "- all languages -"</a> in the drop-down menus.</p>
</dd>

<dt><a href="#samelanguage" name="samelanguage"><strong>How can I find all the programs for a language?</strong></a></dt>
<dd>
<p>Select that language in the drop-down menu <a href="./u64/java.php#measurements">Measurements for all the accepted programs</a> on any language comparison page.</p>
</dd>

<dt><a href="#playing" name="playing"><b>Who's playing?</b></a></dt>
<dd>
<p>March 1 - August 31, 2009</p>
<p>1,022,612 Unique Page Views; 150,802 Absolute Unique Visitors; 166 programs contributed.</p>
</dd>

<dt><a href="#winning" name="winning"><b>Who's winning?</b></a></dt>
<dd>
<p>It varies from benchmark to benchmark. It varies from week to week. It depends which language implementations are compared. It depends which measures are compared.</p>
</dd>

<dt><a href="#end" name="end"><b>When does the game end?</b></a></dt>
<dd>
<p>When the facts exceed our curiousity.</p>
</dd>

<dt><a href="#play" name="play"><b>How do I play?</b></a></dt>
<dd>
<p>Look at what we show for Ubuntu&#8482; Intel&#174; Q6600&#174; quad-core. Choose one of those programming languages. Choose one of those benchmarks. Read and accept <a href="license.php">the benchmarks game license</a>. Ask questions <a href="#help">&darr;&nbsp;in the discussion forum</a>.</p>
<p><a href="#implement">&darr;&nbsp;Write a new program</a> and make sure it's correct by diff'ing the output. Profile and improve the program. <a href="#contribute">&darr;&nbsp;Attach the program source code file to a tracker item</a>.</p>
</dd>

</dl>
</dd>


<dt><a href="#means" name="means">&nbsp;Where are the results?</a></dt>
<dd>
<dl>

<dt><a href="#current" name="current"><b>Up-to-date measurements</b></a></dt>

<dd>
<p>There are 4 sets of up-to-date measurements. Measurements for different OS/machine combinations are shown on different color-coded pages. Click one of these color-coded links to see measurements for a particular OS/machine - </p>
</dd>

<?
$u32qTimestamp = gmdate("d M Y", filemtime('./u32q/data/data.csv'));
$u64qTimestamp = gmdate("d M Y", filemtime('./u64q/data/data.csv'));
$u64Timestamp = gmdate("d M Y", filemtime('./u64/data/data.csv'));
$u32Timestamp = gmdate("d M Y", filemtime('./u32/data/data.csv'));
?>

<dd>
<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language, 32 bit Ubuntu." href="./u32q/">Most recent measurement - <?=$u32qTimestamp;?></a></p>
<h3><span class="u32q">
<a title="Fastest in each programming language, 32 bit Ubuntu."
href="./u32q/">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span></h3>
</td>
</tr>
</table>
</dd>

<dd>
<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language, 64 bit Ubuntu." href="./u64q/">Most recent measurement - <?=$u64qTimestamp;?></a></p>
<h3><span class="u64q">
<a title="Fastest in each programming language, 64 bit Ubuntu."
href="./u64q/">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span></h3>
</td>
</tr>
</table>
</dd>

<dd>
<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language forced onto one core, 64 bit Ubuntu." href="./u64/">Most recent measurement - <?=$u64Timestamp;?></a></p>
<h3><span class="u64">
<a title="Fastest in each programming language forced onto one core, 64 bit Ubuntu."
href="./u64/">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one&nbsp;core&nbsp;</a></span></h3>
</td>
</tr>
</table>
</dd>

<dd>
<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language forced onto one core, 32 bit Ubuntu." href="./u32/">Most recent measurement - <?=$u32Timestamp;?></a></p>
<h3><span class="u32">
<a title="Fastest in each programming language forced onto one core, 32 bit Ubuntu."
href="./u32/">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one&nbsp;core&nbsp;</a></span></h3>
</td>
</tr>
</table>
</dd>

<dd>
<p>It's worth asking why a program is better in one set of measurements rather than another set of measurements made on <b>the same</b> Intel<sup>&#174;</sup> Q6600<sup>&#174;</sup> machine. <em>Caveat lector!</em> Check the source code!</p>
</dd>


<dt><a href="#history" name="history">Out-of-date measurements</a></dt>

<dd>
<p>It isn't worth asking why a program is better on a different test machine, because as well as the obvious differences - hardware, os, language implementation versions - it's likely that the programs measured on the different machines are different programs (either because missing third party libraries stop a program being measured, or simply because the program was not downloaded and measured).</p>
</dd>

<dd>
<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="" href="../gp4/">mid 2008</a></p>
<h3><span class="gp4">
<a title=""
href="../gp4/">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<p class="timestamp"><a title="" href="../debian/">late 2007</a></p>
<h3><span class="debian">
<a title=""
href="../debian/">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
</table>
</dd>

<dt><a href="#fresh" name="fresh">Freshness!</a></dt>

<dd>
<p><img src="<?=IMAGE_PATH;?>fresh_png_11dec2009.php"
   alt=""
   title=""
   width="400" height="225"
 /></p>
</dd>

</dl>
</dd>



<dt><a href="#means" name="means">&nbsp;What does &#8230; mean?</a></dt>
<dd>
<dl>

<dt><a href="#fable" name="fable">What does <b>"not fair"</b> mean? (A fable)</a></dt>
<dd>
<p>They raced up, and down, and around and around and around, and forwards and backwards and sideways and upside-down.</p>
<p>Cheetah's friends said <b>"it's not fair"</b> - everyone knows Cheetah is the fastest creature but the races are too long and Cheetah gets tired!</p>
<p>Falcon's friends said <b>"it's not fair"</b> - everyone knows Falcon is the fastest creature but Falcon doesn't walk very well, he soars across the sky!</p>
<p>Horse's friends said <b>"it's not fair"</b> - everyone knows Horse is the fastest creature but this is only a yearling, you must stop the races until a stallion takes part!</p>
<p>Man's friends said <b>"it's not fair"</b> - everyone knows that in the "real world" Man would use a motorbike, you must wait until Man has fueled and warmed up the engine!</p>
<p>Snail's friends said <b>"it's not fair"</b> - everyone knows that a creature should leave a slime trail, all those other creatures are cheating!</p>
<p>Dalmatian's tail was banging on the ground. Dalmatian panted and between breaths said "Look at that beautiful mountain, let's race to the top!" </p>
</dd>


<dt><a href="#loadstring" name="loadstring">What does '27% 34% 28% 67%' ~ CPU Load mean?</a></dt>
<dd><p>When the program was being measured: the first core was not-idle about 27% of the time, the second core was not-idle about 34% of the time, the third core was not-idle about 28% of the time, the fourth core was not-idle about 67% of the time.</p>
<p>When <em>all the programs</em> show ~CPU Load like this '0% 0% 0% 100%' you are probably looking at measurements of programs forced to use just one core - the fourth core (rather than being allowed to use any or all of the CPU cores).</p>
<p>Read <a href="#cpuload">&darr;&nbsp;How did you measure ~ CPU Load?</a></p>
</dd>

<dt><a href="#nmeans" name="nmeans">What does N mean?</a></dt>
<dd><p>N means the value passed to the program on the command-line (or the value used to create the data file passed to the program on stdin). Larger N causes the program to do more work - mostly measurements are shown for the largest N, the largest workload.</p>
<p>Read <a href="#pretest">&darr;&nbsp;How did you measure?</a></p>
</dd>

<dt><a href="#alternative" name="alternative">What does Interesting Alternative Program mean?</a></dt>
<dd><p>Interesting Alternative Program means that the program doesn't implement the benchmark according to the arbitrary and idiosyncratic rules of The Computer Language Benchmarks Game - but <b>we simply couldn't resist</b> showing the program.</p>
</dd>

<dt><a href="#id" name="id">What do #2 #3 mean?</a></dt>
<dd><p>Nothing - they are arbitrary suffixes that identify a specific program.</p>
</dd>

</dl>
</dd>



<dt><a href="#measure" name="measure">&nbsp;How did you measure&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#pretest" name="pretest">How did you measure?</a></dt>
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

<dt><a href="#measurecpu" name="measurecpu">How did you measure <strong>Time-used?</strong></a></dt>
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

<dt><a href="#cpuload" name="cpuload">How did you measure <b>~ CPU Load?</b></a></dt>
<dd><p>The GTop cpu idle and GTop cpu total was taken before forking the child-process and after the child-process exits, The percentages represent the proportion of cpu not-idle to cpu total for each core.</p>
</dd>

<dt><a href="#dynamic" name="dynamic">What about <b>Java</b>?</a></dt>
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
<td>meteor-contest&nbsp;&nbsp;</td>
<td>0.23s</td>
<td>0.01</td>
<td>0.12s</td>
<td>0.00</td>
<td>0.31s</td>
<td>0.13s</td>
<td>(14&nbsp;sec)</td>
</tr>

<tr>
<td>spectral-norm&nbsp;&nbsp;</td>
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
<td>binary-trees&nbsp;&nbsp;</td>
<td>20.69s</td>
<td>0.69</td>
<td>15.35s</td>
<td>0.43</td>
<td>19.18s</td>
<td>15.40s</td>
<td>(17&nbsp;min)</td>
</tr>

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

<dt><a href="#copts" name="copts">What <b>compiler options</b> did you set?</a></dt>
<dd><p>Without any optimization option the GCC compiler goal is to reduce compilation cost and make debugging reasonable. Typically we might set <tt>-O3 -fomit-frame-pointer -march=native</tt>. For some benchmarks <tt>-mfpmath=sse -msse2</tt> makes a noticeable difference (note <a href="http://java.sun.com/j2se/1.4.2/1.4.2_whitepaper.html#7">J2SE use of SSE instruction sets</a>).</p>
</dd>


<dt><a href="#machine" name="machine">What machine are you running the programs on?</a></dt>
<dd>
<p>We use a quad-core 2.4Ghz Intel<sup>&#174;</sup> Q6600<sup>&#174;</sup> machine with 4GB of RAM and 250GB SATA II disk drive.</p>
<p>The out-of-date measurements used a single-processor 2.2Ghz AMD&#8482; Sempron&#8482; machine with 512MB of RAM and 40GB IDE disk drive; and a single-processor 2Ghz Intel<sup>&#174;</sup> Pentium<sup>&#174;</sup> 4 machine with 512MB of RAM and 80GB IDE disk drive.</p>
</dd>

<dt><a href="#os" name="os">What OS are you using on the test machine?</a></dt>
<dd><p>We use <b>Ubuntu&#8482; 9.04 Linux</b> Kernel 2.6.28-17-generic</p>

<p>The out-of-date measurements used <b>Debian Linux</b> 'unstable', Kernel 2.6.18-3-k7 and <b>Gentoo Linux</b> gentoo-sources-2.6.20-r6</p>
</dd>


<dt><a href="#kinder" name="kinder">Sometimes the children help with the measurements&#8230;</a></dt>
<dd><pre>
Broadcast message from root@hopper (Sun Oct  1 16:33:48 2006):

Power button pressed
The system is going down for system halt NOW!

Broadcast message from root@hopper (Sun Oct  1 16:33:48 2006):

Power button pressed
The system is going down for system halt NOW!

Broadcast message from root@hopper (Sun Oct  1 16:33:49 2006):

Power button pressed
The system is going down for system halt NOW!

Broadcast message from root@hopper (Sun Oct  1 16:33:49 2006):

Power button pressed
The system is going down for system halt NOW!

Broadcast message from root@hopper (Sun Oct  1 16:33:49 2006):

Power button pressed
The system is going down for system halt NOW!

Broadcast message from root@hopper (Sun Oct  1 16:33:50 2006):

Power button pressed
The system is going down for system halt NOW!
</pre>
</dd>




</dl>
</dd>





<dt><a href="#help" name="help">&nbsp;Where can I ask for help&#8230;?</a></dt>
<dd>
<dl>


<dt><a href="#aliothid" name="aliothid">Create an <b>Alioth ID</b> and login</a></dt>
<dd><p>We no longer accept anonymous comments - please <a href="http://alioth.debian.org/account/register.php"><b>create an Alioth ID</b></a> and login.</p>
<p>Ask questions or discuss the benchmarks in the <a href="http://alioth.debian.org/forum/?group_id=30402" title="Find Help, Share Opinions"><b>discussion&nbsp;forums</b></a>.</p>
</dd>

<dt><a href="#report" name="report">Where can I report bugs&#8230; request features?</a></dt>
<dd><p>Tell us about content mistakes, inconsistencies, bad installs <em>etc</em> - <a href="https://alioth.debian.org/tracker/?atid=411002&amp;group_id=30402&amp;func=browse"><b>Report a Bug</b></a>.</p> 
<p>Tell us about the latest language updates <em>etc</em> - add a <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><b>Feature Request</b></a>.</p>
<p>We use <a href="http://www.andre-simon.de/">Andre Simon's highlight</a> to convert program source code to XHTML, please contribute better language definition files.</p>
</dd>



<dt>&nbsp;</dt>
<dd><p>Change the things you don't like - <em>convince us</em> that the change is a worthwhile improvement and then <em>expect to do all the work</em>.</p>
<p><b>Be Nice!</b> Maybe we'll reject the program. Maybe we'll prefer our own opinions. Maybe we'll decide not to change something.</p>
</dd>
</dl>
</dd>



<dt><a href="#implement" name="implement">&nbsp;How should I implement&#8230;?</a></dt>
<dd>
<dl>

<dt><a href="#implementp" name="implementp">How should I implement programs for the Benchmarks Game?</a></dt>
<dd><p>We prefer <b>plain vanilla programs</b> - after all we're trying to compare language implementations not programmer effort and skill. We'd like your programs to be easily viewable - so please format your code to fit in less than 80 columns (we don't measure lines-of-code!).</p>
<p>We also have a weakness for idiosyncratic, elegant, clever programs; and when they are too elegant to meet the requirements of the benchmark we <em>might</em> still show them in the <a href="help.php#alternative">&darr;&nbsp;Interesting Alternative Programs</a> section.</p>
</dd>

<dt><a href="#correct" name="correct">How much effort should I put into getting the program correct?</a></dt>
<dd><p>Do design-iteration on your machine, or in a language newsgroup. Only Contribute Programs which give <b>correct results</b> on your machine - <b>diff</b> the program output with the provided output file. (Don't make-unnecessary-work for the committers.)</p>
<p>Leave it a couple of days, and then see if there are any <b>minor improvements</b> that you'd like to make, before you Contribute Programs to The Computer Language Benchmarks Game.</p> 
</dd>



<dt><a href="#datainput" name="datainput">How should I implement data-input?</a></dt>
<dd><p>Programs are measured across a range of input-values; programs are expected to either take a <b>single command-line parameter</b> or read text from <b>stdin</b>.</p> 
<p>(Look at what the other programs do.)</p>
</dd>

<dt><a href="#dataoutput" name="dataoutput">How should I implement data-output?</a></dt>
<dd><p>Programs should write to <b>stdout</b>. Program output is redirected to a log-file and diff'd with the expected output.</p>
<p>(Look at what the other programs do.)</p>
</dd>

<dt><a href="#brag" name="brag">How should I identify my program?</a></dt>
<dd><p>Include a header comment in the program like this:</p>
<pre>
/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by &#8230;
   modified by &#8230;
*/
</pre>
</dd>

<dt><a href="#split" name="split">How should I implement multiple source code files?</a></dt>
<dd>
<p>We use a simple script to <b>split a single source file</b> into multiple target source files.</p>
<p>One of the target source files <em>must</em> have the same filename as the original single source file, and is expected to be the 'main' program.</p>
<p>For example, the <a href="http://shootout.alioth.debian.org/gp4/benchmark.php?test=nbody&amp;lang=se&amp;id=1">Eiffel <em>nbody.e</em> source file</a> will be split into 3 target source files - <em>nbody.e, body.e, nbody_system.e</em> - 
each new target source file will start from the <b>comment line</b> which included the SPLITFILE=<em>target-filename</em> directive and run to the line preceding the next
 SPLITFILE=<em>target-filename</em> directive or end-of-file.</p>
<p>So, the new target source file <em>body.e</em> will start with the line</p>
<tt>-- SPLITFILE=body.e</tt>
<p>and end with the empty line following</p>
<tt>end -- class BODY</tt>
</dd>

<dt><a href="#unroll" name="unroll">How should I implement loops?</a></dt>
<dd><p>Don't manually unroll loops!</p></dd>

<dt><a href="#promo" name="promo">How should I advertise my company, services, website&#8230;?</a></dt>
<dd><p><b>We'll remove any promos</b> that you add as comment text, so please don't waste our time.</p> 
</dd>
</dl>
</dd>



<dt><a href="#contribute" name="contribute">&nbsp;How do I contribute a program?</a></dt>
<dd>
<dl>
<dd><p>There are many contributors and few committers - a little more time spent by contributors saves committers a great deal more time.</p>
<p>Attach the full source-code file of a tested program. Please don't paste source-code into the description field. Please don't contribute patch-files.</p>
<p>Before contributing programs</p>
<ul>
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

<dt><a href="#status" name="status">How can I track what happens to the program I contributed?</a></dt>
<dd>

<p>You created an <a href="#aliothid">&darr;&nbsp;Alioth ID</a> with a valid email address so you'll receive email updates when your program is accepted and measured.</p>
</dd>

</dl>
</dd>



<dt><a href="#where" name="where">&nbsp;Where can I see&#8230;?</a></dt>
<dd>
<dl>

<dt><a href="#previous" name="previous">Where can I see previous programs?</a></dt>
<dd>
<p>Periodically we go through and remove slower programs from the website (if there's a faster program for the same language implementation). <b>We don't remove those programs from the "Play the Benchmarks Game" tracker.</b></p>
<p>You can see previous programs by browsing though the <a href="http://alioth.debian.org/tracker/?atid=413100&amp;group_id=30402&amp;func=browse"><b>Play the Benchmarks Game tracker items</b></a> and looking at the attached source code files. Log In with your Alioth Id, you will be able to create and save a query to search for particular tracker items.</p>
</dd>

<dt><a href="#version" name="version">Where can I see which language version was used?</a></dt>
<dd><p>You can see information about the language implementation, including the version number, at the bottom of each <a href="./u64/benchmark.php?test=all&lang=gpp&lang2=java#about"><strong>language comparison</strong> page</a> and at the bottom of each <a href="./u64/benchmark.php?test=all&amp;lang=gcc&amp;lang2=gcc#about" title="C GNU gcc : unchecked low-level programming"><strong>language measurements</strong> page</a>.</p>
</dd>

<dt><a href="#options" name="options">Where can I see which compiler and runtime options were used?</a></dt>
<dd><p>You can see the build commands and runtime options at the bottom of each program page -
<a href="./u64/benchmark.php?test=nbody&amp;lang=gcc&amp;id=1#log" title="make, command line, and program output logs"><b>make, command line, and program output logs</b></a>.</p>
</dd>

<dt><a href="#summarydata" name="summarydata">Where can I see the data?</a></dt>
<dd>
<ul>
<li><a
href="./u64/summarydata.php?d=data"><b>summary data</b> for largest N</a></li>
<li><a
href="./u64/summarydata.php?d=ndata"><b>full summary data</b> - smaller and largest N</a></li>
</ul>
</dd>


<dt><a href="#downsource" name="downsource">Where can I see more?</a></dt>
<dd><p>The <b>project is hosted</b> by <a href="http://alioth.debian.org/projects/shootout"  title="The Computer Language Benchmarks Game project page on Alioth FusionForge at Debian.org">Alioth&nbsp; FusionForge</a>.</p>
<p>You can <a href="http://alioth.debian.org/scm/?group_id=30402"  title="Browse the GComputer Language Benchmarks Game CVS tree">browse the CVS tree</a>.</p>
</dd>
</dl>
</dd>




<dt><a href="#whydont" name="whydont">&nbsp;Why don't you&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#contest" name="contest">Why don't you accept every program that gives the correct result?</a></dt>
<dd><p>We are trying to show the performance of various programming language implementations - so we ask that contributed programs not only give the
correct result, but also <b>use the same algorithm</b> to calculate that result.</p>
<p>Back in the day, Doug Bagley used both <em>same way</em> (same algorithm) and <em>same thing</em> (same result) benchmarks - so in many cases the performance
 differences were simply better algorithms.</p>
<p>After hearing many arguments, it seems <em>to me</em> that we should think of <em>same way</em> (same algorithm) tests as <strong>benchmarks</strong>, and
 we should think of <em>same thing</em> (same result) tests as <b>contests</b>.</p>
<p>At present, we show just one contest - <a href="./u64/benchmark.php?test=meteor&amp;lang=all">meteor-contest</a>.</p>
</dd>

<dt><a href="#acceptable" name="acceptable">Why don't you include language X?</a></dt>
<dd><p>Is the language implementation</p>
<ul>
<li><b>Used?</b> There are way too many dead languages and unused new languages - see <a href="http://people.ku.edu/~nkinners/LangList/Extras/langlist.htm">The Language List</a> and <a href="http://www.levenez.com/lang/">Computer Languages History</a></li>
<li><b>Interesting?</b> Is there something significant and interesting about the language, and will that be revealed by these simple benchmark programs? (But look closely and you'll notice that we sometimes include languages just because <em>we find them interesting</em>.)</li>
</ul>
<p>If that wasn't discouraging enough: in too many cases we've been asked to include a language implementation, and been told that of course programs would be contributed, but once the language didn't seem to perform as-well-as hoped no more programs were contributed. We're interested in the whole range of performance - not just in the 5 programs which show a language implementation at it's best.</p>
<p>We have no ambition to measure every Python implementation or every Haskell implementation or every C implementation - that's a chore for all you Python enthusiasts and Haskell enthusiasts and C enthusiasts, a chore which might be straightforward if you <a href="help.php#measurementscripts">use our measurement scripts</a>.</p>
<p>We are unable to publish measurements for many commercial language implementations simply because their license conditions forbid it.</p>
<p>We will accept <b>and reject</b> languages in a capricious and unfair fashion - so ask if we're interested before you start coding.</p>
</dd>

<dt><a href="#measurementscripts" name="measurementscripts">Use our <b>measurement scripts</b> to make your own measurents!</a></dt>
<dd><p>The Python script "bencher does repeated measurements of program cpu time, elapsed time, resident memory usage, cpu load while a program is running - and summarizes those measurements" - <a href="http://alioth.debian.org/frs/?group_id=30402"><b>download bencher</b></a> and unpack into your ~ directory.</p>

<p><b>As an alternative</b>, you should take a look at these Python measurement scripts designed for statistically rigorous Java performance evaluation - <a href="http://www.elis.ugent.be/JavaStats">JavaStats</a></p>
</dd>
</dl>
</dd>



<dt><a href="#useful" name="useful">&nbsp;What's it useful for?</a></dt>
<dd>
<dl>
<dd><p>You'll come across a range of uses for the programs and measurements:</p>
<ul>
<li>example of profiling - <a href="http://www.haskell.org/~simonmar/bib/threadscope-09_abstract.html">Parallel Performance Tuning for Haskell</a></li>
<li>../test/bench - <a href="http://golang.org/doc/install.html">The Go Programming Language</a></li>
<li>regression tests - <a href="http://jira.codehaus.org/browse/JRUBY-4157">"After fixing this, fannkuch runs correctly"</a></li>
<li>performance regressions - <a href="http://www.scala-lang.org/node/360">"a quick and dirty benchmarking suite"</a></li>
<li>cheap laughs - <a href="http://www.dcs.warwick.ac.uk/~rlmw/talks/benchmarking.pdf">Benchmarking - End the decline of Western Civilization! p54 (pdf)</a></li>
<li>visualization and analysis - <a href="http://gmarceau.qc.ca/blog/2009/05/speed-size-and-dependability-of.html">"rich in shapes, insight and stories"</a></li>
<li>edge cases - <a href="http://ulf.wiger.net/weblog/wp-content/uploads/2009/01/damp09-erlang-multicore.pdf">"runs slower the more cores you throw at it" p22 (pdf)</a></li>
<li>implementor fun - <a href="http://www.mirandabanda.org/cogblog/2009/01/14/under-cover-contexts-and-the-big-frame-up/#comments">"we get worth-while speedups for everything except"</a></li>
<li>training a classifier - <a href="http://blog.chrislowis.co.uk/2009/01/04/identify-programming-languages-with-source-classifier.html">Identify Programming Languages with SourceClassifier</a></li>
<li>more comparisons - <a href="http://www.cs.purdue.edu/homes/sbarakat/cs456/Scripting.pdf">Performance of Scripting Languages (pdf)</a></li>
<li>performance testing - <a href="http://www2.webkit.org/perf/sunspider-0.9/sunspider.html">SunSpider JavaScript Benchmark</a></li>
<li>lighthearted asides - <a href="http://research.microsoft.com/~simonpj/papers/history-of-haskell/history.pdf">A History of Haskell: Being Lazy With Class (pdf)</a></li>
<li>diagnostics - <a href="http://smalltalk.gnu.org/project/issue/200">"awful memory usage with lots of big objects"</a></li>
<li>dispelling myths - <a href="http://ftp.openvms.compaq.com/openvms/journal/v10/openvms_journal.pdf">Java and OpenVMS: Myths and realities (pdf)</a></li>
<li>gaining perspective - <a href="http://openquark.org/svn/openquark/tags/1.4.0_0/OpenQuark/docs/CAL%20and%20the%20Computer%20Language%20Shootout%20Benchmarks.pdf">CAL and the Computer Language Benchmarks Game (pdf)</a></li>
<li>nostalgia - <a href="http://upsilon.cc/~zack/teaching/0607/labsomfosset/ocaml_hot.pdf">"we will show you 2004 data" (pdf)</a></li>
</ul>
</dd>
</dl>
</dd>

</dl>






