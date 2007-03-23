<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<p class="timestamp"><? printf('%s GMT', gmdate("d M Y, l, g:i a", $Changed)) ?></p>
<p>This FAQ is short. You can read it really quickly.</p>


<dl>
<dt><a href="#learn" name="learn">&nbsp;What can I learn from this FAQ?</a></dt>
<dd>
<dl>
<dd>
<p><em>The Computer Language Shootout</em> has a <strong>very narrow focus</strong>.</p>
<p>We are only trying to show the performance of various programming language implementations, on a limited number of <a href="miscfile.php?file=benchmarking&amp;title=Flawed Benchmarks" title="Flawed benchmarks - Are there any other kind?"><strong>flawed benchmarks</strong></a>.</p>
<p>We <strong>are not</strong> trying to</p>
<ul>
<li>compare different algorithms</li>
<li>showcase the capabilities of different languages</li>
<li>compare programming language productivity</li>
<li>contest programmer effort and sneaky tricks</li>
<li><em>etc etc</em></li>
</ul>
</dd>

<dt><a href="#contents" name="contents">What else?</a></dt>
<dd>
<p><a href="#means"><strong>&darr;&nbsp;What does &#8230; mean?</strong></a></p>
<p><a href="#measure"><strong>&darr;&nbsp;How did you measure&#8230;?</strong></a></p>
<p><a href="#help"><strong>&darr;&nbsp;Where can I discuss&#8230; contribute&#8230;?</strong></a></p>
<p><a href="#where"><strong>&darr;&nbsp;Where can I see&#8230;?</strong></a></p>
<p><a href="#whydont"><strong>&darr;&nbsp;Why don't you &#8230;?</strong></a></p>
<p><a href="#when"><strong>&darr;&nbsp;Who&#8230;?</strong> <strong>When&#8230;?</strong> <strong>Why&#8230;?</strong></a></p>
</dd>
</dl>
</dd>


<dt><a href="#means" name="means">&nbsp;What does &#8230; mean?</a></dt>
<dd>
<dl>

<dt><a href="#fable" name="fable">What does <strong>"not fair"</strong> mean? (A fable)</a></dt>
<dd>
<p>They raced up, and down, and around and around and around, and forwards and backwards and sideways and upside-down.</p>
<p>Cheetah's friends said <strong>"it's not fair"</strong> - everyone knows Cheetah is the fastest creature but the races are too long and Cheetah gets tired!</p>
<p>Falcon's friends said <strong>"it's not fair"</strong> - everyone knows Falcon is the fastest creature but Falcon doesn't walk very well, he soars across the sky!</p>
<p>Horse's friends said <strong>"it's not fair"</strong> - everyone knows Horse is the fastest creature but this is only a yearling, you must stop the races until a stallion takes part!</p>
<p>Man's friends said <strong>"it's not fair"</strong> - everyone knows that in the "real world" Man would use a motorbike, you must wait until Man has fueled and warmed up the engine!</p>
<p>Snail's friends said <strong>"it's not fair"</strong> - everyone knows that a creature should leave a slime trail, all those other creatures are cheating!</p>
<p>Dalmation's tail was banging on the ground. Dalmation panted and between breaths said "Look at that beautiful mountain, let's race to the top!" </p>
</dd>


<dt><a href="#fullcpu" name="fullcpu">What does Full CPU Time mean?</a></dt>
<dd><p>Full CPU Time means <strong>program usr+sys time</strong> which includes the time taken to startup and shutdown the program. For language implementations that use a Virtual Machine the Full CPU Time includes the time taken to startup and shutdown the VM.</p>
<p>You can get a vague idea of the difference in startup time between language implementations from the <a href="benchmark.php?test=hello&amp;lang=all" title="Compare performance on the startup benchmark"><strong>startup benchmark</strong></a>.</p>

<p>Sometimes Java programmers point out that JVM profiling and dynamic compilation will improve program performance when the same program is used again and again and again without shutting down the JVM. That's true.</p>

<p>Let's pretend that we don't startup the JVM or load all those class files, and let's pretend the same program is used again and again and again 1,000 times without any other program being used, and let's pretend we don't shutdown the JVM. Let's pretend that we luckily used the program after a mass of JVM profiling and dynamic compilation has taken place - so we get all the benefit of dynamic compilation without paying any of the cost.</p>

<p>Here are some examples where we measured elapsed time once the Java program had started, and measured the same program again and again and again 1,000 times (taking from 30 minutes to over 4 hours). Then we selected the fastest elapsed time, taking all the benefit and none of the cost:</p>

<table>
<tr>
<th colspan="2">&nbsp;&nbsp;all the benefit none of the cost</th>
<th>&nbsp;&nbsp;Full CPU Time</th>
<th colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;difference</th>	
</tr>

<tr>
<td>nsieve&nbsp;&nbsp;</td>
<td>2.108</td>
<td>2.384</td>
<td>0.276</td>
<td>11%</td>
</tr>
<tr>
<td>mandelbrot&nbsp;&nbsp;</td>
<td>4.340</td>
<td>4.852</td>
<td>0.512</td>
<td>11%</td>
</tr>
<tr>
<td>binary-trees&nbsp;&nbsp;</td>
<td>5.517</td>
<td>6.736</td>
<td>1.219</td>
<td>18%</td>
</tr>
<tr>
<td>recursive&nbsp;&nbsp;</td>
<td>6.753</td>
<td>7.076</td>
<td>0.323</td>
<td>5%</td>
</tr>
<tr>
<td>nsievebits&nbsp;&nbsp;</td>
<td>8.222</td>
<td>8.705</td>
<td>0.483</td>
<td>5%</td>
</tr>
<tr>
<td>fannkuch&nbsp;&nbsp;</td>
<td>12.208</td>
<td>13.753</td>
<td>1.545</td>
<td>11%</td>
</tr>
<tr>
<td>nbody&nbsp;&nbsp;</td>
<td>15.950</td>
<td>17.017</td>
<td>1.067</td>
<td>6%</td>
</tr>
</table>

<p>As part of performance analysis, those differences hint at how much is not accounted for by JVM startup or dynamic compilation, and how little or how much we might still be able to achieve by contributing better programs.</p>
</dd>

<dt><a href="#whatlanguage" name="whatlanguage">What language was used to write the benchmark programs?</a></dt>
<dd><p>Different benchmark programs, different authors - different languages.</p>
<p>The benchmark descriptions sometimes refer to an article which included program source: Lisp and C for fannkuch; Java for binary-trees and meteor and chameneos; Haskell for pidigits; Erlang for cheap-concurrency. And others as the author provided: C for mandelbrot and spectral-norm; Java for n-body. And others in Nice or C# or Lua or &#8230; as the mood would have it.</p>
</dd>

<dt><a href="#alternative" name="alternative">What does Interesting Alternative Program mean?</a></dt>
<dd><p>"Interesting Alternative Program" means that the program doesn't implement the benchmark according to the arbitrary and idiosyncratic rules of the Computer Language Shootout - but <strong>we simply couldn't resist</strong> showing the program.</p>
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
<p>Each program was run once pre-test to reduce cache effects. Program output is redirected to a log-file and compared to the expected output.</p>
<p>Each program was then run 3 times with program output redirected to /dev/null. We show the lowest measured CPU time and the highest memory usage, from the 3 runs.</p>
<p>The variation between cpu times is different for different languages and for different benchmarks. 
<em>The coefficient of variation</em> for 100 measurements of nbody ranged from 0.029% (Lua) to 0.074% (Oberon2) to 0.092% (C#); 
and for 100 measurements of fasta ranged from 0.009% (Lua) to 0.088% (C#) to 0.655% (Oberon2).</p>
<p>Don't sweat the small stuff - differences in cpu time of a few % are illusory.</p>
</dd>

<dt><a href="#measurecpu" name="measurecpu">How did you measure <strong>CPU time?</strong></a></dt>
<dd><p>Each program was run as a child-process of a Perl script. We take the script child-process usr+sys time, before forking the child-process and after the child-process exits.</p>
<p>(<a href="http://packages.debian.org/stable/perl/libbsd-resource-perl" title="Debian package 'perl BSD::Resource - BSD process resource limit and priority'">BSD::Resource::times</a>)[2,3] does seem to provide better resolution than Perl times() builtin function or <a href="http://www.danlj.org/mkj/lad/info/time.html#SEC10" title="Measuring Program Resource Use: The GNU time Command">GNU time</a>, for example measuring the same program:</p>
<pre>Perl times() builtin function
16.650
16.660
16.640

BSD::Resource::times
16.659
16.656
16.655

GNU time version 1.7
16.62
16.61
16.60

Bash time builtin command
16.624
16.628
16.638
</pre>
<p>We use (<a href="http://packages.debian.org/stable/perl/libbsd-resource-perl" title="Debian package 'perl BSD::Resource - BSD process resource limit and priority'">BSD::Resource::times</a>)[2,3]</p>
<p>The <a href="#fullcpu"><strong>&darr;&nbsp;Full CPU time</strong></a> <em>includes</em> program startup time.</p>
</dd>

<dt><a href="#memory" name="memory">How did you measure <strong>memory usage?</strong></a></dt>
<dd><p>In a very approximate and unreliable way. We sampled the child-process resident memory size (VmRSS) multiple times a second. We identified the main thread by checking for SIGCHLD being registered as the exit_signal in the second to last field of /proc/{pid}/stat.</p>
<p>There's a race condition. When the program completes quickly, this sampling technique will fail.</p>       
</dd>

<dt><a href="#gzbytes" name="gzbytes">How did you measure <strong>GZip Bytes?</strong></a></dt>
<dd><p>We started with the source-code markup you can see, removed comments, removed duplicate whitespace characters, and then applied minimum GZip compression.</p>
</dd>

<dt><a href="#copts" name="copts">How did you set <strong>compiler options?</strong></a></dt>
<dd><p>Without any optimization option the GCC compiler goal is to reduce compilation cost and make debugging reasonable. Typically we might set <tt>-O3 -fomit-frame-pointer -march=pentium4</tt>. For some benchmarks <tt>-mfpmath=sse -msse2</tt> makes a noticeable difference (note <a href="http://java.sun.com/j2se/1.4.2/1.4.2_whitepaper.html#7">J2SE use of SSE instruction sets</a>).</p>
</dd>

<dt><a href="#machine" name="machine">What machine are you running the programs on?</a></dt>
<dd><p>We use a single-processor 2.2Ghz AMD&#8482; Sempron&#8482; machine with 512 MB of RAM and a 40GB IDE disk drive; and a single-processor 2Ghz Intel<sup>&#174;</sup> Pentium<sup>&#174;</sup> 4 machine with 512MB of RAM and an 80GB IDE disk drive.</p>
</dd>

<dt><a href="#os" name="os">What OS are you using on the test machine?</a></dt>
<dd><p>We use <strong>Debian Linux&#8482;</strong> 'unstable', Kernel 2.6.18-3-k7 and <strong>Gentoo Linux&#8482;</strong> gentoo-sources-2.6.18-r4</p>
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





<dt><a href="#help" name="help">&nbsp;Where can I discuss&#8230; contribute&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#talk" name="talk">Where can I discuss&#8230;?</a></dt>
<dd><p>Discuss the benchmarks or ask for help in the <a href="http://alioth.debian.org/forum/?group_id=30402" title="Find Help, Share Opinions"><strong>discussion&nbsp;forums</strong></a>.</p></dd>


<dt><a href="#aliothid" name="aliothid">Create an <strong>Alioth ID</strong> and login</a></dt>
<dd><p>"Feature Request", "Bug" and "Contribute Programs" tracker comments are being SPAMMED. We will no longer accept anonymous public comments - please <a href="http://alioth.debian.org/account/register.php"><strong>create an Alioth id</strong></a> and login.</p>
</dd>

<dt><a href="#contributeprogram" name="contributeprogram">Where do I contribute a program?</a></dt>
<dd><p><strong>Before</strong> working on a benchmark program:</p>
<ul>
<li>browse the current benchmarks - <a href="http://shootout.alioth.debian.org/"><strong>Start:</strong> on the homepage</a></li>
<li>read the benchmark description</li>
<li>read some of the programs</li>
<li>read <a href="#implement"><strong>&darr;&nbsp;"How should I implement&#8230;?"</strong></a></li>
</ul>
<p>Then follow these detailed instructions <a href="#contribute"><strong>&darr;&nbsp;"How do I contribute a program?"</strong></a></p>
<p>Be Respectful! Don't ridicule other people's programs - just contribute a better program yourself.</p>
</dd>

<dt><a href="#contributebenchmark" name="contributebenchmark">Where do I contribute a new benchmark?</a></dt>
<dd><p><strong>Before</strong> working on a new benchmark</p>
<ul>
<li>browse the current benchmarks - <a href="http://shootout.alioth.debian.org/"><strong>Start:</strong> on the homepage</a></li>
<li>read the benchmark descriptions</li>
<li>read <a href="#newbench">&darr; <strong>"How can I contribute a new benchmark?"</strong></a></li>
</ul>
</dd>

<dt><a href="#report" name="report">Where can I report bugs&#8230; request features?</a></dt>
<dd><p>Tell us about content mistakes, inconsistencies, bad installs <em>etc</em> - <a href="https://alioth.debian.org/tracker/?atid=411002&amp;group_id=30402&amp;func=browse"><strong>Report a Bug</strong></a>.</p> 
<p>Tell us about the latest language updates <em>etc</em> - add a <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><strong>Feature Request</strong></a>.</p>
<p>We use <a href="http://www.andre-simon.de/">Andre Simon's highlight</a> to convert program source code to XHTML, please contribute better language definition files.</p> 
</dd>

<dt>&nbsp;</dt>
<dd><p>Change the things you don't like - <em>convince us</em> that the change is a worthwhile improvement and then <em>expect to do all the work</em>.</p>
<p><strong>Be Nice!</strong> Maybe we'll reject the program. Maybe we'll decide not to add the new benchmark. Maybe we'll prefer our own opinions. Maybe we'll decide not to change something.</p>
</dd>
</dl>
</dd>



<dt><a href="#implement" name="implement">&nbsp;How should I implement&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#correct" name="correct">How much effort should I put into getting the program correct?</a></dt>
<dd><p>Do design-iteration on your machine, or in a language newsgroup. Only Contribute Programs which give <strong>correct results</strong> on your machine - <strong>diff</strong> the program output with the provided output file. (Don't make-unnecessary-work for the committers.)</p>
<p>Leave it a couple of days, and then see if there are any <strong>minor improvements</strong> that you'd like to make, before you Contribute Programs to the Computer Language Shootout.</p> 
</dd>

<dt><a href="#implementp" name="implementp">How should I implement programs for the Shootout?</a></dt>
<dd><p>We prefer <strong>plain vanilla programs</strong> - after all we're trying to compare language implementations not programmer effort and skill.</p> 
<p>We also have a weakness for idiosyncratic, elegant, clever programs; and when they are too elegant to meet the requirements of the benchmark we <em>might</em> still show them in the <a href="faq.php#alternative">'Interesting Alternative Programs'</a> section.</p> 
</dd>

<dt><a href="#datainput" name="datainput">How should I implement data-input?</a></dt>
<dd><p>Programs are measured across a range of input-values; programs are expected to either take a <strong>single command-line parameter</strong> or read text from <strong>stdin</strong>.</p> 
<p>(Look at what the other programs do.)</p>
</dd>

<dt><a href="#dataoutput" name="dataoutput">How should I implement data-output?</a></dt>
<dd><p>Programs should write to <strong>stdout</strong>. Program output is redirected to a log-file and compared to the expected output.</p> 
<p>(Look at what the other programs do.)</p>
</dd>

<dt><a href="#brag" name="brag">How should I identify my program?</a></dt>
<dd><p>Include a header comment in the program like this:</p>
<pre>
/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by &#8230;
   modified by &#8230;
*/
</pre>
</dd>

<dt><a href="#implementlist" name="implementlist">How should I implement&#8230;?</a></dt>
<dd>
<ol>
<li>Keep to the spirit-of-the-specification not just the wording.</li>
<li>Write the program to be as-fast-as possible.</li>
<li>Write the program to conserve memory as-much-as possible.</li>
<li>Write the program as-if lines of code were not being measured.</li>
</ol>     
</dd>

<dt><a href="#split" name="split">How should I implement multiple source code files?</a></dt>
<dd>
<p>We use a simple script to <strong>split a single source file</strong> into multiple target source files.</p>
<p>One of the target source files <em>must</em> have the same filename as the original single source file, and is expected to be the 'main' program.</p>
<p>For example, the <a href="benchmark.php?test=nbody&amp;lang=se">Eiffel <em>nbody.e</em> source file</a> will be split into 3 target source files - <em>nbody.e, body.e, nbody_system.e</em> - 
each new target source file will start from the <strong>comment line</strong> which included the SPLITFILE=<em>target-filename</em> directive and run to the line preceding the next
 SPLITFILE=<em>target-filename</em> directive or end-of-file.</p>
<p>So, the new target source file <em>body.e</em> will start with the line</p>
<tt>-- SPLITFILE=body.e</tt>
<p>and end with the empty line following</p>
<tt>end -- class BODY</tt>
</dd>

<dt><a href="#unroll" name="unroll">How should I implement loops?</a></dt>
<dd><p>Don't manually unroll loops!</p></dd>

<dt><a href="#promo" name="promo">How should I advertise my company, services, website&#8230;?</a></dt>
<dd><p><strong>We'll remove any promos</strong> that you add as comment text, so please don't waste our time.</p> 
</dd>
</dl>
</dd>



<dt><a href="#contribute" name="contribute">&nbsp;How do I contribute a program?</a></dt>
<dd>
<dl>
<dd><p>There are many contributors and few committers - a little more time spent by contributors saves committers a great deal more time.</p>
<p>Please don't contribute patch-files. Do attach full source-code from tested programs.</p>
<p>Before contributing programs</p>
<ol>
<li>read the <a href="miscfile.php?file=license&amp;title=revised BSD license" title="Read the revised BSD license"><strong>Revised&nbsp;BSD&nbsp;license</strong></a> - all contributed programs are published under this revised BSD license.</li>
<li>read <a href="faq.php#implement">&darr;&nbsp;<strong>How should I implement&#8230;?</strong></a></li>
</ol>

<p>Follow these instructions <strong>step-by-step</strong></p>
<ol>
<li>Start from the bottom. <strong>Attach</strong> the program source-code file - do this first because it's easy to forget.</li>
<li>Say in the <strong>Description</strong> how this program fixes an error or is faster or was missing or &#8230; Give us reasons to accept your program.</li>
<li>Each <strong>Summary</strong> text <em><strong>must</strong></em> be unique! Follow this convention:<br />  
language, benchmark, your-name, date, (version)<br />
<em>Ruby nsieve Glenn Parker 2005-03-28</em><br />
</li>
<li><strong>Category</strong>: select the language implementation</li>
<li><strong>Group</strong>: select the benchmark</li>
<li>click the Submit button</li>
</ol>

<p>Now <strong>start from the bottom</strong> of the
   <a href="https://alioth.debian.org/tracker/?func=add&amp;group_id=30402&amp;atid=411646"  title="Contribute Programs - Submit New">
   <strong>Contribute Programs Submit-New</strong></a> form and work your way up.
</p>
</dd>

<dt><a href="#status" name="status">How can I track what happens to the program I contributed?</a></dt>
<dd>
<p>Browse <a href="http://alioth.debian.org/tracker/?func=browse&group_id=30402&atid=411646" title="Browse Contribute Programs"><strong>Contribute Programs</strong></a></p>

<p>Check the <strong>Resolution</strong> field, and check the <strong>State</strong> field</p>
<ul>
<li><em>Open items</em> are new contributions</li>
<li><em>Pending items</em> have been added to CVS</li>
<li><em>Closed items</em> have been measured and shown on the website</li>
</ul>
<p>Check the <strong>most recent measurement</strong> date on the website to see if measurements have been made since the program you contributed was added to CVS.</p>
</dd>

<dt><a href="#mycontribution" name="mycontribution">When will you include my contribution?</a></dt>
<dd>
<p>When we can! We already spend way-too-much personal-time on this website. Things get-done when they get-done.</p>
<p>Check the <strong>most recent measurement</strong> date on the website to see if measurements have been made since the program you contributed was added to CVS.</p>
<p>Maybe you'd like to <a href="#chores">&darr;&nbsp;help us with the chores</a>?</p>
<p>Normally, contributed programs will be measured and included on the website once or twice each week.</p>
<p>The simplest way to find out when new measurements have been made is to subscribe to <a href="<?=CORE_SITE;?>feeds/rss.xml"><img src="<?=IMAGE_PATH;?>orangexml.gif" alt="Really Simple Syndication" title="Really Simple Syndication" /></a> - our <a href="<?=CORE_SITE;?>feeds/rss.xml">RSS feed</a>.</p>
<p>My Yahoo! users can add our feed by clicking <a href="http://add.my.yahoo.com/rss?url=<?=CORE_SITE;?>feeds/rss.xml"><img src="<?=IMAGE_PATH;?>addtomyyahoo4.gif" width="91" height="17" alt="Add to My Yahoo!"/></a></p>
</dd>


<dt><a href="#newbench" name="newbench">How can I contribute a new benchmark?</a></dt>
<dd>
<p>Do all the work!</p>
<ul>
<li>Understand that benchmarks must be reasonable across a wide range of programming languages</li>
<li>Identify what's missing or wrong with the current benchmarks</li>
<li>Define a new benchmark and give some background information</li>
<li>Provide implementations in an interpreted language, a JIT language, and a compiled language</li>
</ul>
<p>We will accept <strong>and reject</strong> benchmarks in a capricious, unfair, biased fashion.</p>
<p>Browse <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><strong>Feature Requests</strong></a> with Category <strong>New Benchmark</strong> to see if it's already been suggested.</p>
</dd>

<dt><a href="#chores" name="chores">How can I help with <strong>the chores</strong>?</a></dt>
<dd>
<p>We need volunteers to</p>
<ol>
<li>Browse <a href="https://alioth.debian.org/tracker/?func=browse&amp;group_id=30402&amp;atid=411646" title="Browse Contribute Programs"><strong>Contribute Programs</strong></a> for <em>Open items</em></li>
<li>check the <em>Open item</em> programs do what's required</li>
<li>add acceptable <em>Open item</em> programs to CVS</li>
<li>update the status of accepted <em>Open items</em> to <em>Pending</em></li>
</ol>
<p>And we need them to</p>
<ol>
<li>remove slower less-elegant programs from CVS</li>
<li>update the status of removed <em>Closed items</em> to <em>Deleted</em></li>
</ol>

<p>And other chores listed in the <a href="miscfile.php?file=committerfaq&amp;title=Committer&nbsp;FAQ" title="Committer FAQ"><strong>Committer FAQ</strong></a>.</p>
<p>Do you have the necessary programming language knowledge?<br />
Do you want to help with the chores?</p>
<p>Contact us! Contact one of the <strong>Project Admins</strong> - listed on the GForge project page under <a href="http://alioth.debian.org/projects/shootout/"  title="Contact one of the Project Admins"><strong>Developer Info</strong></a>.</p>
</dd>
</dl>
</dd>



<dt><a href="#where" name="where">&nbsp;Where can I see&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#seemore" name="seemore">Where can I see more about a <strong>Timeout</strong> or <strong>Error</strong>?</a></dt>
<dd>
<p>Sometimes a program may produce correct results, within the timeout, for smaller workloads - so check the data on the <a href="fulldata.php?test=recursive&p1=ooc-0&p2=se-0&p3=gcc-0&p4=gpp-0" title="full data"><strong>full data page</strong></a>.</p>
<p>You may find information about an Error in the 'build &amp; benchmark results' section of the program page.</p>
</dd>

<dt><a href="#version" name="version">Where can I see which language version was used?</a></dt>
<dd><p>You can see information about the language implementation, including the version number, at the bottom of each <a href="benchmark.php?test=all&lang=gcc&lang2=gcc#about" title="about the C gcc language"><strong>language comparison page</strong></a>.</p>
</dd>

<dt><a href="#options" name="options">Where can I see which compiler and runtime options were used?</a></dt>
<dd><p>You can see the build commands and runtime commands on each program page in the 
<a href="benchmark.php?test=recursive&lang=gcc&id=0#log" title="build &amp; benchmark results"><strong>build &amp; benchmark results</strong></a> section.</p>
</dd>

<dt><a href="#arch" name="arch">Where can I see what other people think about the Language Shootout?</a></dt>
<dd><p>Google! Here's some <a href="http://groups-beta.google.com/group/comp.lang.functional/msg/ddb2894d9e3d8024?hl=en" title="comp.lang.functional"><strong>sensible criticism</strong></a> of the original Shootout.</p></dd>

<dt><a href="#downsource" name="downsource">Where can I see more?</a></dt>
<dd><p>The <strong>project is hosted</strong> by <a href="http://alioth.debian.org/projects/shootout"  title="The Great Computer Language Shootout project page on Alioth GForge at Debian.org">Alioth&nbsp;GForge Debian.org</a>.</p>
<p>You can <a href="http://alioth.debian.org/scm/?group_id=30402"  title="Browse the Great Computer Language Shootout CVS tree">browse the CVS tree</a>.</p>
<p>Build dependencies include <a href="http://search.cpan.org/~mjh/GTop-0.16/GTop.pod">GTop</a> and <a href="http://packages.debian.org/stable/perl/libbsd-resource-perl">BSD::Resource</a> </p>
</dd>
</dl>
</dd>




<dt><a href="#whydont" name="whydont">&nbsp;Why don't you&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#contest" name="contest">Why don't you accept every program that gives the correct result?</a></dt>
<dd><p>We are trying to show the performance of various programming language implementations - so we ask that contributed programs not only give the 
correct result, but also <strong>use the same algorithm</strong> to calculate that result.</p>
<p>Doug Bagley used both <em>same way</em> (same algorithm) and <em>same thing</em> (same result) benchmarks - so in many cases the performance
 differences were simply better algorithms.</p>
<p>After hearing many arguments, it seems <em>to me</em> that we should think of <em>same way</em> (same algorithm) tests as <strong>benchmarks</strong>, and
 we should think of <em>same thing</em> (same result) tests as <strong>contests</strong>.</p>
<p>At present, we are only trying to show benchmarks.</p>
</dd>

<dt><a href="#acceptable" name="acceptable">Why don't you include my favourite language?</a></dt>
<dd><p>Is the language implementation</p>
<ul>
<li><strong>Used?</strong> There are way too many dead languages and unused new languages - see <a href="http://people.ku.edu/~nkinners/LangList/Extras/langlist.htm">The Language List</a> and <a href="http://www.levenez.com/lang/">Computer Languages History</a></li>
<li><strong>Interesting?</strong> Is there something significant and interesting about the language, and will that be revealed by these simple benchmark programs?</li>
</ul>
<p>We will accept <strong>and reject</strong> languages in a capricious, unfair, biased fashion.</p>
</dd>

<dt><a href="#acceptablemore" name="acceptablemore">Why don't you include my favourite language?</a></dt>
<dd><p>Can the language implementation be used to write most of our benchmark programs?</p> 
<p><strong>Must have</strong></p>
<ol>
<li>A <a href="http://packages.debian.org/unstable/" title="Debian packages">Debian package</a> (either from Debian itself, or the primary authors of the language)
or a <a href="http://packages.gentoo.org/categories/" title="Gentoo ebuilds">Gentoo ebuild</a> or build and install with <tt>./configure &amp;&amp; make &amp;&amp; make install</tt> and a default target of <tt>/usr/local.</tt></li>
<li>Command-line argument handling.</li>
<li>32-bit Integers.</li>
<li>Double precision floating point numbers.</li>
<li>Line-oriented read &amp; write from stdin &amp; stdout.</li>
<li>Documentation.</li>
</ol>

<p><strong>Should have</strong></p>
<ol>
<li>Buffered stdio.</li>
<li>Dynamic hash tables and sequences (arrays or lists).</li>
<li>Regular Expressions (preferably Perl compatible).</li>
<li>Concurrency (threads, coroutines, &#8230;)</li>
<li>TCP/IP Sockets.</li>
</ol>
</dd>

<dt><a href="#please" name="please">Please will you include my favourite language?</a></dt>
<dd><p>Maybe we will when you write many benchmark programs in your favourite language, and contribute them to "The Computer Language Shootout" :-)</p>
<p>Browse <span class="sandbox"><a title="Alpha benchmarks and more language implementations" href="<?=SANDBOX_SITE;?>index.php" >&nbsp;The&nbsp;Sandbox&nbsp;</a></span> website to see if your favourite language is already shown.</p>
<p>Browse <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><strong>Feature Requests</strong></a> with Category <strong>New Language</strong> to see if it's already been suggested.
You'll see that several languages have been <em>suggested</em> but no one has contributed programs yet.</p>
</dd>
</dl>
</dd>



<dt><a href="#when" name="when">&nbsp;Who&#8230;? When&#8230;? Why&#8230;?</a></dt>
<dd>
<dl>
<dt><a href="#start" name="start">Who started "The Great Computer Language Shootout"?</a></dt>
<dd><p>Doug Bagley created <a href="http://web.archive.org/web/20040401204425/www.bagley.org/~doug/shootout/index2.shtml" title="Doug Bagley's website from the Internet Archive">"The Great Computer Language Shootout"</a>, and it was active until 2001.</p>
<p>Aldo Calpini ported that to create <a href="http://dada.perl.it/shootout/" title="The Computer Language Shootout for MS Windows programming languages">"The Great Win32 Computer Language Shootout"</a> - it was last updated June 2003.</p>
<p>In mid-2004 <strong>Brent Fulgham revived</strong> <a href="http://web.archive.org/web/20040611035744/http://shootout.alioth.debian.org/" title="Brent Fulgham's website from the Internet Archive">"The Great Computer Language Shootout"</a> here on Alioth&nbsp;Debian.org</p>
<p>In the following months, things started to change. The website was redesigned showing the original benchmarks in a new way; then benchmarks were deprecated and new benchmarks were added. We continue to experiment on <span class="sandbox"><a title="Alpha benchmarks and more language implementations" href="<?=SANDBOX_SITE;?>index.php" >&nbsp;The&nbsp;Sandbox&nbsp;</a></span> website.</p>
<p>In late-2005 Isaac Gouy started to experiment with the <span class="gp4"><a title="Browse the Gentoo : Intel&#174; Pentium&#174; Computer Language Shootout" href="<?=GP4_SITE;?>index.php" >&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span> website. Who knows where it will end?</p>
</dd>

<dt><a href="#ack" name="ack">Who has contributed?</a></dt>
<dd><p>So many people that we have an <a href="miscfile.php?file=acknowledgements&amp;title=acknowledgements" title="Acknowledgements to those who have contributed to The Great Computer Language Shootout">acknowledgements page</a>!</p></dd>

<dt><a href="#similar" name="similar">Who's working on similar projects?</a></dt>
<dd><p>Jack Andrews has started <a href="http://shootin.sourceforge.net/" title="Jack Andrew's shootin">"the shootin"</a>, 
and Adam Chlipala has started <a href="http://www.softwarescrutiny.net/ss/intro/" title="Adam Chlipala's Software Scrutiny">"Software Scrutiny"</a>.</p></dd>

<dt><a href="#finish" name="finish">When will the Language Shootout be finished?</a></dt>
<dd><p>Never. There will always be new languages, new versions of languages, more sensible benchmarks, faster more-elegant programs, new operating systems, better graphics&#8230; And the project team will change over time, and the measurements and presentation will change with them.</p>
</dd>

<dt><a href="#mycontributionagain" name="mycontributionagain">When will you include my contribution?</a></dt>
<dd>
<p>When we can! We already spend way-too-much personal-time on this website. Things get-done when they get-done. <a href="#status"><strong>&darr;&nbsp;Check the status</strong></a> and check the <strong>most recent measurement</strong> date on the website.</p>
</dd>

<dt><a href="#whydo" name="whydo">Why are you doing this?</a></dt>
<dd><p>To learn and to <strong>have fun</strong>.</p><p>We will continue as long as the fun holds out.</p></dd>
</dl>
</dd>
</dl>






